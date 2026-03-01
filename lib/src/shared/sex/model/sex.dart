enum EventParticipantCategory {
  male(0),
  female(1),

  /// Male and female participants.
  mixed(3)
  ;

  final int id;

  const EventParticipantCategory(this.id);

  factory EventParticipantCategory.byID(int id) => switch (id) {
    0 => EventParticipantCategory.male,
    1 => EventParticipantCategory.female,
    3 => EventParticipantCategory.mixed,
    _ => throw ArgumentError('Unknown event participant category id: $id', 'id'),
  };
}
