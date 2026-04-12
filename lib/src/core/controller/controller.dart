import 'package:control/control.dart';

abstract base class VmController<T extends Object> = StateController<T> with SequentialControllerHandler;
