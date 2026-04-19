import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
import 'package:vm_app/src/core/ui-kit/button.dart';
import 'package:vm_app/src/core/ui-kit/fields/date_time_field.dart';
import 'package:vm_app/src/core/ui-kit/fields/duration_field.dart';
import 'package:vm_app/src/core/ui-kit/fields/price_field.dart';
import 'package:vm_app/src/core/ui-kit/label.dart';
import 'package:vm_app/src/core/ui-kit/picker_group.dart';
import 'package:vm_app/src/core/ui-kit/scaffold.dart';
import 'package:vm_app/src/core/ui-kit/switch_list_tile.dart';
import 'package:vm_app/src/core/ui-kit/text_field.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';
import 'package:vm_app/src/feature/event/controller/create/vm_event_create_controller.dart';
import 'package:vm_app/src/feature/event/controller/create/vm_event_create_state.dart';
import 'package:vm_app/src/feature/event/model/create_event.dart';
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
  // --- 1. General ---
  final _title = TextEditingController();
  final _activity = ValueNotifier<ActivityId?>(null);

  // --- 2. Participants ---

  // 2.1 Skill Level
  final _level = ValueNotifier<SkillLevelId?>(null);

  // 2.2 Qty
  final _membersQtyUp = TextEditingController();
  final _membersQtyTo = TextEditingController();
  final _meAsMember = ValueNotifier<bool>(false);

  // 2.3 Category
  final _participantCategory = ValueNotifier<int?>(null);

  // 2.4 Age
  final _ageFrom = TextEditingController();
  final _ageTo = TextEditingController();
  final _isAdult = ValueNotifier<bool>(false);

  // --- 3. Date and time ---
  final _dt = ValueNotifier<DateTime?>(null);
  final _duration = ValueNotifier<Duration?>(null);

  // --- 4. Price ---
  final _cost = TextEditingController();
  final _isFree = ValueNotifier<bool>(false);
  final _perParticipantCost = ValueNotifier<bool>(false);

  // --- 5. Description ---
  final _description = TextEditingController();

  final _isValid = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    Listenable.merge([
      _title,
      _activity,
      _level,
      _membersQtyUp,
      _membersQtyTo,
      _meAsMember,
      _participantCategory,
      _isAdult,
      _ageFrom,
      _ageTo,
      _dt,
      _duration,
      _isFree,
      _cost,
      _perParticipantCost,
      _description,
    ]).addListener(_validate);
  }

  @override
  void dispose() {
    _title.dispose();
    _activity.dispose();
    _level.dispose();
    _membersQtyUp.dispose();
    _membersQtyTo.dispose();
    _meAsMember.dispose();
    _participantCategory.dispose();
    _ageFrom.dispose();
    _ageTo.dispose();
    _isAdult.dispose();
    _dt.dispose();
    _duration.dispose();
    _cost.dispose();
    _isFree.dispose();
    _perParticipantCost.dispose();
    _description.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 16.0);

    return ControllerScope<VmEventCreateController>(
      () => VmEventCreateController(
        repository: Dependencies.of(context).eventRepository,
        eventChanges: ValueNotifier(const VmEvent$Draft()),
      ),
      child: VmScaffold(
        appBar: AppBar(title: const Text('Новое событие')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              VmLabel(
                title: const Text('Название'),
                child: VmTextField(
                  controller: _title,
                  maxLines: 1,
                  decoration: const InputDecoration(hintText: 'Название'),
                ),
              ),

              spacer,

              // Activity
              VmLabel(
                title: const Text('Активность'),
                child: ActivityField(onChanged: (value) => _activity.value = value),
              ),

              spacer,

              // Level
              VmLabel(
                padding: EdgeInsets.zero,
                titlePadding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                title: const Text('Уровень'),
                child: VmPickerGroup(
                  controller: _level,
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
                      decoration: const InputDecoration(
                        hintText: 'Кол-во от',
                        counterText: '',
                      ),
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
                padding: EdgeInsets.zero,
                titlePadding: const EdgeInsets.only(left: 16.0),
                title: const Text('Пол'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VmPickerGroup(
                      controller: _participantCategory,
                      items: EventMembersType.values
                          .map((e) => PickerItem(id: e.id, title: context.l10n.participantCategory(e.name)))
                          .toList(),
                    ),
                  ],
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
                        builder: (context, isAdult, _) => _RowListTile(
                          children: [
                            VmTextField(
                              enabled: !isAdult,
                              controller: _ageFrom,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Возраст от',
                                counterText: '',
                              ),
                              maxLength: 2,
                            ),
                            VmTextField(
                              enabled: !isAdult,
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
                      onChanged: (dt) => _dt.value = dt,
                      buttonTextBuilder: (dt) => 'Начало ${DateFormat('dd MMMM HH:mm').format(dt)}',
                      // textBuilder: (dt) => 'Начало в ',
                    ),
                    DurationField(
                      onChanged: (duration) => _duration.value = duration,
                    ),
                  ],
                ),
              ),

              spacer,

              // --- Location ---
              VmLabel(
                title: const Text('Локация'),
                child: VmTextField(
                  readOnly: true,
                  enableInteractiveSelection: false,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Локация',
                    focusedBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                    prefixIcon: const Icon(Icons.date_range_outlined),
                  ),
                  onTap: () => VmNavigator.push(context, const VmPlacesPage()),
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
                    VmSwitchListTile.controlled(
                      _isFree,
                      title: const Text('Бесплатно'),
                    ),
                    ValueListenableBuilder(
                      valueListenable: _isFree,
                      builder: (context, isFree, child) {
                        return AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          alignment: Alignment.topCenter,
                          child: !isFree
                              ? Column(
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
                                )
                              : const SizedBox.shrink(),
                        );
                      },
                    ),
                  ],
                ),
              ),

              spacer,

              // --- Description ---
              VmLabel(
                title: const Text('Описание'),
                child: VmTextField(
                  controller: _description,
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
          ValueListenableBuilder(
            valueListenable: _isValid,
            builder: (context, isValid, child) {
              return StateConsumer<VmEventCreateController, VmEventCreateState>(
                buildWhen: (previous, current) => previous.isLoading != current.isLoading,
                builder: (context, state, _) {
                  return VmButton(
                    onPressed: state.isLoading || !isValid ? null : () => _create(context),
                    loading: state.isLoading,
                    child: const Text('Создать'),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _create(BuildContext context) {
    context.controllerOf<VmEventCreateController>().create(
      VmEvent$Create(
        title: _title.text,
        activityID: _activity.value!,
        levelID: _level.value!,
        membersQtyUp: int.parse(_membersQtyUp.text),
        membersQtyTo: int.parse(_membersQtyTo.text),
        meAsMember: _meAsMember.value,
        membersTypeID: _participantCategory.value!,
        membersAgeUp: _isAdult.value ? 18 : int.parse(_ageFrom.text),
        membersAgeTo: _isAdult.value ? null : int.parse(_ageTo.text),
        dt: _dt.value!,
        duration: _duration.value!,
        cost: _isFree.value ? 0 : int.parse(_cost.text),
        perMemberCost: _perParticipantCost.value,
        description: _description.text,
      ),
    );
  }

  void _validate() {
    bool isValid = true;

    if (_title.text.isEmpty) {
      isValid = false;
    }

    if (_activity.value == null) {
      isValid = false;
    }

    if (_level.value == null) {
      isValid = false;
    }

    if (_membersQtyUp.text.isEmpty || _membersQtyTo.text.isEmpty) {
      isValid = false;
    }

    if (_participantCategory.value == null) {
      isValid = false;
    }

    if (_dt.value == null) {
      isValid = false;
    }

    if (_duration.value == null) {
      isValid = false;
    }

    _isValid.value = isValid;
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
