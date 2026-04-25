import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:l/l.dart';

typedef VmHttpHandler = Future<http.Response> Function(VmHttpRequestContext context);

abstract interface class VmHttpMiddleware {
  VmHttpHandler call(VmHttpHandler next);
}

final class VmHttpRequestContext {
  final String method;
  final Uri uri;
  final Map<String, String> headers;

  const VmHttpRequestContext({
    required this.method,
    required this.uri,
    required this.headers,
  });
}

final class VmHttpRetryOptions {
  final bool enabled;
  final int retries;
  final List<Duration> retryDelays;
  final bool Function(Object error, int attempt)? retryOnError;
  final bool Function(http.Response response, int attempt)? retryOnResponse;

  const VmHttpRetryOptions({
    this.enabled = true,
    this.retries = 2,
    this.retryDelays = const [
      Duration(milliseconds: 300),
      Duration(milliseconds: 900),
    ],
    this.retryOnError,
    this.retryOnResponse,
  });
}

final class VmHttpTimeoutOptions {
  final bool enabled;
  final Duration timeout;

  const VmHttpTimeoutOptions({
    this.enabled = true,
    this.timeout = const Duration(seconds: 30),
  });
}

final class VmHttpLoggerOptions {
  final bool enabled;
  final bool logRequest;
  final bool logResponse;
  final bool logError;
  final void Function(String message)? writeInfo;
  final void Function(String message, Object error, StackTrace stackTrace)? writeError;

  const VmHttpLoggerOptions({
    this.enabled = true,
    this.logRequest = false,
    this.logResponse = true,
    this.logError = true,
    this.writeInfo,
    this.writeError,
  });
}

final class VmHttpRetryMiddleware implements VmHttpMiddleware {
  final VmHttpRetryOptions options;

  const VmHttpRetryMiddleware([this.options = const VmHttpRetryOptions()]);

  @override
  VmHttpHandler call(VmHttpHandler next) {
    return (VmHttpRequestContext context) async {
      if (!options.enabled || options.retries < 1) {
        return next(context);
      }

      var attempt = 0;
      while (true) {
        try {
          final response = await next(context);
          if (attempt >= options.retries || !_shouldRetryResponse(response, attempt)) {
            return response;
          }
        } on Object catch (error) {
          if (attempt >= options.retries || !_shouldRetryError(error, attempt)) {
            rethrow;
          }
        }

        if (options.retryDelays.isNotEmpty) {
          final delayIndex = attempt.clamp(0, options.retryDelays.length - 1);
          await Future<void>.delayed(options.retryDelays[delayIndex]);
        }
        attempt++;
      }
    };
  }

  bool _shouldRetryResponse(http.Response response, int attempt) {
    final retryOnResponse = options.retryOnResponse;
    if (retryOnResponse != null) {
      return retryOnResponse(response, attempt);
    }

    return response.statusCode >= HttpStatus.internalServerError;
  }

  bool _shouldRetryError(Object error, int attempt) {
    final retryOnError = options.retryOnError;
    if (retryOnError != null) {
      return retryOnError(error, attempt);
    }

    return error is SocketException || error is http.ClientException || error is TimeoutException;
  }
}

final class VmHttpTimeoutMiddleware implements VmHttpMiddleware {
  final VmHttpTimeoutOptions options;

  const VmHttpTimeoutMiddleware([this.options = const VmHttpTimeoutOptions()]);

  @override
  VmHttpHandler call(VmHttpHandler next) {
    return (VmHttpRequestContext context) {
      final future = next(context);
      if (!options.enabled) {
        return future;
      }

      return future.timeout(options.timeout);
    };
  }
}

final class VmHttpLoggerMiddleware implements VmHttpMiddleware {
  final VmHttpLoggerOptions options;

  const VmHttpLoggerMiddleware([this.options = const VmHttpLoggerOptions()]);

  @override
  VmHttpHandler call(VmHttpHandler next) {
    return (VmHttpRequestContext context) async {
      final stopwatch = Stopwatch()..start();
      try {
        final response = await next(context);
        if (options.enabled && options.logResponse) {
          _writeInfo(
            'HTTP ${context.method} ${context.uri.path} ${response.statusCode} ${stopwatch.elapsedMilliseconds}ms',
          );
        }

        return response;
      } on Object catch (error, stackTrace) {
        if (options.enabled && options.logError) {
          _writeError(
            'HTTP ${context.method} ${context.uri.path} failed after ${stopwatch.elapsedMilliseconds}ms',
            error,
            stackTrace,
          );
        }

        rethrow;
      }
    };
  }

  void _writeInfo(String message) {
    final writeInfo = options.writeInfo;
    if (writeInfo != null) {
      writeInfo(message);
      return;
    }

    l.v5(message);
  }

  void _writeError(String message, Object error, StackTrace stackTrace) {
    final writeError = options.writeError;
    if (writeError != null) {
      writeError(message, error, stackTrace);
      return;
    }

    l.w('$message: $error', stackTrace);
  }
}
