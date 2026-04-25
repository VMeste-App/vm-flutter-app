import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:vm_app/src/core/network/vm_http_client.dart';
import 'package:vm_app/src/core/network/vm_http_exception.dart';
import 'package:vm_app/src/core/network/vm_http_middleware.dart';

void main() {
  group('VmHttpClient', () {
    test('get builds URL from base URI, path, and query parameters', () async {
      late final http.Request capturedRequest;
      final client = VmHttpClient(
        client: MockClient((http.Request request) async {
          capturedRequest = request;
          return http.Response('{"data":[]}', HttpStatus.ok);
        }),
        baseUri: Uri.parse('https://example.com/api?locale=ru'),
      );

      final result = await client.get(
        '/events',
        queryParameters: {
          'page': 1,
          'search': null,
          'from': DateTime.utc(2026),
        },
      );

      expect(result, <String, Object?>{'data': <Object?>[]});
      expect(capturedRequest.method, 'GET');
      expect(
        capturedRequest.url.toString(),
        'https://example.com/api/events?locale=ru&page=1&from=2026-01-01T00%3A00%3A00.000Z',
      );
      expect(capturedRequest.headers[HttpHeaders.acceptHeader], 'application/json');
    });

    test('post sends JSON body and content type', () async {
      late final http.Request capturedRequest;
      final client = VmHttpClient(
        client: MockClient((http.Request request) async {
          capturedRequest = request;
          return http.Response('{"id":1}', HttpStatus.created);
        }),
        baseUri: Uri.parse('https://example.com/api'),
      );

      final result = await client.post(
        'events',
        body: <String, Object?>{'title': 'Training'},
      );

      expect(result, <String, Object?>{'id': 1});
      expect(capturedRequest.method, 'POST');
      expect(capturedRequest.url.toString(), 'https://example.com/api/events');
      expect(capturedRequest.headers[HttpHeaders.contentTypeHeader], 'application/json; charset=utf-8');
      expect(jsonDecode(capturedRequest.body), <String, Object?>{'title': 'Training'});
    });

    test('returns empty JSON object for successful empty response body', () async {
      final client = VmHttpClient(
        client: MockClient((http.Request request) async {
          return http.Response('', HttpStatus.noContent);
        }),
        baseUri: Uri.parse('https://example.com/api'),
      );

      final result = await client.delete('events/1');

      expect(result, const <String, Object?>{});
    });

    test('throws VmBackendHttpException with structured backend error for non-success status codes', () async {
      final client = VmHttpClient(
        client: MockClient((http.Request request) async {
          return http.Response(
            '{"error":{"code":"validation_error","message":"Invalid email","details":{"field":"email"}}}',
            HttpStatus.unprocessableEntity,
          );
        }),
        baseUri: Uri.parse('https://example.com/api'),
        retryOptions: const VmHttpRetryOptions(enabled: false),
      );

      final call = client.get('profile/1');

      expect(
        call,
        throwsA(
          isA<VmBackendHttpException>()
              .having((VmHttpException error) => error.method, 'method', 'GET')
              .having(
                (VmBackendHttpException error) => error.statusCode,
                'statusCode',
                HttpStatus.unprocessableEntity,
              )
              .having((VmBackendHttpException error) => error.error.code, 'code', 'validation_error')
              .having((VmBackendHttpException error) => error.error.message, 'message', 'Invalid email')
              .having((VmBackendHttpException error) => error.error.details, 'details', <String, Object?>{
                'field': 'email',
              }),
        ),
      );
    });

    test('throws VmNetworkHttpException when the underlying client fails with a network error', () async {
      final client = VmHttpClient(
        client: MockClient((http.Request request) async {
          throw http.ClientException('Connection closed', request.url);
        }),
        baseUri: Uri.parse('https://example.com/api'),
        retryOptions: const VmHttpRetryOptions(enabled: false),
      );

      final call = client.get('events');

      expect(call, throwsA(isA<VmNetworkHttpException>()));
    });

    test('throws VmUnknownHttpException when successful response is not a JSON object', () async {
      final client = VmHttpClient(
        client: MockClient((http.Request request) async {
          return http.Response('[1,2,3]', HttpStatus.ok);
        }),
        baseUri: Uri.parse('https://example.com/api'),
      );

      final call = client.get('events');

      expect(call, throwsA(isA<VmUnknownHttpException>()));
    });

    test('postMultipart sends fields and file as multipart form data', () async {
      final tempDirectory = Directory.systemTemp.createTempSync('vm_http_client_test');
      final file = File('${tempDirectory.path}/avatar.txt')..writeAsStringSync('avatar-bytes');

      late final http.BaseRequest capturedRequest;
      late final String capturedBody;
      final client = VmHttpClient(
        client: MockClient.streaming((http.BaseRequest request, http.ByteStream bodyStream) async {
          capturedRequest = request;
          capturedBody = utf8.decode(await bodyStream.toBytes());
          return http.StreamedResponse(
            Stream<List<int>>.value(utf8.encode('{"uploaded":true}')),
            HttpStatus.ok,
          );
        }),
        baseUri: Uri.parse('https://example.com/api'),
      );

      try {
        final result = await client.postMultipart(
          '/profile/1/avatar',
          fieldName: 'photo',
          file: file,
          filename: 'avatar.txt',
          fields: const {'kind': 'avatar'},
        );

        expect(result, <String, Object?>{'uploaded': true});
        expect(capturedRequest.method, 'POST');
        expect(capturedRequest.url.toString(), 'https://example.com/api/profile/1/avatar');
        expect(capturedRequest.headers[HttpHeaders.contentTypeHeader], startsWith('multipart/form-data; boundary='));
        expect(capturedBody, contains('name="kind"'));
        expect(capturedBody, contains('avatar'));
        expect(capturedBody, contains('name="photo"'));
        expect(capturedBody, contains('filename="avatar.txt"'));
        expect(capturedBody, contains('avatar-bytes'));
      } finally {
        tempDirectory.deleteSync(recursive: true);
      }
    });

    test('uses default retry middleware and allows retry options to be configured', () async {
      var attempts = 0;
      final client = VmHttpClient(
        client: MockClient((http.Request request) async {
          attempts++;
          if (attempts == 1) {
            return http.Response('{"error":{"message":"Temporary unavailable"}}', HttpStatus.serviceUnavailable);
          }

          return http.Response('{"ok":true}', HttpStatus.ok);
        }),
        baseUri: Uri.parse('https://example.com/api'),
        retryOptions: const VmHttpRetryOptions(
          retries: 1,
          retryDelays: [Duration.zero],
        ),
      );

      final result = await client.get('events');

      expect(result, <String, Object?>{'ok': true});
      expect(attempts, 2);
    });

    test('uses default timeout middleware and allows timeout options to be configured', () async {
      final client = VmHttpClient(
        client: MockClient((http.Request request) async {
          await Future<void>.delayed(const Duration(milliseconds: 50));
          return http.Response('{"ok":true}', HttpStatus.ok);
        }),
        baseUri: Uri.parse('https://example.com/api'),
        retryOptions: const VmHttpRetryOptions(enabled: false),
        timeoutOptions: const VmHttpTimeoutOptions(timeout: Duration(milliseconds: 1)),
      );

      final call = client.get('events');

      expect(call, throwsA(isA<VmNetworkHttpException>()));
    });

    test('retries request timeouts when retry middleware is enabled', () async {
      var attempts = 0;
      final client = VmHttpClient(
        client: MockClient((http.Request request) async {
          attempts++;
          if (attempts == 1) {
            await Future<void>.delayed(const Duration(milliseconds: 50));
          }

          return http.Response('{"ok":true}', HttpStatus.ok);
        }),
        baseUri: Uri.parse('https://example.com/api'),
        retryOptions: const VmHttpRetryOptions(
          retries: 1,
          retryDelays: [Duration.zero],
        ),
        timeoutOptions: const VmHttpTimeoutOptions(timeout: Duration(milliseconds: 1)),
      );

      final result = await client.get('events');

      expect(result, <String, Object?>{'ok': true});
      expect(attempts, 2);
    });

    test('uses default logger middleware and allows logger options to be configured', () async {
      final logs = <String>[];
      final client = VmHttpClient(
        client: MockClient((http.Request request) async {
          return http.Response('{"ok":true}', HttpStatus.ok);
        }),
        baseUri: Uri.parse('https://example.com/api'),
        loggerOptions: VmHttpLoggerOptions(
          logRequest: true,
          writeInfo: logs.add,
        ),
      );

      await client.get('events');

      expect(logs, hasLength(2));
      expect(logs.first, contains('HTTP GET /api/events started'));
      expect(logs.last, contains('HTTP GET /api/events 200'));
    });

    test('supports custom middleware', () async {
      late final http.Request capturedRequest;
      final client = VmHttpClient(
        client: MockClient((http.Request request) async {
          capturedRequest = request;
          return http.Response('{"ok":true}', HttpStatus.ok);
        }),
        baseUri: Uri.parse('https://example.com/api'),
        middlewares: const [
          _HeaderMiddleware('x-test', 'yes'),
        ],
      );

      await client.get('events');

      expect(capturedRequest.headers['x-test'], 'yes');
    });
  });
}

final class _HeaderMiddleware implements VmHttpMiddleware {
  final String name;
  final String value;

  const _HeaderMiddleware(this.name, this.value);

  @override
  VmHttpHandler call(VmHttpHandler next) {
    return (VmHttpRequestContext context) {
      context.headers[name] = value;
      return next(context);
    };
  }
}
