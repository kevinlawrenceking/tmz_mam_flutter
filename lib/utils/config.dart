import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tmz_damz/utils/log.dart';

class Config {
  static Config? _instance;
  static Config get instance => Config.init();

  final LogConfig log;
  final ServiceConfig service;

  Config._({
    required this.log,
    required this.service,
  });

  factory Config.init() {
    if (Config._instance != null) {
      return Config._instance!;
    }

    final cfg = Config._(
      log: LogConfig.init(),
      service: ServiceConfig.init(),
    );

    Config._instance = cfg;

    return cfg;
  }
}

class LogConfig {
  final String url;
  final LogLevel minimumLevel;

  LogConfig._({
    required this.url,
    required this.minimumLevel,
  });

  factory LogConfig.init() {
    final levelMap = <String, LogLevel>{
      'TRACE': LogLevel.trace,
      'DEBUG': LogLevel.debug,
      'INFO': LogLevel.info,
      'WARN': LogLevel.warn,
      'ERROR': LogLevel.error,
      'FATAL': LogLevel.fatal,
    };

    final cfg = LogConfig._(
      url: dotenv.env['LOGGING_ELASTICSEARCH_URL'] ?? 'localhost',
      minimumLevel: levelMap[
              dotenv.env['LOGGING_MINIMUM_LEVEL']?.toUpperCase() ?? 'TRACE'] ??
          LogLevel.trace,
    );

    return cfg;
  }
}

class ServiceConfig {
  final String host;
  final int port;
  final bool secure;

  String get apiBaseAddress => 'http${secure ? 's' : ''}://$host:$port';
  String get apiBaseUrl => '$apiBaseAddress/api/v1';

  ServiceConfig._({
    required this.host,
    required this.port,
    required this.secure,
  });

  factory ServiceConfig.init() {
    final cfg = ServiceConfig._(
      host: dotenv.env['SERVER_HOST'] ?? 'localhost',
      port: int.tryParse(dotenv.env['SERVER_PORT'] ?? '3000') ?? 3000,
      secure: dotenv.env['SERVER_SECURE']?.toLowerCase() == 'true',
    );

    return cfg;
  }
}
