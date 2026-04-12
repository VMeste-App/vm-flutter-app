import 'package:shared_preferences/shared_preferences.dart';
import 'package:vm_app/src/core/utils/persisted_entry.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/feature/place/model/place.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';

typedef FavoriteLocalDataSource$Event = FavoriteLocalDataSource<VmEventId>;
typedef FavoriteLocalDataSource$Profile = FavoriteLocalDataSource<ProfileId>;
typedef FavoriteLocalDataSource$Place = FavoriteLocalDataSource<PlaceId>;

class FavoriteLocalDataSource<Id extends Object> {
  final String key;
  final SharedPreferencesAsync _sp;

  FavoriteLocalDataSource(this.key, {required SharedPreferencesAsync sp}) : _sp = sp;

  StringListPreferencesEntry get _entry => StringListPreferencesEntry(storage: _sp, key: 'favorites.$key');

  /// {@template favorite.getIds}
  /// Получить список id избранных.
  /// {@endtemplate}
  Future<Set<Id>> getIds() => _entry.read().then((value) => (value ?? []).map(int.parse).whereType<Id>().toSet());

  /// {@template favorite.add}
  /// Добавить в избранное.
  /// {@endtemplate}
  Future<Set<Id>> add(Id id) async {
    final current = await getIds();
    final newList = [...current, id];
    await _entry.set(newList.map((e) => e.toString()).toList());
    return newList.toSet();
  }

  /// {@template favorite.remove}
  /// Удалить из избранного.
  /// {@endtemplate}
  Future<Set<Id>> remove(Id id) async {
    final current = await getIds();
    final newList = current.where((e) => e != id).toList();
    await _entry.set(newList.map((e) => e.toString()).toList());
    return newList.toSet();
  }
}
