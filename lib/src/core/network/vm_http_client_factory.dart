import 'package:vm_app/src/core/network/client/client.dart';
import 'package:vm_app/src/core/network/vm_http_client.dart';
import 'package:vm_app/src/core/network/vm_http_client_options.dart';

abstract final class VmHttpClientFactory {
  static VmHttpClient create(VmHttpClientOptions options) {
    return VmHttpClient(
      client: createClient(options.proxy),
      baseUri: options.baseUri,
      middlewares: options.middlewares,
      retryOptions: options.retryOptions,
      timeoutOptions: options.timeoutOptions,
      loggerOptions: options.loggerOptions,
    );
  }
}
