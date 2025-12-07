typedef LevelID = int;

enum Level {
  beginner(0),
  intermediate(1),
  advanced(2),
  pro(3);

  final LevelID id;

  const Level(this.id);

  factory Level.byID(LevelID id) => switch (id) {
    0 => Level.beginner,
    1 => Level.intermediate,
    2 => Level.advanced,
    3 => Level.pro,
    _ => throw ArgumentError('Unknown level id: $id'),
  };
}
