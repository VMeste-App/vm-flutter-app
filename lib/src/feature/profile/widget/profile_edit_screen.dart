import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/ui-kit/button.dart';
import 'package:vm_app/src/core/ui-kit/fields/date_field.dart';
import 'package:vm_app/src/core/ui-kit/fields/height_field.dart';
import 'package:vm_app/src/core/ui-kit/fields/sex_field.dart';
import 'package:vm_app/src/core/ui-kit/fields/weight_field.dart';
import 'package:vm_app/src/core/ui-kit/label.dart';
import 'package:vm_app/src/core/ui-kit/loader.dart';
import 'package:vm_app/src/core/ui-kit/scaffold.dart';
import 'package:vm_app/src/core/ui-kit/text_field.dart';
import 'package:vm_app/src/feature/profile/controller/profile_controller.dart';
import 'package:vm_app/src/feature/profile/controller/profile_state.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';

class ProfileEditScreen extends StatefulWidget {
  final ProfileId id;

  const ProfileEditScreen({
    super.key,
    required this.id,
  });

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late final ProfileController _controller;

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _birthDate = DateController();
  final _sex = SexController();
  final _height = TextEditingController();
  final _weight = TextEditingController();
  final _aboutMe = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = ProfileController(
      id: widget.id,
      repository: Dependencies.of(context).profileRepository,
    );
    _controller
      ..addListener(_listener)
      ..fetch();
  }

  @override
  void dispose() {
    for (final c in [_firstName, _lastName, _email, _birthDate, _sex, _height, _weight, _aboutMe, _controller]) {
      c.dispose();
    }
    super.dispose();
  }

  void _listener() {
    if (_controller.state.profile case final profile?) {
      _firstName.text = profile.firstName;
      _lastName.text = profile.lastName;
      _email.text = profile.email;
      _sex.value = profile.sex;
      _birthDate.value = profile.birthDate;
      _height.text = profile.height?.toString() ?? '';
      _weight.text = profile.weight?.toString() ?? '';
      _aboutMe.text = profile.aboutMe ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return StateConsumer<ProfileController, ProfileState>(
      controller: _controller,
      builder: (context, state, child) {
        final profile = state.profile;
        Widget? body;
        if (profile == null) {
          if (state is ProfileStateProcessing) {
            body = Center(child: VmLoader.medium());
          } else {
            body = const Center(child: Text('Профиль не найден'));
          }
        }

        return VmScaffold(
          appBar: AppBar(
            title: const Text('Редактирование'),
          ),
          body: body ?? child!,
          persistentFooterButtons: [
            if (profile != null)
              VmButton(
                loading: state is ProfileStateProcessing,
                onPressed: () {},
                child: const Text('Сохранить'),
              ),
          ],
        );
      },
      child: SingleChildScrollView(
        child: Column(
          spacing: 16.0,
          children: [
            // Имя
            VmLabel(
              title: const Text('Имя'),
              child: VmTextField(
                controller: _firstName,
                keyboardType: TextInputType.number,
                maxLength: 80,
                maxLines: 1,
                textInputAction: TextInputAction.next,
              ),
            ),

            // Фамилия
            VmLabel(
              title: const Text('Фамилия'),
              child: VmTextField(
                controller: _lastName,
                keyboardType: TextInputType.number,
                maxLength: 80,
                maxLines: 1,
                textInputAction: TextInputAction.next,
              ),
            ),

            // Почта
            VmLabel(
              title: const Text('Почта'),
              child: VmTextField(
                controller: _email,
                maxLines: 1,
                enabled: false,
              ),
            ),

            // Дата рождения
            VmLabel(
              title: const Text('Дата рождения'),
              child: DateField(
                controller: _birthDate,
                helperText: 'Пользователям будет виден только Ваш возвраст',
              ),
            ),

            // Пол
            VmLabel(
              title: const Text('Пол'),
              child: SexField2(controller: _sex),
            ),

            // Рост
            VmLabel(
              title: const Text('Рост'),
              child: HeightField(controller: _height),
            ),

            // Вес
            VmLabel(
              title: const Text('Вес'),
              child: WeightField(controller: _weight),
            ),

            // О себе
            VmLabel(
              title: const Text('О себе'),
              child: VmTextField(
                controller: _aboutMe,
                hintText: 'Мастер спорта по хоккею',
                maxLength: 300,
                maxLines: 5,
              ),
            ),

            // Отступ снизу
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Profile _buildNewProfile(Profile old) {
  //   return old.copyWith(
  //     firstName: _firstName.text,
  //     lastName: _lastName.text,
  //     birthDate: _birthDate.value,
  //     sex: _sex.value,
  //     height: int.tryParse(_height.text),
  //     weight: int.tryParse(_weight.text),
  //     aboutMe: _aboutMe.text,
  //   );
  // }
}
