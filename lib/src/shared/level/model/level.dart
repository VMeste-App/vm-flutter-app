typedef LevelID = int;

enum Level {
  beginner(0),
  intermediate(1),
  advanced(2),
  pro(3);

  final LevelID id;

  const Level(this.id);
}
