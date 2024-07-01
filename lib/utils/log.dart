import 'dart:convert';

import 'package:elastic_client/elastic_client.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

enum LogLevel {
  trace,
  debug,
  info,
  warn,
  error,
  fatal;

  String toStringValue() {
    switch (this) {
      case trace:
        return 'TRACE';
      case debug:
        return 'DEBUG';
      case info:
        return 'INFO';
      case warn:
        return 'WARN';
      case error:
        return 'ERROR';
      case fatal:
        return 'FATAL';
      default:
        return '';
    }
  }
}

class Log {
  late final Logger _logger;
  late final Client _client;
  late final Map<String, dynamic> _schema;

  static Log init({
    required LogLevel minimumLevel,
    String? elasticSearchUrl,
    String? serviceEnvironment,
    String? serviceVersion,
  }) {
    final client = Client(
      HttpTransport(
        url: elasticSearchUrl,
      ),
    );

    final levelMap = <LogLevel, Level>{
      LogLevel.trace: Level.trace,
      LogLevel.debug: Level.debug,
      LogLevel.info: Level.info,
      LogLevel.warn: Level.warning,
      LogLevel.error: Level.error,
      LogLevel.fatal: Level.fatal,
    };

    final log = Log()
      .._logger = Logger(
        filter: ProductionFilter(),
        printer: _LogPrinter(),
        level: levelMap[minimumLevel] ?? Level.trace,
      )
      .._client = client
      .._schema = {
        'service': {
          'environment': serviceEnvironment,
          'version': serviceVersion,
        },
      };

    return log;
  }

  Future<void> debug(
    String message, {
    Map<String, dynamic>? args,
  }) async {
    _logger.d(message);
    await _ecsLog(LogLevel.debug, message, args);
  }

  Future<void> error(
    String message, {
    Map<String, dynamic>? args,
  }) async {
    _logger.e(message);
    await _ecsLog(LogLevel.error, message, args);
  }

  Future<void> fatal(
    String message, {
    Map<String, dynamic>? args,
  }) async {
    _logger.f(message);
    await _ecsLog(LogLevel.fatal, message, args);
  }

  Future<void> info(
    String message, {
    Map<String, dynamic>? args,
  }) async {
    _logger.i(message);
    await _ecsLog(LogLevel.info, message, args);
  }

  Future<void> trace(
    String message, {
    Map<String, dynamic>? args,
  }) async {
    _logger.t(message);
    await _ecsLog(LogLevel.trace, message, args);
  }

  Future<void> warn(
    String message, {
    Map<String, dynamic>? args,
  }) async {
    _logger.w(message);
    await _ecsLog(LogLevel.warn, message, args);
  }

  Future<void> _ecsLog(
    LogLevel level,
    String message,
    Map<String, dynamic>? args,
  ) async {
    final timestamp = DateTime.now().toUtc();

    final document = <String, dynamic>{
      '@timestamp': timestamp.toIso8601String(),
      '@level': level.toStringValue(),
      'message': message,
    };

    document.addAll(_schema);

    if (args != null) {
      document.addAll(args);
    }

    try {
      await _client
          .index(
            name: 'damz-web-${DateFormat.yMd().format(timestamp)}',
          )
          .updateDoc(
            doc: document,
          );

      // ignore: avoid_catching_errors
    } on Error catch (ex) {
      _logger.w(ex.toString(), stackTrace: ex.stackTrace);
    } on Exception catch (ex) {
      _logger.w(ex.toString());
    }
  }
}

class _LogPrinter extends LogPrinter {
  static final _levelColors = {
    Level.trace: const AnsiColor.fg(244),
    Level.debug: const AnsiColor.fg(40),
    Level.info: const AnsiColor.fg(39),
    Level.warning: const AnsiColor.fg(214),
    Level.error: const AnsiColor.fg(160),
    Level.fatal: const AnsiColor.fg(199),
  };

  static final _levelLabel = {
    Level.trace: '[TRACE]',
    Level.debug: '[DEBUG]',
    Level.info: '[INFO ]',
    Level.warning: '[WARN ]',
    Level.error: '[ERROR]',
    Level.fatal: '[FATAL]',
  };

  // static final _browserStackTraceRegex =
  //     RegExp(r'^(?:package:)?(dart:\S+|\S+)');
  // static final _deviceStackTraceRegex = RegExp(r'#[0-9]+\s+(.+) \((\S+)\)');
  // static final _webStackTraceRegex = RegExp(r'^((packages|dart-sdk)/\S+/)');

  @override
  List<String> log(LogEvent event) {
    final timeStr = _getTime(event.time);
    final messageStr = _stringifyMessage(event.message);
    final errorStr = event.error?.toString();
    String? stackTraceStr;
    // stackTraceStr = formatStackTrace(
    //   event.stackTrace ?? StackTrace.current,
    //   8,
    // );

    return _formatAndPrint(
      timeStr,
      event.level,
      messageStr,
      errorStr,
      stackTraceStr,
    );
  }

  List<String> _formatAndPrint(
    String time,
    Level level,
    String message,
    String? error,
    String? stacktrace,
  ) {
    final buffer = <String>[];

    final levelLabel = _getLevelColor(level)(_getLevelLabel(level));

    for (final line in message.split('\n')) {
      buffer.add('[$time]$levelLabel$line');
    }

    if (error != null) {
      for (final line in error.split('\n')) {
        buffer.add(line);
      }
    }

    if (stacktrace != null) {
      for (final line in stacktrace.split('\n')) {
        buffer.add(line);
      }
    }

    return buffer;
  }

  AnsiColor _getLevelColor(Level level) {
    return _levelColors[level] ?? const AnsiColor.none();
  }

  String _getLevelLabel(Level level) {
    final label = _levelLabel[level];
    return (label != null) ? ' $label ' : ' ';
  }

  String _getTime(DateTime time) {
    String threeDigits(int n) {
      if (n >= 100) {
        return '$n';
      }
      if (n >= 10) {
        return '0$n';
      }
      return '00$n';
    }

    String twoDigits(int n) {
      if (n >= 10) {
        return '$n';
      }
      return '0$n';
    }

    final now = time;
    final h = twoDigits(now.hour);
    final min = twoDigits(now.minute);
    final sec = twoDigits(now.second);
    final ms = threeDigits(now.millisecond);
    return '$h:$min:$sec.$ms';
  }

  String _stringifyMessage(dynamic message) {
    // ignore: avoid_dynamic_calls
    final finalMessage = message is Function ? message() : message;
    if (finalMessage is Map || finalMessage is Iterable) {
      final encoder = JsonEncoder.withIndent('  ', (object) {
        return object.toString();
      });
      return encoder.convert(finalMessage);
    } else {
      return finalMessage.toString();
    }
  }
}
