import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';

@immutable
sealed class ProfileState extends _ProfileStateBase with _ProfileStateShortcuts {
  const ProfileState({super.profile});

  const factory ProfileState.idle({Profile? profile}) = ProfileStateIdle;

  const factory ProfileState.processing({Profile? profile}) = ProfileStateProcessing;

  const factory ProfileState.success({Profile profile}) = ProfileStateSuccess;

  const factory ProfileState.error(Object error, {Profile? profile}) = ProfileStateError;
}

// --- States's helper classes ---
final class ProfileStateIdle extends ProfileState {
  const ProfileStateIdle({super.profile});
}

final class ProfileStateProcessing extends ProfileState {
  const ProfileStateProcessing({super.profile});
}

final class ProfileStateSuccess extends ProfileState {
  const ProfileStateSuccess({super.profile});
}

final class ProfileStateError extends ProfileState {
  const ProfileStateError(this.error, {super.profile});

  final Object error;
}

// --- State's shortcuts ---
base mixin _ProfileStateShortcuts on _ProfileStateBase {
  ProfileState idle() => ProfileState.idle(profile: profile);

  ProfileState processing() => ProfileState.processing(profile: profile);

  ProfileState success(Profile profile) => ProfileState.success(profile: profile);

  ProfileState errorState(Object error) => ProfileState.error(error, profile: profile);
}

// --- State's base class ---
@immutable
abstract base class _ProfileStateBase {
  const _ProfileStateBase({this.profile});

  final Profile? profile;

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
