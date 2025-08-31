import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vm_app/src/core/ui-kit/fields/date_time_field.dart';
import 'package:vm_app/src/core/ui-kit/fields/duration_field.dart';
import 'package:vm_app/src/core/ui-kit/fields/price_field.dart';
import 'package:vm_app/src/core/ui-kit/label.dart';
import 'package:vm_app/src/core/ui-kit/picker_group.dart';
import 'package:vm_app/src/core/ui-kit/switch_list_tile.dart';
import 'package:vm_app/src/core/ui-kit/text_field.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';
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
  // --- Activity ---
  ActivityID? _activity;
  final TextEditingController _activityController = TextEditingController();

  // --- Level ---
  final _levelController = ValueNotifier<LevelID?>(null);
  // LevelID? _level;

  // --- Members ---
  final TextEditingController _membersFrom = TextEditingController();
  final TextEditingController _membersTo = TextEditingController();
  final ValueNotifier<bool> _meAsMember = ValueNotifier<bool>(false);

  // --- Sex ---
  final _sexController = ValueNotifier<SexID?>(null);

  // --- Age ---
  final ValueNotifier<bool> _isAdult = ValueNotifier<bool>(false);
  final TextEditingController _ageFrom = TextEditingController();
  final TextEditingController _ageTo = TextEditingController();

  // --- Date and time ---
  // late final FDateFieldController _date = FDateFieldController(vsync: this);
  // late final FTimeFieldController _time = FTimeFieldController(vsync: this);
  final ValueNotifier<Duration?> _duration = ValueNotifier(null);

  // --- Price ---
  final TextEditingController _sharedCost = TextEditingController();
  final TextEditingController _individualCost = TextEditingController();

  // --- Description ---
  final TextEditingController _descriptionController = TextEditingController();

  // --- Error's controllers ---
  final ValueNotifier<String?> _activityError = ValueNotifier(null);
  final ValueNotifier<String?> _levelError = ValueNotifier(null);
  final ValueNotifier<String?> _sexError = ValueNotifier(null);

  // --- Keys ---
  final GlobalKey _activityKey = GlobalKey();
  final GlobalKey _levelKey = GlobalKey();
  final GlobalKey _sexKey = GlobalKey();

  @override
  void dispose() {
    _activityController.dispose();
    _levelController.dispose();
    _membersFrom.dispose();
    _membersTo.dispose();
    _meAsMember.dispose();
    // _sexController.dispose();
    _isAdult.dispose();
    _ageFrom.dispose();
    _ageTo.dispose();
    // _date.dispose();
    // _time.dispose();
    _duration.dispose();
    _sharedCost.dispose();
    _individualCost.dispose();
    _descriptionController.dispose();

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
            // --- Activity ---
            VmLabel(
              title: const Text('Активность'),
              child: ValueListenableBuilder(
                key: _activityKey,
                valueListenable: _activityError,
                builder: (context, value, _) =>
                    ActivityField(onChanged: (value) => _activity = value, errorText: value),
              ),
            ),

            spacer,

            // --- Level ---
            VmLabel(
              key: _levelKey,
              padding: EdgeInsets.zero,
              titlePadding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              title: const Text('Уровень'),
              child: VmPickerGroup(
                controller: _levelController,
                items: Level.values.map((e) => PickerItem(id: e.id, title: e.name)).toList(),
              ),
            ),

            spacer,

            // --- Members ---
            VmLabel(
              title: const Text('Участники'),
              child: _RowListTile(
                children: [
                  VmTextField(
                    controller: _membersFrom,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Кол-во от', counterText: ''),
                    maxLength: 2,
                  ),
                  VmTextField(
                    controller: _membersTo,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'до', counterText: ''),
                    maxLength: 3,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),

            VmSwitchListTile.controlled(_meAsMember, title: const Text('Добавить меня в список участников')),
            spacer,

            /// --- Sex ---
            VmLabel(
              key: _sexKey,
              padding: EdgeInsets.zero,
              titlePadding: const EdgeInsets.only(left: 16.0),
              title: const Text('Пол'),
              child: VmPickerGroup(
                controller: _sexController,
                items: Sex.values.map((e) => PickerItem(id: e.id, title: e.name)).toList(),
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
                  const SizedBox(height: 8.0),
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
            const VmLabel(
              title: Text('Дата и время'),
              child: Row(
                spacing: 20,
                children: [
                  Flexible(child: DateTimeField()),
                  Flexible(child: DurationField()),
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
                  VmSwitchListTile.controlled(_meAsMember, title: const Text('Разделить на всех')),
                  PriceField(controller: _sharedCost, hintText: 'Стоимость'),
                ],
              ),

              // _RowListTile(

              //   children: [
              //     PriceField(controller: _sharedCost, hintText: 'Общие расходы'),
              //     PriceField(controller: _individualCost, hintText: 'Индивидуальные'),
              //   ],
              // ),
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
      persistentFooterButtons: [FilledButton(onPressed: _validate, child: const Text('Создать'))],
    );
  }

  bool _validate() {
    BuildContext? ctx;
    if (_activity == null) {
      _activityError.value = 'Выберите активность';
      ctx ??= _activityKey.currentContext;
    } else {
      _activityError.value = null;
    }

    if (_levelController.value == null) {
      _levelError.value = 'Выберите уровень';
      ctx ??= _levelKey.currentContext;
    } else {
      _activityError.value = null;
    }

    if (_sexController.value == null) {
      _sexError.value = 'Укажите пол участников';
      ctx ??= _sexKey.currentContext;
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

    const bool isValid = true;

    // if (_activity == null) {
    //   _activityError.value = 'Error';
    //   isValid = false;
    // }

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
