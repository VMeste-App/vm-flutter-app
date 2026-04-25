import 'package:vm_app/src/core/model/typedefs.dart';
import 'package:vm_app/src/feature/profile/model/sex.dart';

typedef ProfileId = int;

const _undefined = Object();

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

  factory Profile.fromJson(Json json) {
    if (json case {
      'id': final ProfileId id,
      'first_name': final String firstName,
      'last_name': final String lastName,
      'birth_date': final String birthDate,
      'sex': final SexId sexId,
      'email': final String email,
      'weight': final int? weight,
      'height': final int? height,
      'photo_url': final String? photoUrl,
      'blurhash': final String? blurhash,
    }) {
      final aboutMe = json['about_me'] as String?;

      return Profile(
        id: id,
        firstName: firstName,
        lastName: lastName,
        birthDate: DateTime.parse(birthDate),
        sex: Sex.byId(sexId),
        email: email,
        weight: weight,
        height: height,
        aboutMe: aboutMe,
        photoUrl: photoUrl,
        blurhash: blurhash,
      );
    }

    throw FormatException('Returned profile is not understood by the application', json);
  }

  Profile copyWith({
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    Sex? sex,
    String? email,
    Object? weight = _undefined,
    Object? height = _undefined,
    Object? aboutMe = _undefined,
    Object? photoUrl = _undefined,
    Object? blurhash = _undefined,
  }) {
    return Profile(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      sex: sex ?? this.sex,
      email: email ?? this.email,
      weight: weight == _undefined ? this.weight : weight as int?,
      height: height == _undefined ? this.height : height as int?,
      aboutMe: aboutMe == _undefined ? this.aboutMe : aboutMe as String?,
      photoUrl: photoUrl == _undefined ? this.photoUrl : photoUrl as String?,
      blurhash: blurhash == _undefined ? this.blurhash : blurhash as String?,
    );
  }

  Json toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'birth_date': birthDate.toIso8601String(),
      'sex': sex.id,
      'weight': weight,
      'height': height,
      'about_me': aboutMe,
    };
  }
}
