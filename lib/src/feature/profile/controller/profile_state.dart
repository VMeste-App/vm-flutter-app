import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/event/model/event.dart';

@immutable
sealed class ProfileState extends _ProfileStateBase with _ProfileStateShortcuts {
  const ProfileState({super.event});

  const factory ProfileState.idle({VmEvent? event}) = ProfileStateIdle;

  const factory ProfileState.processing({VmEvent? event}) = ProfileStateProcessing;

  const factory ProfileState.success({VmEvent event}) = ProfileStateSuccess;

  const factory ProfileState.error(Object error, {VmEvent? event}) = ProfileStateError;
}

// --- States's helper classes ---
final class ProfileStateIdle extends ProfileState {
  const ProfileStateIdle({super.event});
}

final class ProfileStateProcessing extends ProfileState {
  const ProfileStateProcessing({super.event});
}

final class ProfileStateSuccess extends ProfileState {
  const ProfileStateSuccess({super.event});
}

final class ProfileStateError extends ProfileState {
  const ProfileStateError(this.error, {super.event});

  final Object error;
}

// --- State's shortcuts ---
base mixin _ProfileStateShortcuts on _ProfileStateBase {
  ProfileState idle() => ProfileState.idle(event: event);

  ProfileState processing() => ProfileState.processing(event: event);

  ProfileState success(VmEvent event) => ProfileState.success(event: event);

  ProfileState errorState(Object error) => ProfileState.error(error, event: event);
}

// --- State's base class ---
@immutable
abstract base class _ProfileStateBase {
  const _ProfileStateBase({this.event});

  final VmEvent? event;

  R map<R>({
    required _VmStateMatch<R, ProfileStateIdle> idle,
    required _VmStateMatch<R, ProfileStateProcessing> processing,
    required _VmStateMatch<R, ProfileStateSuccess> success,
    required _VmStateMatch<R, ProfileStateError> error,
  }) => switch (this) {
    final ProfileStateIdle s => idle(s),
    final ProfileStateProcessing s => processing(s),
    final ProfileStateSuccess s => success(s),
    final ProfileStateError s => error(s),
    _ => throw AssertionError(),
  };

  R maybeMap<R>({
    required R Function() orElse,
    _VmStateMatch<R, ProfileStateIdle>? idle,
    _VmStateMatch<R, ProfileStateProcessing>? processing,
    _VmStateMatch<R, ProfileStateSuccess>? success,
    _VmStateMatch<R, ProfileStateError>? error,
  }) => map<R>(
    idle: idle ?? (_) => orElse(),
    processing: processing ?? (_) => orElse(),
    success: success ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    _VmStateMatch<R, ProfileStateIdle>? idle,
    _VmStateMatch<R, ProfileStateProcessing>? processing,
    _VmStateMatch<R, ProfileStateSuccess>? success,
    _VmStateMatch<R, ProfileStateError>? error,
  }) => map<R?>(
    idle: idle ?? (_) => null,
    processing: processing ?? (_) => null,
    success: success ?? (_) => null,
    error: error ?? (_) => null,
  );
}

// --- Helpers for matching ---
typedef _VmStateMatch<R, S extends ProfileState> = R Function(S state);
