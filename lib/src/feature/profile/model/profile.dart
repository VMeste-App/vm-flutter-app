typedef ProfileId = int;

class Profile {
  final ProfileId id;

  /// Имя
  final String firstName;

  /// Фамилия
  final String lastName;

  /// Дата рождения.
  final DateTime birthDate;

  /// Пол
  final Sex sex;

  /// Почта
  final String email;

  /// Вес (в кг)
  final int? weight;

  /// Рост (в см)
  final int? height;

  /// Ссылка на фото.
  final String? photoUrl;

  /// Хеш заблюренного фото для превью.
  final String? blurhash;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.sex,
    required this.email,
    this.weight,
    this.height,
    this.photoUrl,
    this.blurhash,
  });
}

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
