enum AppEnvironmentName {
  development,
  staging,
  production;

  static AppEnvironmentName parse(String value) {
    return AppEnvironmentName.values.firstWhere(
      (environment) => environment.name == value.toLowerCase(),
      orElse: () => development,
    );
  }
}

enum AppLogLevel {
  debug,
  info,
  warning,
  error,
  off;

  static AppLogLevel parse(String value) {
    return AppLogLevel.values.firstWhere(
      (level) => level.name == value.toLowerCase(),
      orElse: () => info,
    );
  }
}

class AppEnvironment {
  const AppEnvironment({
    required this.name,
    required this.logLevel,
    required this.enableDeveloperTools,
    this.remoteEndpointIdentifier,
  });

  factory AppEnvironment.fromDartDefines() {
    const environmentName = String.fromEnvironment(
      'APP_ENV',
      defaultValue: 'development',
    );
    const logLevel = String.fromEnvironment('LOG_LEVEL', defaultValue: 'info');
    const endpointIdentifier = String.fromEnvironment(
      'REMOTE_ENDPOINT_IDENTIFIER',
    );

    return AppEnvironment(
      name: AppEnvironmentName.parse(environmentName),
      logLevel: AppLogLevel.parse(logLevel),
      enableDeveloperTools: const bool.fromEnvironment(
        'ENABLE_DEVELOPER_TOOLS',
      ),
      remoteEndpointIdentifier: endpointIdentifier.isEmpty
          ? null
          : endpointIdentifier,
    );
  }

  final AppEnvironmentName name;
  final AppLogLevel logLevel;
  final bool enableDeveloperTools;
  final String? remoteEndpointIdentifier;
}
