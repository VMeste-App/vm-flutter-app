import 'package:vm_app/src/feature/profile/model/sex.dart';

typedef ProfileId = int;

class Profile {
  final ProfileId id;

  /// Имя
  final String firstName;

  /// Фамилия
  final String lastName;

  /// Дата рождения
  final DateTime birthDate;

  /// Пол
  final Sex sex;

  /// Почта
  final String email;

  /// Вес (в кг)
  final int? weight;

  /// Рост (в см)
  final int? height;

  // О себе
  final String? aboutMe;

  /// Ссылка на фото
  final String? photoUrl;

  /// Хеш фото для превью
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
    this.aboutMe,
    this.photoUrl,
    this.blurhash,
  });

  Profile copyWith({
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    Sex? sex,
    String? email,
    int? weight,
    int? height,
    String? aboutMe,
    String? photoUrl,
    String? blurhash,
  }) {
    return Profile(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      sex: sex ?? this.sex,
      email: email ?? this.email,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      aboutMe: aboutMe ?? this.aboutMe,
      photoUrl: photoUrl ?? this.photoUrl,
      blurhash: blurhash ?? this.blurhash,
    );
  }
}
