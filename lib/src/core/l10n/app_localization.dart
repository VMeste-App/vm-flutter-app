import 'package:flutter/material.dart';
import 'package:vm_app/src/core/l10n/generated/app_localizations.dart';

typedef GeneratedLocalization = AppLocalizations;

/// A class which is responsible for providing the localization.
///
/// [AppLocalization] is a wrapper around [AppLocalizations].
sealed class AppLocalization {
  /// All the supported locales
  static const supportedLocales = AppLocalizations.supportedLocales;

  /// All the localizations delegates
  static const localizationsDelegates = AppLocalizations.localizationsDelegates;

  /// Returns the localized strings for the given [context].
  static T of<T>(BuildContext context) => Localizations.of<T>(context, T)!;

  /// Returns the current locale of the [context].
  static Locale? localeOf(BuildContext context) => Localizations.localeOf(context);

  /// Loads the [locale].
  static Future<AppLocalizations> load(Locale locale) => AppLocalizations.delegate.load(locale);

  /// Computes the default locale.
  ///
  /// This is the locale that is used when no locale is specified.
  static Locale get defaultLocale {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;

    if (AppLocalizations.delegate.isSupported(locale)) return locale;

    return const Locale('en');
  }
}
