import 'dart:async';

import 'package:vm_app/src/core/initialization/fake/data/fake_data.dart';
import 'package:vm_app/src/feature/event/data/vm_event_repository.dart';
import 'package:vm_app/src/feature/event/model/complain.dart';
import 'package:vm_app/src/feature/event/model/create_event.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/feature/event/model/event_filter.dart';
import 'package:vm_app/src/shared/level/model/level.dart';
import 'package:vm_app/src/shared/sex/model/sex.dart';

final class FakeVmEventRepository implements IVmEventRepository {
  final List<VmEvent> _events = [...FakeData.events];
  VmEvent$Draft? _draft;

  @override
  Future<List<VmEvent>> getEvents(EventFilter filter, EventSort sort, {int page = 0}) async {
    final events = [..._events]..sort((a, b) => a.dt.compareTo(b.dt));
    return events;
  }

  @override
  Future<VmEvent> getEventById(VmEventId id) async {
    return _events.firstWhere((event) => event.id == id);
  }

  @override
  Future<VmEvent> create(VmEvent$Create event) async {
    final created = VmEvent(
      id: _nextId,
      title: event.title,
      activityId: event.activityID,
      level: SkillLevel.byId(event.levelID),
      membersQtyUp: event.membersQtyUp ?? 1,
      membersQtyTo: event.membersQtyTo ?? event.membersQtyUp ?? 1,
      participantCategory: EventMembersType.byId(event.membersTypeID),
      membersAgeUp: event.membersAgeUp,
      membersAgeTo: event.membersAgeTo,
      dt: event.dt,
      duration: event.duration,
      cost: event.cost,
      perMemberCost: event.perMemberCost,
      description: event.description,
    );
    _events.add(created);
    _draft = null;
    return created;
  }

  @override
  Future<VmEvent> update(VmEvent event) async {
    final index = _events.indexWhere((item) => item.id == event.id);
    if (index == -1) {
      _events.add(event);
      return event;
    }
    _events[index] = event;
    return event;
  }

  @override
  Future<VmEvent> join(VmEventId id) => getEventById(id);

  @override
  Future<VmEvent> decline(VmEventId id) => getEventById(id);

  @override
  Future<VmEvent> cancel(VmEventId id) => getEventById(id);

  @override
  Future<VmEvent> complain(VmEventId id, Complain complain) => getEventById(id);

  @override
  Future<VmEvent$Draft?> getDraft() => Future.value(_draft);

  @override
  Future<void> saveDraft(VmEvent$Draft event) async {
    _draft = event.isEmpty ? null : event;
  }

  int get _nextId => _events.isEmpty ? 1 : _events.map((event) => event.id).reduce((a, b) => a > b ? a : b) + 1;
}
