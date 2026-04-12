abstract final class AppConfig {
  static const apiUrl = String.fromEnvironment('API_URL');
  static const proxy = String.fromEnvironment('PROXY');
  static const mapkitApiKey = String.fromEnvironment('MAPKIT_API_KEY');
}
