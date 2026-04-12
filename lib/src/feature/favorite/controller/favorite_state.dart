part of 'favorite_controller.dart';

sealed class FavoriteState<V extends Object, Id extends Object> extends _FavoriteStateBase<V, Id>
    with _FavoriteStateShortcuts<V, Id> {
  const FavoriteState({
    required super.ids,
    required super.values,
  });

  const factory FavoriteState.idle({required Set<Id> ids, required List<V> values}) = FavoriteState$Idle;

  const factory FavoriteState.processing({required Set<Id> ids, required List<V> values}) = FavoriteState$Processing;

  const factory FavoriteState.success({required Set<Id> ids, required List<V> values}) = FavoriteState$Success;

  const factory FavoriteState.error(Object error, {required Set<Id> ids, required List<V> values}) =
      FavoriteState$Error;
}

// --- States's helper classes ---
final class FavoriteState$Idle<V extends Object, Id extends Object> extends FavoriteState<V, Id> {
  const FavoriteState$Idle({
    required super.ids,
    required super.values,
  });
}

final class FavoriteState$Processing<V extends Object, Id extends Object> extends FavoriteState<V, Id> {
  const FavoriteState$Processing({
    required super.ids,
    required super.values,
  });
}

final class FavoriteState$Success<V extends Object, Id extends Object> extends FavoriteState<V, Id> {
  const FavoriteState$Success({
    required super.ids,
    required super.values,
  });
}

final class FavoriteState$Error<V extends Object, Id extends Object> extends FavoriteState<V, Id> {
  const FavoriteState$Error(
    this.error, {
    required super.ids,
    required super.values,
  });

  final Object error;
}

// --- State's shortcuts ---
base mixin _FavoriteStateShortcuts<V extends Object, Id extends Object> on _FavoriteStateBase<V, Id> {
  FavoriteState<V, Id> idle({Set<Id>? ids, List<V>? values}) => FavoriteState<V, Id>.idle(
    ids: ids ?? this.ids,
    values: values ?? this.values,
  );

  FavoriteState<V, Id> processing() => FavoriteState<V, Id>.processing(ids: ids, values: values);

  FavoriteState<V, Id> success({Set<Id>? ids, List<V>? values}) => FavoriteState<V, Id>.success(
    ids: ids ?? this.ids,
    values: values ?? this.values,
  );

  FavoriteState<V, Id> errorState(Object error) => FavoriteState<V, Id>.error(error, ids: ids, values: values);
}

// --- State's base class ---
@immutable
abstract base class _FavoriteStateBase<V extends Object, Id extends Object> {
  const _FavoriteStateBase({
    required this.ids,
    required this.values,
  });

  final Set<Id> ids;
  final List<V> values;
}
