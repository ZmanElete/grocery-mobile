import 'dart:developer' as dev;
import 'dart:async';

mixin Logging {
  /// The name to show for logging purposes. By default it prints the class name.
  String get loggingName => runtimeType.toString();

  /// The minimum log level to print off.
  /// Setting the log level to [LogLevel.info] shows all logs
  /// that are marked with [LogLevel.info] and more severe
  /// IE [LogLevel.warning], [LogLevel.severe], [LogLevel.critical] (technically [LogLevel.off])
  /// look at the definition of LogLevel to see the varying degrees.
  LogLevel get logLevel => LogLevel.info;

  void log(
    String message, {
    DateTime? time,
    int? sequenceNumber,
    LogLevel level = LogLevel.info,
    String? name,
    Zone? zone,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (level >= logLevel) {
      dev.log(
        '[${name ?? loggingName}] $message',
        time: time,
        sequenceNumber: sequenceNumber,
        level: level.value,
        name: DateTime.now().millisecondsSinceEpoch.toString(),
        zone: zone,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

class Logger with Logging {
  @override
  final LogLevel logLevel;

  @override
  final String loggingName;

  const Logger(
    this.loggingName, {
    this.logLevel = LogLevel.info,
  });
}

/// A log level defines the severity of the message. Some messages are extremely low priority and should only be shown if debugging
/// Others are more high priority pointing out breakages or the like.
enum LogLevel {
  /// References all log messages. Messages with this tag will only show if level is set to all
  all(0),

  /// Logs that express the finest details of an operation
  finest(300),

  /// Logs that express the finer details of an operation
  finer(400),

  /// Logs that express fine details of an operation
  fine(500),

  /// Logs used to express configuration occurring and/or not occurring (skipping configurations)
  config(700),

  /// Basic logs to say that something is happening. These tend to be high level.
  /// Generally only a single info log per operation is recommended
  /// to ensure that the logging does not get too loud.
  info(800),

  /// Logs that warn the developer of an occurrence that is relatively low priority.
  warning(900),

  /// Logs that warn the developer of an occurrence that is somewhat high priority.
  severe(1000),

  /// Logs that warn the developer that something has broken, or something that should not be happen has happened.
  critical(1200),

  /// Turn off logging or print even if logging is turned off.
  off(2000);

  /// The relative value used to define the difference between the levels. It is passed into developer log.
  /// Copied from the Logging pub.dev package and repurposed for our uses.
  /// https://github.com/dart-lang/logging/blob/e04942dadc6ed9ed177ab0c6b8d0e80a789cd176/lib/src/level.dart#L27
  final int value;
  const LogLevel(this.value);

  bool operator <(other) {
    if (other is LogLevel) {
      return value < other.value;
    } else if (other is num) {
      return value < other;
    }
    throw Exception(
        '[LogLevel operator <] Invalid type. ${other.runtimeType} is not a valid type to compare with LogLevel');
  }

  bool operator <=(other) {
    if (other is LogLevel) {
      return value <= other.value;
    } else if (other is num) {
      return value <= other;
    }
    throw Exception(
        '[LogLevel operator <=] Invalid type. ${other.runtimeType} is not a valid type to compare with LogLevel');
  }

  bool operator >(other) {
    if (other is LogLevel) {
      return value > other.value;
    } else if (other is num) {
      return value > other;
    }
    throw Exception(
        '[LogLevel operator >] Invalid type. ${other.runtimeType} is not a valid type to compare with LogLevel');
  }

  bool operator >=(other) {
    if (other is LogLevel) {
      return value >= other.value;
    } else if (other is num) {
      return value >= other;
    }
    throw Exception(
        '[LogLevel operator >=] Invalid type. ${other.runtimeType} is not a valid type to compare with LogLevel');
  }
}
