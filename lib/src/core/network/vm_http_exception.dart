import 'package:vm_app/src/core/model/typedefs.dart';

sealed class VmHttpException implements Exception {
  final String method;
  final Uri uri;

  const VmHttpException({
    required this.method,
    required this.uri,
  });
}

final class VmBackendError {
  final String code;
  final String message;
  final Json? details;

  const VmBackendError({
    required this.code,
    required this.message,
    this.details,
  });

  factory VmBackendError.fromJson(Json json, {required int statusCode}) {
    final source = switch (json) {
      {'error': final Json error} => error,
      _ => json,
    };

    return VmBackendError(
      code: switch (source['code']) {
        final String code => code,
        _ => 'http_$statusCode',
      },
      message: switch (source['message']) {
        final String message => message,
        _ => 'Request failed with status $statusCode',
      },
      details: switch (source['details']) {
        final Json details => details,
        _ => null,
      },
    );
  }

  @override
  String toString() => '$code: $message';
}

final class VmBackendHttpException extends VmHttpException {
  final int statusCode;
  final VmBackendError error;
  final String responseBody;

  const VmBackendHttpException({
    required super.method,
    required super.uri,
    required this.statusCode,
    required this.error,
    required this.responseBody,
  });

  @override
  String toString() {
    return 'VmBackendHttpException: $method $uri failed with status $statusCode. Backend error: $error';
  }
}

final class VmNetworkHttpException extends VmHttpException {
  final Object error;
  final StackTrace stackTrace;

  const VmNetworkHttpException({
    required super.method,
    required super.uri,
    required this.error,
    required this.stackTrace,
  });

  @override
  String toString() => 'VmNetworkHttpException: $method $uri failed due to a network error. Error: $error';
}

final class VmUnknownHttpException extends VmHttpException {
  final Object error;
  final StackTrace stackTrace;

  const VmUnknownHttpException({
    required super.method,
    required super.uri,
    required this.error,
    required this.stackTrace,
  });

  @override
  String toString() => 'VmUnknownHttpException: $method $uri failed unexpectedly. Error: $error';
}
