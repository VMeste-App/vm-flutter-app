import 'dart:io';

import 'package:cronet_http/cronet_http.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:vm_app/src/core/network/client/http_client.dart';

Client createClient([String? proxy]) {
  if (proxy != null) {
    return IOClient(createHttpClient(proxy));
  }

  if (Platform.isAndroid) {
    return CronetClient.fromCronetEngine(CronetEngine.build());
  }

  if (Platform.isIOS || Platform.isMacOS) {
    return CronetClient.fromCronetEngine(CronetEngine.build());
  }

  return IOClient(createHttpClient(proxy));
}
