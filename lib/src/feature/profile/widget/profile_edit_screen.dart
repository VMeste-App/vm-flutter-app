import 'dart:io';

import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/ui-kit/avatar.dart';
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
import 'package:vm_app/src/feature/profile/widget/avatar_preview_screen.dart';

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

  Profile? _initialProfile;
  bool _closeOnSuccess = false;
  bool _updatedSuccessfully = false;

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
    for (final c in [_firstName, _lastName, _height, _weight, _aboutMe]) {
      c.addListener(_onFormChanged);
    }
    _birthDate.addListener(_onFormChanged);
    _sex.addListener(_onFormChanged);
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
    for (final c in [_firstName, _lastName, _height, _weight, _aboutMe]) {
      c.removeListener(_onFormChanged);
    }
    _birthDate.removeListener(_onFormChanged);
    _sex.removeListener(_onFormChanged);
    for (final c in [_firstName, _lastName, _email, _birthDate, _sex, _height, _weight, _aboutMe, _controller]) {
      c.dispose();
    }
    super.dispose();
  }

  void _listener() {
    if (_controller.state is ProfileStateError) {
      _closeOnSuccess = false;
      _updatedSuccessfully = false;
    }

    if (_controller.state.profile case final profile?) {
      if (_closeOnSuccess && _controller.state is ProfileStateSuccess) {
        _updatedSuccessfully = true;
      } else if (_closeOnSuccess && _updatedSuccessfully && _controller.state is ProfileStateIdle) {
        Navigator.pop(context);
        return;
      }

      if (_initialProfile?.id != profile.id) {
        _fillForm(profile);
      }
    }
  }

  void _fillForm(Profile profile) {
    _initialProfile = profile;
    _firstName.text = profile.firstName;
    _lastName.text = profile.lastName;
    _email.text = profile.email;
    _sex.value = profile.sex;
    _birthDate.value = profile.birthDate;
    _height.text = profile.height?.toString() ?? '';
    _weight.text = profile.weight?.toString() ?? '';
    _aboutMe.text = profile.aboutMe ?? '';
    _onFormChanged();
  }

  void _onFormChanged() {
    if (mounted) {
      setState(() {});
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

        final canSave = profile != null && state is! ProfileStateProcessing && _isValid && _isChanged;

        return VmScaffold(
          appBar: AppBar(
            title: const Text('Редактирование'),
          ),
          body: body ?? _buildForm(profile!, state is ProfileStateProcessing),
          persistentFooterButtons: [
            if (profile != null)
              VmButton(
                loading: state is ProfileStateProcessing,
                enabled: canSave,
                onPressed: canSave ? _save : null,
                child: const Text('Сохранить'),
              ),
          ],
        );
      },
    );
  }

  Widget _buildForm(Profile profile, bool processing) {
    return SingleChildScrollView(
      child: Column(
        spacing: 16.0,
        children: [
          _AvatarEditor(
            profile: profile,
            processing: processing,
            onPickAvatar: _pickAvatar,
          ),

          // Имя
          VmLabel(
            title: const Text('Имя'),
            child: VmTextField(
              controller: _firstName,
              errorText: _firstNameError,
              keyboardType: TextInputType.name,
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
              errorText: _lastNameError,
              keyboardType: TextInputType.name,
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
              errorText: _birthDateError,
              helperText: 'Пользователям будет виден только Ваш возраст',
            ),
          ),

          // Пол
          VmLabel(
            title: const Text('Пол'),
            child: SexField2(
              controller: _sex,
              errorText: _sexError,
            ),
          ),

          // Рост
          VmLabel(
            title: const Text('Рост'),
            child: HeightField(
              controller: _height,
              errorText: _heightError,
            ),
          ),

          // Вес
          VmLabel(
            title: const Text('Вес'),
            child: WeightField(
              controller: _weight,
              errorText: _weightError,
            ),
          ),

          // О себе
          VmLabel(
            title: const Text('О себе'),
            child: VmTextField(
              controller: _aboutMe,
              errorText: _aboutMeError,
              hintText: 'Мастер спорта по хоккею',
              maxLength: 300,
              maxLines: 5,
            ),
          ),

          // Отступ снизу
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  bool get _isValid =>
      _firstNameError == null &&
      _lastNameError == null &&
      _birthDateError == null &&
      _sexError == null &&
      _heightError == null &&
      _weightError == null &&
      _aboutMeError == null;

  bool get _isChanged {
    final old = _initialProfile;
    if (old == null) return false;

    final next = _buildNewProfile(old);
    return next.firstName != old.firstName ||
        next.lastName != old.lastName ||
        !DateUtils.isSameDay(next.birthDate, old.birthDate) ||
        next.sex != old.sex ||
        next.height != old.height ||
        next.weight != old.weight ||
        next.aboutMe != old.aboutMe;
  }

  String? get _firstNameError {
    final value = _firstName.text.trim();
    if (value.isEmpty) return 'Укажите имя';
    if (value.length > 80) return 'Не больше 80 символов';
    return null;
  }

  String? get _lastNameError {
    final value = _lastName.text.trim();
    if (value.isEmpty) return 'Укажите фамилию';
    if (value.length > 80) return 'Не больше 80 символов';
    return null;
  }

  String? get _birthDateError {
    final value = _birthDate.value;
    if (value == null) return 'Укажите дату рождения';
    if (value.isAfter(DateTime.now())) return 'Дата не может быть в будущем';
    return null;
  }

  String? get _sexError => _sex.value == null ? 'Укажите пол' : null;

  String? get _heightError {
    if (_height.text.isEmpty) return null;
    return validateHeight(_height.text) ? null : 'Укажите рост от 120 до 240 см';
  }

  String? get _weightError {
    if (_weight.text.isEmpty) return null;
    return validateWeight(_weight.text) ? null : 'Укажите вес от 30 до 200 кг';
  }

  String? get _aboutMeError {
    if (_aboutMe.text.trim().length > 300) return 'Не больше 300 символов';
    return null;
  }

  void _save() {
    final profile = _initialProfile;
    if (profile == null || !_isValid || !_isChanged) return;

    _closeOnSuccess = true;
    _controller.update(_buildNewProfile(profile));
  }

  Future<void> _pickAvatar() async {
    if (_controller.state is ProfileStateProcessing) return;

    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      requestFullMetadata: false,
    );
    if (image == null) return;

    _controller.uploadAvatar(File(image.path));
  }

  Profile _buildNewProfile(Profile old) {
    return old.copyWith(
      firstName: _firstName.text.trim(),
      lastName: _lastName.text.trim(),
      birthDate: _birthDate.value,
      sex: _sex.value,
      height: _height.text.isEmpty ? null : int.tryParse(_height.text),
      weight: _weight.text.isEmpty ? null : int.tryParse(_weight.text),
      aboutMe: _aboutMe.text.trim().isEmpty ? null : _aboutMe.text.trim(),
    );
  }
}

class _AvatarEditor extends StatelessWidget {
  const _AvatarEditor({
    required this.profile,
    required this.processing,
    required this.onPickAvatar,
  });

  final Profile profile;
  final bool processing;
  final VoidCallback onPickAvatar;

  @override
  Widget build(BuildContext context) {
    final photoUrl = profile.photoUrl;
    final heroTag = avatarHeroTag(profile.id);

    if (photoUrl == null || photoUrl.isEmpty) {
      return GestureDetector(
        onTap: processing ? null : onPickAvatar,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            VmAvatar.large(label: profile.firstName),
            Container(
              width: 96.0,
              height: 96.0,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(50),
                shape: BoxShape.circle,
              ),
            ),
            if (processing) VmLoader.small() else const Icon(Icons.camera_alt_outlined, color: Colors.white),
          ],
        ),
      );
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () => _openAvatar(context, photoUrl, heroTag),
          child: AvatarHero(
            tag: heroTag,
            child: VmAvatar.large(
              photoUrl: photoUrl,
              label: profile.firstName,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        VmButton(
          style: VmButtonStyle.secondary,
          stretched: false,
          loading: processing,
          onPressed: processing ? null : onPickAvatar,
          child: const Text('Изменить фотографию'),
        ),
      ],
    );
  }

  void _openAvatar(BuildContext context, String photoUrl, Object heroTag) {
    VmNavigator.push(
      context,
      AvatarPreviewPage(
        photoUrl: photoUrl,
        heroTag: heroTag,
      ),
    );
  }
}
