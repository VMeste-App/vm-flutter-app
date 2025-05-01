import 'package:flutter/foundation.dart';
import 'package:l/l.dart';
import 'package:stack_trace/stack_trace.dart';

abstract base class LogUtils {
  /// Handy method to log [FlutterError].
  static void logFlutterError(FlutterErrorDetails details) {
    if (details.silent) return;

    final description = details.exceptionAsString();
    final stack = details.stack;
    final stackTrace = stack != null ? Trace.from(stack).terse : null;
    l.e('Flutter Error: $description', stackTrace);
  }

  /// Handy method to log [PlatformDispatcher] error.
  static bool logPlatformDispatcherError(Object error, StackTrace stackTrace) {
    l.e('Platform Dispatcher Error: $error', Trace.from(stackTrace).terse);

    return true;
  }

  /// Handy method to log Top-level error.
  static bool logTopLevelError(Object error, Chain chain) {
    l.e('Top-level Error: $error', chain.terse);

    return true;
  }

  /// Handy method to log initialization error.
  static void logInitializationError(Object error, StackTrace stackTrace) {
    l.e('Initialization error: $error', Trace.from(stackTrace).terse);
  }

  // TODO: Use this.
  static String formatError(String message, Object error, StackTrace? stackTrace) {
    final trace = stackTrace ?? StackTrace.current;

    final buffer =
        StringBuffer(message)
          ..write(' error: ')
          ..writeln(error)
          ..writeln('Stack trace:')
          ..write(Trace.from(trace).terse);

    return buffer.toString();
  }

  // TODO: Use this.
  static String formatLogMessage(LogMessage log) {
    final buffer =
        StringBuffer()
          ..write(log.level.emoji)
          ..write(' ')
          ..write(log.timestamp.formatTime())
          ..write(' | ')
          ..write(log.message);

    return buffer.toString();
  }
}

extension on DateTime {
  /// Transforms DateTime to String with format: 00:00:00
  String formatTime() => [hour, minute, second].map((i) => i.toString().padLeft(2, '0')).join(':');
}

extension on LogLevel {
  /// Transforms [LogLevel] to emoji
  String get emoji => switch (level) {
    0 => '🔴',
    1 => '🔥',
    2 => '⚠️',
    3 => '💡',
    4 => '🐛',
    _ => '🔬',
  };
}
