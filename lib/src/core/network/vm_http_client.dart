import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:vm_app/src/core/model/typedefs.dart';
import 'package:vm_app/src/core/network/vm_http_exception.dart';
import 'package:vm_app/src/core/network/vm_http_middleware.dart';

final class VmHttpClient {
  final http.Client _client;
  final Uri _baseUri;
  final List<VmHttpMiddleware> _middlewares;

  VmHttpClient({
    required http.Client client,
    required Uri baseUri,
    List<VmHttpMiddleware>? middlewares,
    VmHttpRetryOptions retryOptions = const VmHttpRetryOptions(),
    VmHttpTimeoutOptions timeoutOptions = const VmHttpTimeoutOptions(),
    VmHttpLoggerOptions loggerOptions = const VmHttpLoggerOptions(),
  }) : _client = client,
       _baseUri = _normalizeBaseUri(baseUri),
       _middlewares =
           middlewares ??
           [
             VmHttpRetryMiddleware(retryOptions),
             VmHttpTimeoutMiddleware(timeoutOptions),
             VmHttpLoggerMiddleware(loggerOptions),
           ];

  Future<Json> get(
    String path, {
    Map<String, Object?>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _send(
      method: 'GET',
      path: path,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<Json> post(
    String path, {
    Object? body,
    Map<String, Object?>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _send(
      method: 'POST',
      path: path,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<Json> put(
    String path, {
    Object? body,
    Map<String, Object?>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _send(
      method: 'PUT',
      path: path,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<Json> delete(
    String path, {
    Object? body,
    Map<String, Object?>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _send(
      method: 'DELETE',
      path: path,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<Json> postMultipart(
    String path, {
    required String fieldName,
    required File file,
    String? filename,
    Map<String, String>? fields,
    Map<String, Object?>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(path, queryParameters);
    final requestHeaders = <String, String>{
      if (headers != null) ...headers,
    };
    final context = VmHttpRequestContext(
      method: 'POST',
      uri: uri,
      headers: requestHeaders,
    );

    return _sendRequest(
      context: context,
      send: () async {
        final request = http.MultipartRequest('POST', uri);

        request.headers.addAll(requestHeaders);
        if (fields != null) {
          request.fields.addAll(fields);
        }

        final multipartFile = await http.MultipartFile.fromPath(fieldName, file.path, filename: filename);
        request.files.add(multipartFile);

        final streamedResponse = await _client.send(request);
        return http.Response.fromStream(streamedResponse);
      },
    );
  }

  void close() => _client.close();

  Future<Json> _send({
    required String method,
    required String path,
    Object? body,
    Map<String, Object?>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(path, queryParameters);
    final requestHeaders = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      if (headers != null) ...headers,
      if (body != null) HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    };
    final encodedBody = body != null ? jsonEncode(body) : null;

    final context = VmHttpRequestContext(
      method: method,
      uri: uri,
      headers: requestHeaders,
    );

    return _sendRequest(
      context: context,
      send: () async {
        final request = http.Request(method, uri)
          ..headers.addAll(requestHeaders)
          ..body = encodedBody ?? '';

        final streamedResponse = await _client.send(request);
        return http.Response.fromStream(streamedResponse);
      },
    );
  }

  Future<Json> _sendRequest({
    required VmHttpRequestContext context,
    required Future<http.Response> Function() send,
  }) async {
    try {
      final response = await _execute(context: context, send: send);
      return _readJsonResponse(method: context.method, uri: context.uri, response: response);
    } on VmHttpException {
      rethrow;
    } on TimeoutException catch (error, stackTrace) {
      throw VmNetworkHttpException(method: context.method, uri: context.uri, error: error, stackTrace: stackTrace);
    } on SocketException catch (error, stackTrace) {
      throw VmNetworkHttpException(method: context.method, uri: context.uri, error: error, stackTrace: stackTrace);
    } on http.ClientException catch (error, stackTrace) {
      throw VmNetworkHttpException(method: context.method, uri: context.uri, error: error, stackTrace: stackTrace);
    } on Object catch (error, stackTrace) {
      throw VmUnknownHttpException(method: context.method, uri: context.uri, error: error, stackTrace: stackTrace);
    }
  }

  Future<http.Response> _execute({
    required VmHttpRequestContext context,
    required Future<http.Response> Function() send,
  }) {
    VmHttpHandler handler = (_) => send();

    for (final middleware in _middlewares.reversed) {
      handler = middleware(handler);
    }

    return handler(context);
  }

  Json _readJsonResponse({
    required String method,
    required Uri uri,
    required http.Response response,
  }) {
    if (response.statusCode < HttpStatus.ok || response.statusCode >= HttpStatus.multipleChoices) {
      throw VmBackendHttpException(
        method: method,
        uri: uri,
        statusCode: response.statusCode,
        error: _parseBackendError(response),
        responseBody: response.body,
      );
    }

    if (response.body.isEmpty) {
      return const {};
    }

    final decoded = jsonDecode(response.body);
    if (decoded case final Json json) {
      return json;
    }

    throw FormatException('Expected JSON object response', response.body);
  }

  VmBackendError _parseBackendError(http.Response response) {
    if (response.body.isEmpty) {
      return VmBackendError.fromJson(const {}, statusCode: response.statusCode);
    }

    try {
      final decoded = jsonDecode(response.body);
      if (decoded case final Json json) {
        return VmBackendError.fromJson(json, statusCode: response.statusCode);
      }
    } on FormatException {
      return VmBackendError.fromJson(const {}, statusCode: response.statusCode);
    }

    return VmBackendError.fromJson(const {}, statusCode: response.statusCode);
  }

  Uri _buildUri(String path, Map<String, Object?>? queryParameters) {
    final normalizedPath = path.startsWith('/') ? path.substring(1) : path;
    final uri = _baseUri.resolve(normalizedPath);
    final requestQueryParameters = _stringifyQueryParameters(queryParameters);

    if (_baseUri.queryParameters.isEmpty && requestQueryParameters.isEmpty) {
      return uri;
    }

    return uri.replace(
      queryParameters: {
        ..._baseUri.queryParameters,
        ...requestQueryParameters,
      },
    );
  }

  static Uri _normalizeBaseUri(Uri baseUri) {
    if (baseUri.path.endsWith('/')) {
      return baseUri;
    }

    return baseUri.replace(path: '${baseUri.path}/');
  }

  static Map<String, String> _stringifyQueryParameters(Map<String, Object?>? queryParameters) {
    if (queryParameters == null) {
      return const {};
    }

    return {
      for (final entry in queryParameters.entries)
        if (entry.value != null) entry.key: _stringifyQueryValue(entry.value!),
    };
  }

  static String _stringifyQueryValue(Object value) {
    if (value case final DateTime dateTime) {
      return dateTime.toIso8601String();
    }

    return value.toString();
  }
}
