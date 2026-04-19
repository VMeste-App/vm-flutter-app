typedef SexId = int;

enum Sex {
  male(1),
  female(2),
  ;

  final SexId id;

  const Sex(this.id);

  factory Sex.byId(SexId id) => switch (id) {
    1 => Sex.male,
    2 => Sex.female,
    _ => throw ArgumentError('Unknown sex id: $id', 'id'),
  };
}
