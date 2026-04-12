import 'package:meta/meta.dart';
import 'package:vm_app/src/core/model/typedefs.dart';
import 'package:vm_app/src/shared/activity/model/activity.dart';
import 'package:vm_app/src/shared/level/model/level.dart';
import 'package:vm_app/src/shared/sex/model/sex.dart';

typedef VmEventId = int;

@immutable
final class VmEvent {
  /// Event ID.
  final VmEventId id;

  /// Title.
  final String title;

  /// ID of the activity associated with the event.
  final ActivityId activityId;

  /// Required skill level.
  final SkillLevel level;

  /// Minimum number of participants.
  final int membersQtyUp;

  /// Maximum number of participants.
  final int membersQtyTo;

  /// Gender of participants.
  final EventMembersType participantCategory;

  /// Minimum age of participants.
  final int? membersAgeUp;

  /// Maximum age of participants.
  final int? membersAgeTo;

  /// Event start date and time.
  final DateTime dt;

  /// Duration of the event.
  final Duration duration;

  /// Event cost.
  final int cost;

  /// Indicates whether the cost is per participant.
  final bool perMemberCost;

  /// Event description.
  final String? description;

  const VmEvent({
    required this.id,
    required this.title,
    required this.activityId,
    required this.level,
    required this.membersQtyUp,
    required this.membersQtyTo,
    required this.participantCategory,
    required this.membersAgeUp,
    required this.membersAgeTo,
    required this.dt,
    required this.duration,
    required this.cost,
    this.perMemberCost = false,
    this.description,
  });
}

@immutable
class VmEvent$Draft {
  /// Title.
  final String? title;

  /// ID of the activity associated with the event.
  final ActivityId? activityId;

  /// Required skill level.
  final SkillLevelId? levelId;

  /// Minimum number of participants.
  final int? membersQtyUp;

  /// Maximum number of participants.
  final int? membersQtyTo;

  /// Gender of participants.
  final EventMembersType? participantCategory;

  /// Minimum age of participants.
  final int? membersAgeUp;

  /// Maximum age of participants.
  final int? membersAgeTo;

  /// Event start date and time.
  final DateTime? dt;

  /// Duration of the event.
  final Duration? duration;

  /// Event cost.
  final int? cost;

  /// Indicates whether the cost is per participant.
  final bool? perMemberCost;

  /// Event description.
  final String? description;

  const VmEvent$Draft({
    this.title,
    this.activityId,
    this.levelId,
    this.membersQtyUp,
    this.membersQtyTo,
    this.participantCategory,
    this.membersAgeUp,
    this.membersAgeTo,
    this.dt,
    this.duration,
    this.cost,
    this.perMemberCost,
    this.description,
  });

  bool get isEmpty =>
      title == null &&
      activityId == null &&
      levelId == null &&
      membersQtyUp == null &&
      membersQtyTo == null &&
      participantCategory == null &&
      membersAgeUp == null &&
      membersAgeTo == null &&
      dt == null &&
      duration == null &&
      cost == null &&
      perMemberCost == null &&
      description == null;

  VmEvent$Draft copyWith({
    String? title,
    ActivityId? activityID,
    SkillLevelId? levelId,
    int? membersQtyUp,
    int? membersQtyTo,
    EventMembersType? participantCategory,
    int? membersAgeUp,
    int? membersAgeTo,
    DateTime? dt,
    Duration? duration,
    int? cost,
    bool? perMemberCost,
    String? description,
  }) {
    return VmEvent$Draft(
      title: title,
      activityId: activityID,
      levelId: levelId,
      membersQtyUp: membersQtyUp,
      membersQtyTo: membersQtyTo,
      participantCategory: participantCategory,
      membersAgeUp: membersAgeUp,
      membersAgeTo: membersAgeTo,
      dt: dt,
      duration: duration,
      cost: cost,
      perMemberCost: perMemberCost,
      description: description,
    );
  }

  Json toJson() => {
    'title': title,
    'activity_id': activityId,
    'level': levelId,
    'members_qty_up': membersQtyUp,
    'members_qty_to': membersQtyTo,
    'participant_category': participantCategory,
    'members_age_up': membersAgeUp,
    'members_age_to': membersAgeTo,
    'dt': dt,
    'duration': duration,
    'cost': cost,
    'per_member_cost': perMemberCost,
    'description': description,
  };
}

// TODO: Удалить
final fakeEvent = VmEvent(
  id: 1,
  title: 'Футбольный матч в парке Горького',
  activityId: 2,
  level: SkillLevel.beginner,
  membersQtyUp: 10,
  membersQtyTo: 20,
  participantCategory: EventMembersType.male,
  membersAgeUp: 18,
  membersAgeTo: 60,
  dt: DateTime.now(),
  duration: const Duration(hours: 2),
  cost: 1000,
);
