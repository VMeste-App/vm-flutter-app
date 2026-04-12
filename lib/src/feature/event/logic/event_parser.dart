import 'package:vm_app/src/core/model/typedefs.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/shared/activity/model/activity.dart';
import 'package:vm_app/src/shared/level/model/level.dart';
import 'package:vm_app/src/shared/sex/model/sex.dart';

mixin EventParser {
  VmEvent parseEvent(Json data) {
    if (data case {
      'id': final VmEventId id,
      'title': final String title,
      'activity_id': final ActivityId activityId,
      'level': final SkillLevelId levelId,
      'members_qty_up': final int membersQtyUp,
      'members_qty_to': final int membersQtyTo,
      'participant_category': final EventMembersTypeID participantCategory,
      'members_age_up': final int? membersAgeUp,
      'members_age_to': final int? membersAgeTo,
      'dt': final String dt,
      'duration': final int duration,
      'cost': final int cost,
      'per_member_cost': final bool? perMemberCost,
      'description': final String? description,
    }) {
      return VmEvent(
        id: id,
        title: title,
        activityId: activityId,
        level: SkillLevel.byId(levelId),
        membersQtyUp: membersQtyUp,
        membersQtyTo: membersQtyTo,
        participantCategory: EventMembersType.byId(participantCategory),
        membersAgeUp: membersAgeUp,
        membersAgeTo: membersAgeTo,
        dt: DateTime.parse(dt),
        duration: Duration(minutes: duration),
        cost: cost,
        perMemberCost: perMemberCost ?? false,
        description: description,
      );
    }

    throw Exception('Failed to parse event');
  }
}
