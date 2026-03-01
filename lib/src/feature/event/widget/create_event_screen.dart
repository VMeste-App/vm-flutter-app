import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vm_app/src/core/ui-kit/button.dart';
import 'package:vm_app/src/core/ui-kit/fields/date_time_field.dart';
import 'package:vm_app/src/core/ui-kit/fields/duration_field.dart';
import 'package:vm_app/src/core/ui-kit/fields/price_field.dart';
import 'package:vm_app/src/core/ui-kit/label.dart';
import 'package:vm_app/src/core/ui-kit/picker_group.dart';
import 'package:vm_app/src/core/ui-kit/switch_list_tile.dart';
import 'package:vm_app/src/core/ui-kit/text_field.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/shared/activity/model/activity.dart';
import 'package:vm_app/src/shared/activity/widget/activity_field.dart';
import 'package:vm_app/src/shared/level/model/level.dart';
import 'package:vm_app/src/shared/sex/model/sex.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final VmCreateEventMutable _event = VmCreateEventMutable();

  // Title
  final _titleKey = GlobalKey();
  final _titleController = TextEditingController();
  final _titleError = ValueNotifier<String?>(null);

  // Activity
  final _activityKey = GlobalKey();
  final _activityController = ValueNotifier<ActivityID?>(null);
  final _activityError = ValueNotifier<String?>(null);

  // Level
  final _levelKey = GlobalKey();
  final _levelController = ValueNotifier<SkillLevelID?>(null);
  final _levelError = ValueNotifier<String?>(null);

  // Members
  final _membersQtyUp = TextEditingController();
  final _membersQtyTo = TextEditingController();
  final _meAsMember = ValueNotifier<bool>(false);

  // Sex
  final _sexKey = GlobalKey();
  final _participantCategoryController = ValueNotifier<int?>(null);
  final _sexError = ValueNotifier<String?>(null);

  // Age
  final _isAdult = ValueNotifier<bool>(false);
  final _ageFrom = TextEditingController();
  final _ageTo = TextEditingController();

  // Date and time
  final _startDtController = ValueNotifier<DateTime?>(null);
  final _durationController = ValueNotifier<Duration?>(null);

  // Price
  final _cost = TextEditingController();
  final _perParticipantCost = ValueNotifier<bool>(false);

  // Description
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Listenable.merge([
      _titleController,
      _activityController,
      _levelController,
    ]).addListener(() {
      _event
        ..title = _titleController.text
        ..activityID = _activityController.value
        ..level = _levelController.value != null ? SkillLevel.byID(_levelController.value!) : null
        ..membersQtyUp = int.tryParse(_membersQtyUp.text)
        ..membersQtyTo = int.tryParse(_membersQtyTo.text)
        ..meAsMember = _meAsMember.value
        ..participantCategory = _participantCategoryController.value != null
            ? EventParticipantCategory.byID(_participantCategoryController.value!)
            : null
        ..membersAgeUp = int.tryParse(_ageFrom.text)
        ..membersAgeTo = int.tryParse(_ageTo.text)
        ..startDt = _startDtController.value
        ..duration = _durationController.value
        ..cost = int.tryParse(_cost.text)
        ..perMemberCost = _perParticipantCost.value
        ..description = _descriptionController.text;
    });
  }

  @override
  void dispose() {
    // Title
    _titleController.dispose();
    _titleError.dispose();
    // Activity
    _activityController.dispose();
    _activityError.dispose();
    // Level
    _levelController.dispose();
    _levelError.dispose();

    _membersQtyUp.dispose();
    _membersQtyTo.dispose();
    _meAsMember.dispose();
    _participantCategoryController.dispose();
    _isAdult.dispose();
    _ageFrom.dispose();
    _ageTo.dispose();
    // _date.dispose();
    // _time.dispose();
    // _duration.dispose();
    _cost.dispose();
    _descriptionController.dispose();
    _sexError.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 16.0);

    return SafeScaffold(
      appBar: AppBar(title: const Text('Новое событие')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            VmLabel(
              key: _titleKey,
              title: const Text('Название'),
              child: ValueListenableBuilder(
                valueListenable: _titleError,
                builder: (context, value, _) {
                  return VmTextField(
                    controller: _titleController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Название',
                      errorText: value,
                    ),
                  );
                },
              ),
            ),

            spacer,

            // Activity
            VmLabel(
              title: const Text('Активность'),
              child: ValueListenableBuilder(
                key: _activityKey,
                valueListenable: _activityError,
                builder: (context, value, _) => ActivityField(
                  onChanged: (value) => _activityController.value = value,
                  errorText: value,
                ),
              ),
            ),

            spacer,

            // Level
            VmLabel(
              key: _levelKey,
              padding: EdgeInsets.zero,
              titlePadding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              title: const Text('Уровень'),
              child: VmPickerGroup(
                controller: _levelController,
                items: SkillLevel.values.map((e) => PickerItem(id: e.id, title: context.l10n.level(e.name))).toList(),
              ),
            ),

            spacer,

            // --- Members ---
            VmLabel(
              title: const Text('Участники'),
              child: _RowListTile(
                children: [
                  VmTextField(
                    controller: _membersQtyUp,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Кол-во от', counterText: ''),
                    maxLength: 2,
                    textInputAction: TextInputAction.next,
                  ),
                  VmTextField(
                    controller: _membersQtyTo,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'до', counterText: ''),
                    maxLength: 3,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),

            VmSwitchListTile.controlled(
              _meAsMember,
              title: const Text('Добавить меня в список участников'),
            ),
            spacer,

            /// --- Sex ---
            VmLabel(
              key: _sexKey,
              padding: EdgeInsets.zero,
              titlePadding: const EdgeInsets.only(left: 16.0),
              title: const Text('Пол'),
              child: VmPickerGroup(
                controller: _participantCategoryController,
                items: EventParticipantCategory.values
                    .map((e) => PickerItem(id: e.id, title: context.l10n.participantCategory(e.name)))
                    .toList(),
              ),
            ),
            spacer,

            // --- Age ---
            VmLabel(
              title: const Text('Возраст'),
              padding: EdgeInsets.zero,
              titlePadding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Column(
                children: [
                  VmSwitchListTile.controlled(_isAdult, title: const Text('Только совершеннолетние')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ValueListenableBuilder(
                      valueListenable: _isAdult,
                      builder: (context, value, _) => _RowListTile(
                        children: [
                          VmTextField(
                            enabled: !value,
                            controller: _ageFrom,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(hintText: 'Возраст от', counterText: ''),
                            maxLength: 2,
                          ),
                          VmTextField(
                            enabled: !value,
                            controller: _ageTo,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(hintText: 'до', counterText: ''),
                            maxLength: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            spacer,

            // --- Datetime ---
            VmLabel(
              title: const Text('Дата и время'),
              child: Column(
                spacing: 12,
                children: [
                  DateTimeField(
                    onChanged: (dt) => _startDtController.value = dt,
                  ),
                  DurationField(
                    onChanged: (duration) => _durationController.value = duration,
                  ),
                ],
              ),
            ),

            spacer,

            // --- Price ---
            VmLabel(
              title: const Text('Цена'),
              padding: EdgeInsets.zero,
              titlePadding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ValueListenableBuilder(
                      valueListenable: _perParticipantCost,
                      builder: (context, split, _) => PriceField(
                        controller: _cost,
                        hintText: 'Стоимость',
                        helperText: !split ? 'Сумма разделится на всех учасников поровну' : null,
                      ),
                    ),
                  ),
                  VmSwitchListTile.controlled(
                    _perParticipantCost,
                    title: const Text('За каждого участника'),
                  ),
                ],
              ),
            ),

            spacer,

            // --- Description ---
            VmLabel(
              title: const Text('Описание'),
              child: VmTextField(
                controller: _descriptionController,
                decoration: const InputDecoration(hintText: 'Описание'),
                minLines: 4,
                maxLines: 10,
                maxLength: 1000,
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        VmButton(
          onPressed: _validate,
          // loading: ,
          child: const Text('Создать'),
        ),
      ],
    );
  }

  void _create() {
    if (!_validate()) return;
  }

  bool _validate() {
    var isValid = true;
    BuildContext? ctx;

    if (_event.title?.isEmpty ?? true) {
      _titleError.value = 'Укажите название';
      ctx ??= _titleKey.currentContext;
      isValid = false;
    } else {
      _titleError.value = null;
    }

    if (_event.activityID == null) {
      _activityError.value = 'Выберите активность';
      ctx ??= _activityKey.currentContext;
      isValid = false;
    } else {
      _activityError.value = null;
    }

    if (_event.level == null) {
      _levelError.value = 'Выберите уровень';
      ctx ??= _levelKey.currentContext;
      isValid = false;
    } else {
      _activityError.value = null;
    }

    if (_participantCategoryController.value == null) {
      _sexError.value = 'Укажите пол участников';
      ctx ??= _sexKey.currentContext;
      isValid = false;
    } else {
      _activityError.value = null;
    }

    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        alignment: 0.2,
      );

      HapticFeedback.heavyImpact();
    }

    return isValid;
  }
}

class _RowListTile extends StatelessWidget {
  const _RowListTile({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children.map((e) => Flexible(child: e)).toList(),
    );
  }
}
