import 'package:vm_app/src/feature/auth/model/user.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/feature/place/model/place.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';
import 'package:vm_app/src/feature/profile/model/sex.dart';
import 'package:vm_app/src/shared/level/model/level.dart';
import 'package:vm_app/src/shared/sex/model/sex.dart' as event_sex;

abstract final class FakeData {
  static const user = User(id: 1, email: 'fake@example.com');

  static final profiles = [
    Profile(
      id: 1,
      firstName: 'Иван',
      lastName: 'Иванов',
      birthDate: DateTime(1988),
      sex: Sex.male,
      email: 'ivan.fake@example.com',
      weight: 80,
      height: 190,
      aboutMe: 'Люблю командные игры и спокойные тренировки после работы.',
    ),
    Profile(
      id: 2,
      firstName: 'Анна',
      lastName: 'Смирнова',
      birthDate: DateTime(1994, 3, 12),
      sex: Sex.female,
      email: 'anna.fake@example.com',
      weight: 62,
      height: 172,
      aboutMe: 'Ищу компанию для волейбола и пробежек.',
    ),
  ];

  static const places = [
    Place(
      id: 1,
      cityId: 1,
      name: 'Парк Маяковского',
      address: 'ул. Мичурина, 230',
      lat: 56.816735,
      lng: 60.635779,
    ),
    Place(
      id: 2,
      cityId: 1,
      name: 'Стадион Юность',
      address: 'ул. Куйбышева, 32а',
      lat: 56.829593,
      lng: 60.616086,
    ),
    Place(
      id: 3,
      cityId: 1,
      name: 'Корт на ВИЗе',
      address: 'ул. Кирова, 40',
      lat: 56.842702,
      lng: 60.560462,
    ),
  ];

  static final events = [
    VmEvent(
      id: 1,
      title: 'Футбол в парке Маяковского',
      activityId: 1,
      level: SkillLevel.beginner,
      membersQtyUp: 8,
      membersQtyTo: 14,
      participantCategory: event_sex.EventMembersType.mixed,
      membersAgeUp: 18,
      membersAgeTo: 45,
      dt: DateTime.now().add(const Duration(days: 1, hours: 2)),
      duration: const Duration(hours: 2),
      cost: 0,
      description: 'Играем без жесткого отбора по уровню, главное прийти вовремя.',
    ),
    VmEvent(
      id: 2,
      title: 'Волейбол для продолжающих',
      activityId: 3,
      level: SkillLevel.intermediate,
      membersQtyUp: 6,
      membersQtyTo: 12,
      participantCategory: event_sex.EventMembersType.mixed,
      membersAgeUp: 20,
      membersAgeTo: 50,
      dt: DateTime.now().add(const Duration(days: 2, hours: 4)),
      duration: const Duration(hours: 2),
      cost: 300,
      perMemberCost: true,
      description: 'Зал оплачен, стоимость делим между участниками.',
    ),
    VmEvent(
      id: 3,
      title: 'Баскетбол 3 на 3',
      activityId: 2,
      level: SkillLevel.advanced,
      membersQtyUp: 6,
      membersQtyTo: 8,
      participantCategory: event_sex.EventMembersType.male,
      membersAgeUp: 18,
      membersAgeTo: 35,
      dt: DateTime.now().add(const Duration(days: 4, hours: 1)),
      duration: const Duration(minutes: 90),
      cost: 150,
      perMemberCost: true,
    ),
  ];
}
