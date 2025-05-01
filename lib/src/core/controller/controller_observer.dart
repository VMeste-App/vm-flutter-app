import 'package:control/control.dart';
import 'package:l/l.dart';

/// Observer for [Controller], react to changes in the any controller.
final class ControllerObserver implements IControllerObserver {
  const ControllerObserver();

  @override
  void onCreate(Controller controller) {
    l.v6('Controller | ${controller.runtimeType} | Created');
  }

  @override
  void onDispose(Controller controller) {
    l.v5('Controller | ${controller.runtimeType} | Disposed');
  }

  @override
  void onStateChanged<S extends Object>(StateController<S> controller, S prevState, S nextState) {
    final buffer =
        StringBuffer()
          ..writeln('Controller | ${controller.runtimeType} | ${prevState.runtimeType} -> ${nextState.runtimeType}')
          ..writeln('Previous State: $prevState')
          ..writeln('New State: $nextState');

    l.i(buffer.toString());
  }

  @override
  void onError(Controller controller, Object error, StackTrace stackTrace) {
    // TODO: Add to log stack trace.
    l.w('Controller | ${controller.runtimeType} | $error', stackTrace);
  }

  @override
  void onHandler(HandlerContext context) {
    // TODO: implement onHandler
  }
}
