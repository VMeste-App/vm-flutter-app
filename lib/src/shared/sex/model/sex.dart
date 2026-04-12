typedef EventMembersTypeID = int;

enum EventMembersType {
  male(0),
  female(1),

  /// Male and female participants together.
  mixed(3)
  ;

  final EventMembersTypeID id;

  const EventMembersType(this.id);

  factory EventMembersType.byId(EventMembersTypeID id) => switch (id) {
    0 => EventMembersType.male,
    1 => EventMembersType.female,
    3 => EventMembersType.mixed,
    _ => throw ArgumentError('Unknown event participant category id: $id', 'id'),
  };
}
