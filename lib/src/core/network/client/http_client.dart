import 'dart:io';

HttpClient createHttpClient([String? proxy]) {
  final client = HttpClient();

  if (proxy != null && proxy.isNotEmpty) {
    client.findProxy = (_) => 'PROXY $proxy';
  }

  return client
    ..maxConnectionsPerHost = 5
    ..connectionTimeout = const Duration(seconds: 10)
    ..idleTimeout = const Duration(seconds: 15)
    // Установить true для отключения проверки сертификата.
    ..badCertificateCallback = (X509Certificate cert, String host, int port) => false;
}
