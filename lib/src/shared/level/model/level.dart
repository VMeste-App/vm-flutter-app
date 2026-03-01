typedef SkillLevelID = int;

enum SkillLevel {
  beginner(0),
  intermediate(1),
  advanced(2),
  pro(3)
  ;

  final SkillLevelID id;

  const SkillLevel(this.id);

  factory SkillLevel.byID(SkillLevelID id) => switch (id) {
    0 => SkillLevel.beginner,
    1 => SkillLevel.intermediate,
    2 => SkillLevel.advanced,
    3 => SkillLevel.pro,
    _ => throw ArgumentError('Unknown level id: $id', 'id'),
  };
}
