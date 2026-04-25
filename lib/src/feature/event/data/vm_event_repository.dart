import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vm_app/src/core/model/typedefs.dart';
import 'package:vm_app/src/core/network/vm_http_client.dart';
import 'package:vm_app/src/feature/event/logic/event_parser.dart';
import 'package:vm_app/src/feature/event/model/complain.dart';
import 'package:vm_app/src/feature/event/model/create_event.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/feature/event/model/event_filter.dart';
import 'package:vm_app/src/shared/activity/model/activity.dart';
import 'package:vm_app/src/shared/level/model/level.dart';
import 'package:vm_app/src/shared/sex/model/sex.dart';

abstract interface class IVmEventRepository {
  /// {@template vm_event.events}
  /// Отсрортированный список событий с пагинацией на основе фильтра.
  /// {@endtemplate}
  Future<List<VmEvent>> getEvents(EventFilter filter, EventSort sort, {int page = 0});

  /// {@template vm_event.byId}
  /// Получить ивент по [id].
  /// {@endtemplate}
  Future<VmEvent> getEventById(VmEventId id);

  /// {@template vm_event.create}
  /// Создать событие.
  /// {@endtemplate}
  Future<VmEvent> create(VmEvent$Create event);

  /// {@template vm_event.update}
  /// Обновить событие.
  /// {@endtemplate}
  Future<VmEvent> update(VmEvent event);

  /// {@template vm_event.join}
  /// Присоединиться к событию.
  /// {@endtemplate}
  Future<VmEvent> join(VmEventId id);

  /// {@template vm_event.decline}
  /// Отказаться от участия.
  /// {@endtemplate}
  Future<VmEvent> decline(VmEventId id);

  /// {@template vm_event.cancel}
  /// Отменить событие.
  /// {@endtemplate}
  Future<VmEvent> cancel(VmEventId id);

  /// {@template vm_event.cancel}
  /// Пожаловаться на событие.
  /// {@endtemplate}
  Future<VmEvent> complain(VmEventId id, Complain complain);

  // --- DRAFT ---

  /// {@template vm_event.draft}
  /// Получить черновик события.
  /// {@endtemplate}
  Future<VmEvent$Draft?> getDraft();

  /// {@template vm_event.saveDraft}
  /// Сохранить черновик события.
  /// {@endtemplate}
  Future<void> saveDraft(VmEvent$Draft event);
}

final class VmEventRepository with EventParser implements IVmEventRepository {
  final VmHttpClient _client;
  final SharedPreferencesAsync _sp;

  VmEventRepository({
    required VmHttpClient client,
    required SharedPreferencesAsync sp,
  }) : _client = client,
       _sp = sp;

  @override
  Future<List<VmEvent>> getEvents(
    EventFilter filter,
    EventSort sort, {
    int page = 0,
  }) async {
    final response = await _client.get(
      '/events',
      queryParameters: {
        'sort': sort.id,
        'page': page,
        ...filter.toJson(),
      },
    );

    if (response case {
      'data': final List<Json> data,
    }) {
      return data.map(parseEvent).toList();
    }

    throw Exception('Failed to parse data');
  }

  @override
  Future<VmEvent> getEventById(VmEventId id) async {
    final response = await _client.get('/events/{$id}');
    return parseEvent(response);
  }

  @override
  Future<VmEvent> create(VmEvent$Create event) async {
    final response = await _client.post('/events', body: event.toJson());
    await _sp.remove('event.draft');
    return parseEvent(response);
  }

  @override
  Future<VmEvent> update(VmEvent event) async {
    final response = await _client.put('/events/${event.id}', body: {});
    return parseEvent(response);
  }

  @override
  Future<VmEvent> join(VmEventId id) async {
    final response = await _client.post('/events/{$id}/join');
    return parseEvent(response);
  }

  @override
  Future<VmEvent> decline(VmEventId id) async {
    final response = await _client.post('/events/{$id}/decline');
    return parseEvent(response);
  }

  @override
  Future<VmEvent> cancel(VmEventId id) async {
    final response = await _client.get('/events/{$id}/cancel');
    return parseEvent(response);
  }

  @override
  Future<VmEvent> complain(VmEventId id, Complain complain) async {
    final response = await _client.post('/events/{$id}/complain', body: complain.toJson());
    return parseEvent(response);
  }

  // --- DRAFT ---

  @override
  Future<VmEvent$Draft?> getDraft() async {
    final encodedJson = await _sp.getString('event.draft');
    if (encodedJson == null) return null;

    final decodedJson = jsonDecode(encodedJson);
    if (decodedJson case {
      'title': final String? title,
      'activity_id': final ActivityId? activityId,
      'level': final SkillLevelId? levelId,
      'members_qty_up': final int? membersQtyUp,
      'members_qty_to': final int? membersQtyTo,
      'participant_category': final EventMembersTypeID? participantCategory,
      'members_age_up': final int? membersAgeUp,
      'members_age_to': final int? membersAgeTo,
      'dt': final String? dt,
      'duration': final int? duration,
      'cost': final int? cost,
      'per_member_cost': final bool? perMemberCost,
      'description': final String? description,
    }) {
      return VmEvent$Draft(
        title: title,
        activityId: activityId,
        levelId: levelId,
        membersQtyUp: membersQtyUp,
        membersQtyTo: membersQtyTo,
        participantCategory: participantCategory != null ? EventMembersType.byId(participantCategory) : null,
        membersAgeUp: membersAgeUp,
        membersAgeTo: membersAgeTo,
        dt: DateTime.tryParse(dt ?? ''),
        duration: duration != null ? Duration(minutes: duration) : null,
        cost: cost,
        perMemberCost: perMemberCost,
        description: description,
      );
    }
    return null;
  }

  @override
  Future<void> saveDraft(VmEvent$Draft event) async {
    final json = event.toJson();
    await _sp.setString('event.draft', jsonEncode(json));
  }
}
