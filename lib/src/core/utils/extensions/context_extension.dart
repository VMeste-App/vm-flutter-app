import 'package:flutter/material.dart';
import 'package:vm_app/src/core/l10n/app_localization.dart';
import 'package:vm_app/src/core/l10n/generated/app_localizations.dart';

extension BuildContextX on BuildContext {
  AppLocalizations get l10n => AppLocalization.of<GeneratedLocalization>(this);

  ThemeData get theme => Theme.of(this);

  /// Obtain the nearest widget of the given type T,
  /// which must be the type of a concrete [InheritedWidget] subclass,
  /// and register this build context with that widget such that
  /// when that widget changes (or a new widget of that type is introduced,
  /// or the widget goes away), this build context is rebuilt so that it can
  /// obtain new values from that widget.
  T? inhMaybeOf<T extends InheritedWidget>({bool listen = true}) =>
      listen ? dependOnInheritedWidgetOfExactType<T>() : getInheritedWidgetOfExactType<T>();

  /// Obtain the nearest widget of the given type T,
  /// which must be the type of a concrete [InheritedWidget] subclass,
  /// and register this build context with that widget such that
  /// when that widget changes (or a new widget of that type is introduced,
  /// or the widget goes away), this build context is rebuilt so that it can
  /// obtain new values from that widget.
  T inhOf<T extends InheritedWidget>({bool listen = true}) =>
      inhMaybeOf<T>(listen: listen) ?? _notFoundInheritedWidget<T>();

  /// Maybe inherit specific aspect from [InheritedModel].
  T? maybeInheritFrom<A extends Object, T extends InheritedModel<A>>({A? aspect}) =>
      InheritedModel.inheritFrom<T>(this, aspect: aspect);

  /// Inherit specific aspect from [InheritedModel].
  T inheritFrom<A extends Object, T extends InheritedModel<A>>({A? aspect}) =>
      maybeInheritFrom(aspect: aspect) ?? _notFoundInheritedModel<T>();

  static Never _notFoundInheritedWidget<T>() => throw ArgumentError(
    'Out of scope, not found inherited widget '
        'a $T of the exact type',
    'out_of_scope',
  );

  static Never _notFoundInheritedModel<T>() => throw ArgumentError(
    'Out of scope, not found inherited model '
        'a $T of the exact type',
    'out_of_scope',
  );
}
