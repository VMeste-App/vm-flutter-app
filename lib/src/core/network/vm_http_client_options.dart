import 'package:vm_app/src/core/network/vm_http_middleware.dart';

final class VmHttpClientOptions {
  final Uri baseUri;
  final String? proxy;
  final List<VmHttpMiddleware>? middlewares;
  final VmHttpRetryOptions retryOptions;
  final VmHttpTimeoutOptions timeoutOptions;
  final VmHttpLoggerOptions loggerOptions;

  const VmHttpClientOptions({
    required this.baseUri,
    this.proxy,
    this.middlewares,
    this.retryOptions = const VmHttpRetryOptions(),
    this.timeoutOptions = const VmHttpTimeoutOptions(),
    this.loggerOptions = const VmHttpLoggerOptions(),
  });
}
