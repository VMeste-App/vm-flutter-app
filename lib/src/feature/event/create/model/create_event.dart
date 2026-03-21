import 'package:meta/meta.dart';
import 'package:vm_app/src/shared/activity/model/activity.dart';
import 'package:vm_app/src/shared/level/model/level.dart';
import 'package:vm_app/src/shared/sex/model/sex.dart';

@immutable
final class VmEvent$Create {
  /// Title.
  final String title;

  /// ID of the activity associated with the event.
  final ActivityID activityID;

  /// Required skill level.
  final SkillLevelID levelID;

  /// Minimum number of participants.
  final int? membersQtyUp;

  /// Maximum number of participants.
  final int? membersQtyTo;

  final bool meAsMember;

  /// Gender of participants.
  final EventMembersTypeID membersTypeID;

  /// Minimum age of participants.
  final int? membersAgeUp;

  /// Maximum age of participants.
  final int? membersAgeTo;

  /// Event start date and time.
  final DateTime dt;

  /// Duration of the event.
  final Duration duration;

  /// Total event cost.
  final int cost;

  /// Indicates whether the cost is per participant.
  final bool perMemberCost;

  /// Event description.
  final String? description;

  const VmEvent$Create({
    required this.title,
    required this.activityID,
    required this.levelID,
    required this.membersQtyUp,
    required this.membersQtyTo,
    required this.meAsMember,
    required this.membersTypeID,
    required this.membersAgeUp,
    required this.membersAgeTo,
    required this.dt,
    required this.duration,
    required this.cost,
    required this.perMemberCost,
    required this.description,
  });
}
