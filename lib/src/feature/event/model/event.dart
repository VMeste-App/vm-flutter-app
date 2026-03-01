import 'package:meta/meta.dart';
import 'package:vm_app/src/shared/activity/model/activity.dart';
import 'package:vm_app/src/shared/level/model/level.dart';
import 'package:vm_app/src/shared/sex/model/sex.dart';

typedef VmEventID = int;
// typedef VmEvents = List<VmEvent>;

@immutable
final class VmEvent {
  /// Event ID.
  final VmEventID id;

  /// Title.
  final String title;

  /// ID of the activity associated with the event.
  final ActivityID activityID;

  /// Required skill level.
  final SkillLevel level;

  /// Minimum number of participants.
  final int membersQtyUp;

  /// Maximum number of participants.
  final int membersQtyTo;

  /// Gender of participants.
  final EventParticipantCategory participantCategory;

  /// Minimum age of participants.
  final int membersAgeUp;

  /// Maximum age of participants.
  final int membersAgeTo;

  /// Event start date and time.
  final DateTime startDt;

  /// Duration of the event.
  final Duration duration;

  /// Event cost.
  final int cost;

  /// Indicates whether the cost is per participant.
  final bool perMemberCost;

  /// Event description.
  final String? description;

  const VmEvent({
    this.id = -1,
    required this.title,
    required this.activityID,
    required this.level,
    required this.membersQtyUp,
    required this.membersQtyTo,
    required this.participantCategory,
    required this.membersAgeUp,
    required this.membersAgeTo,
    required this.startDt,
    required this.duration,
    required this.cost,
    this.perMemberCost = false,
    this.description,
  });
}

final class VmCreateEventMutable {
  /// Title.
  String? title;

  /// ID of the activity associated with the event.
  ActivityID? activityID;

  /// Required skill level.
  SkillLevel? level;

  /// Minimum number of participants.
  int? membersQtyUp;

  /// Maximum number of participants.
  int? membersQtyTo;

  bool meAsMember = true;

  /// Gender of participants.
  EventParticipantCategory? participantCategory;

  /// Minimum age of participants.
  int? membersAgeUp;

  /// Maximum age of participants.
  int? membersAgeTo;

  /// Event start date and time.
  DateTime? startDt;

  /// Duration of the event.
  Duration? duration;

  /// Total event cost.
  int? cost;

  /// Indicates whether the cost is per participant.
  bool perMemberCost = false;

  /// Event description.
  String? description;

  VmCreateEventMutable({
    this.title,
    this.activityID,
    this.level,
    this.membersQtyUp,
    this.membersQtyTo,
    this.participantCategory,
    this.membersAgeUp,
    this.membersAgeTo,
    this.startDt,
    this.duration,
    this.cost,
    this.perMemberCost = false,
    this.description,
  });
}
