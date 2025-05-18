import 'package:meta/meta.dart';
import 'package:vm_app/src/core/model/typedefs.dart';
import 'package:vm_app/src/shared/activity/model/activity.dart';
import 'package:vm_app/src/shared/level/model/level.dart';
import 'package:vm_app/src/shared/sex/model/sex.dart';

typedef VmEventID = int;

@immutable
final class VmEvent {
  final VmEventID id;
  final ActivityID activityID;
  final Level level;
  final int membersQtyUp;
  final int membersQtyTo;
  final Sex membersSex;
  final int membersAgeUp;
  final int membersAgeTo;
  final DateTime dt;
  final Duration duration;
  final int sharedCost;
  final int perPersonCost;
  final String? description;

  const VmEvent({
    this.id = -1,
    required this.activityID,
    required this.level,
    required this.membersQtyUp,
    required this.membersQtyTo,
    required this.membersSex,
    required this.membersAgeUp,
    required this.membersAgeTo,
    required this.sharedCost,
    required this.perPersonCost,
    required this.dt,
    required this.duration,
    this.description,
  });

  Json toJson() {
    return {
      'activity_id': activityID,
      'level_id': level.id,
      'members_qty_up': membersQtyUp,
      'members_qty_to': membersQtyTo,
      'sex': membersSex.id,
      'members_age_up': membersAgeUp,
      'members_age_to': membersAgeTo,
      'shared_cost': sharedCost,
      'per_person_cost': perPersonCost,
      'dt': dt.toUtc().toIso8601String(),
      'duration': duration.inMinutes,
      'description': description,
    };
  }
}

typedef VmEvents = List<VmEvent>;
