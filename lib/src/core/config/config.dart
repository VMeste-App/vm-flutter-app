enum AppEnvironment {
  test,
  prod,
  fake
  ;

  static AppEnvironment parse(String value) {
    return switch (value.toLowerCase()) {
      'test' => AppEnvironment.test,
      'prod' => AppEnvironment.prod,
      'fake' => AppEnvironment.fake,
      _ => AppEnvironment.test,
    };
  }
}

abstract final class AppConfig {
  static const environmentName = String.fromEnvironment('APP_ENV', defaultValue: 'test');
  static final environment = AppEnvironment.parse(environmentName);

  static const apiUrl = String.fromEnvironment('API_URL');
  static const proxy = String.fromEnvironment('PROXY');
  static const mapkitApiKey = String.fromEnvironment('MAPKIT_API_KEY');
}
