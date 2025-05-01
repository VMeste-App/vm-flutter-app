import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/settings/data/locale_repository.dart';
import 'package:vm_app/src/feature/settings/data/theme_repository.dart';
import 'package:vm_app/src/feature/settings/model/app_settings.dart';

final class SettingsController extends StateController<SettingsState> with SequentialControllerHandler {
  SettingsController({
    required IThemeRepository themeRepository,
    required ILocaleRepository localeRepository,
    AppSettings? initialSettings,
  }) : _themeRepository = themeRepository,
       _localeRepository = localeRepository,
       super(initialState: SettingsState.idle(settings: initialSettings ?? AppSettings()));

  final IThemeRepository _themeRepository;
  final ILocaleRepository _localeRepository;

  void setThemeMode(ThemeMode mode) => handle(
    () async {
      setState(SettingsState.processing(settings: state.settings));
      await _themeRepository.setThemeMode(mode);
      final settings = state.settings;
      setState(SettingsState.idle(settings: settings.copyWith(theme: settings.theme.copyWith(mode: mode))));
    },
    error: (e, _) async {
      setState(SettingsState.idle(settings: state.settings, error: e));
    },
  );

  void setThemeSeedColor(Color color) => handle(
    () async {
      setState(SettingsState.processing(settings: state.settings));
      await _themeRepository.setSeedColor(color);
      final settings = state.settings;
      setState(SettingsState.idle(settings: settings.copyWith(theme: settings.theme.copyWith(seedColor: color))));
    },
    error: (e, _) async {
      setState(SettingsState.idle(settings: state.settings, error: e));
    },
  );

  void setLocale(Locale locale) => handle(
    () async {
      setState(SettingsState.processing(settings: state.settings));
      await _localeRepository.setLocale(locale);
      setState(SettingsState.idle(settings: state.settings.copyWith(locale: locale)));
    },
    error: (e, _) async {
      setState(SettingsState.idle(settings: state.settings, error: e));
    },
  );
}

sealed class SettingsState extends _SettingsStateBase {
  const SettingsState({required super.settings});

  const factory SettingsState.idle({required AppSettings settings, Object? error}) = SettingsStateIdle;

  const factory SettingsState.processing({required AppSettings settings}) = SettingsStateProcessing;
}

final class SettingsStateIdle extends SettingsState {
  const SettingsStateIdle({required super.settings, this.error});

  @override
  final Object? error;
}

final class SettingsStateProcessing extends SettingsState {
  const SettingsStateProcessing({required super.settings});

  @override
  String? get error => null;
}

@immutable
abstract base class _SettingsStateBase {
  const _SettingsStateBase({required this.settings});

  /// Current [AppSettings]
  @nonVirtual
  final AppSettings settings;

  /// Error object.
  abstract final Object? error;

  /// If an error has occurred?
  bool get hasError => error != null;

  /// Is in progress state?
  bool get isProcessing => maybeMap<bool>(orElse: () => false, processing: (_) => true);

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [SettingsState].
  R map<R>({
    required _SettingsStateMatch<R, SettingsStateIdle> idle,
    required _SettingsStateMatch<R, SettingsStateProcessing> processing,
  }) => switch (this) {
    final SettingsStateIdle s => idle(s),
    final SettingsStateProcessing s => processing(s),
    _ => throw AssertionError(),
  };

  /// Pattern matching for [SettingsState].
  R maybeMap<R>({
    required R Function() orElse,
    _SettingsStateMatch<R, SettingsStateIdle>? idle,
    _SettingsStateMatch<R, SettingsStateProcessing>? processing,
  }) => map<R>(idle: idle ?? (_) => orElse(), processing: processing ?? (_) => orElse());

  /// Pattern matching for [SettingsState].
  R? mapOrNull<R>({
    _SettingsStateMatch<R, SettingsStateIdle>? idle,
    _SettingsStateMatch<R, SettingsStateProcessing>? processing,
  }) => map<R?>(idle: idle ?? (_) => null, processing: processing ?? (_) => null);

  @override
  int get hashCode => Object.hash(settings, error);

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  String toString() {
    final buffer =
        StringBuffer()
          ..write('SettingsState(')
          ..write('settings: $settings');
    if (error != null) buffer.write(', error: $error');
    buffer.write(')');

    return buffer.toString();
  }
}

/// Pattern matching for [SettingsState].
typedef _SettingsStateMatch<R, S extends SettingsState> = R Function(S state);
