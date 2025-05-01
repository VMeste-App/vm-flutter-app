import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template persisted_entry}
/// [PersistedEntry] describes a single persisted entry.
/// {@endtemplate}
@immutable
abstract class PersistedEntry<T extends Object> {
  /// {@macro persisted_entry}
  const PersistedEntry();

  /// Read the value from the cache.
  Future<T?> read();

  /// Set the value in the cache.
  Future<void> set(T value);

  /// Remove the value from the cache.
  Future<void> remove();

  /// Set the value in the cache if the value is not null, otherwise remove the value from the cache.
  Future<void> setIfNullRemove(T? value) => value == null ? remove() : set(value);
}

/// {@template shared_preferences_entry}
/// [SharedPreferencesEntry] describes a single persisted entry in [SharedPreferences].
/// {@endtemplate}
abstract class SharedPreferencesEntry<T extends Object> extends PersistedEntry<T> {
  /// {@macro shared_preferences_entry}
  const SharedPreferencesEntry({required this.storage, required this.key});

  /// The instance of [SharedPreferences] used to read and write values.
  final SharedPreferencesAsync storage;

  /// The key used to store the value in the cache.
  final String key;

  @override
  Future<void> remove() async {
    await storage.remove(key);
  }
}

/// A [int] implementation of [SharedPreferencesEntry].
class IntPreferencesEntry extends SharedPreferencesEntry<int> {
  /// {@macro int_preferences_entry}
  const IntPreferencesEntry({required super.storage, required super.key});

  @override
  Future<int?> read() => storage.getInt(key);

  @override
  Future<void> set(int value) async {
    await storage.setInt(key, value);
  }
}

/// A [String] implementation of [SharedPreferencesEntry].
class StringPreferencesEntry extends SharedPreferencesEntry<String> {
  /// {@macro string_preferences_entry}
  const StringPreferencesEntry({required super.storage, required super.key});

  @override
  Future<String?> read() => storage.getString(key);

  @override
  Future<void> set(String value) async {
    await storage.setString(key, value);
  }
}

/// A [bool] implementation of [SharedPreferencesEntry].
class BoolPreferencesEntry extends SharedPreferencesEntry<bool> {
  /// {@macro bool_preferences_entry}
  const BoolPreferencesEntry({required super.storage, required super.key});

  @override
  Future<bool?> read() => storage.getBool(key);

  @override
  Future<void> set(bool value) async {
    await storage.setBool(key, value);
  }
}

/// A [double] implementation of [SharedPreferencesEntry].
class DoublePreferencesEntry extends SharedPreferencesEntry<double> {
  /// {@macro double_preferences_entry}
  const DoublePreferencesEntry({required super.storage, required super.key});

  @override
  Future<double?> read() => storage.getDouble(key);

  @override
  Future<void> set(double value) async {
    await storage.setDouble(key, value);
  }
}

/// A [List<String>] implementation of [SharedPreferencesEntry].
class StringListPreferencesEntry extends SharedPreferencesEntry<List<String>> {
  /// {@macro string_list_preferences_entry}
  const StringListPreferencesEntry({required super.storage, required super.key});

  @override
  Future<List<String>?> read() => storage.getStringList(key);

  @override
  Future<void> set(List<String> value) async {
    await storage.setStringList(key, value);
  }
}
