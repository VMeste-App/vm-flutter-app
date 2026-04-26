import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  runApp(const UiKitExampleApp());
}

enum DemoSex { male, female }

class UiKitExampleApp extends StatefulWidget {
  const UiKitExampleApp({super.key});

  @override
  State<UiKitExampleApp> createState() => _UiKitExampleAppState();
}

class _UiKitExampleAppState extends State<UiKitExampleApp> {
  var _themeMode = ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    final appTheme = VmTheme(mode: _themeMode);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI Kit',
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      themeMode: appTheme.mode,
      home: UiKitShowcaseScreen(
        themeMode: _themeMode,
        onThemeModeChanged: (value) => setState(() => _themeMode = value),
      ),
    );
  }
}

class UiKitShowcaseScreen extends StatefulWidget {
  const UiKitShowcaseScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  State<UiKitShowcaseScreen> createState() => _UiKitShowcaseScreenState();
}

class _UiKitShowcaseScreenState extends State<UiKitShowcaseScreen> {
  final _searchController = TextEditingController();
  final _priceController = TextEditingController();
  final _heightController = TextEditingController(text: '180');
  final _weightController = TextEditingController(text: '72');
  final _dateController = DateController(DateTime(2001, 1, 8));
  final _sexController = SexController<DemoSex>(DemoSex.male);
  final _pickerController = ValueNotifier<Object?>('home');
  final _switchController = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _searchController.dispose();
    _priceController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _dateController.dispose();
    _sexController.dispose();
    _pickerController.dispose();
    _switchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VmScaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: const Text('UI Kit'),
            actions: [
              IconButton(
                tooltip: 'Светлая тема',
                onPressed: () => widget.onThemeModeChanged(ThemeMode.light),
                icon: Icon(widget.themeMode == ThemeMode.light ? Icons.light_mode : Icons.light_mode_outlined),
              ),
              IconButton(
                tooltip: 'Темная тема',
                onPressed: () => widget.onThemeModeChanged(ThemeMode.dark),
                icon: Icon(widget.themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.dark_mode_outlined),
              ),
              const SizedBox(width: 8.0),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
            sliver: SliverList.list(
              children: [
                const _SectionTitle('Colors'),
                const _ColorGrid(),
                const _SectionTitle('Typography'),
                const _TypographyShowcase(),
                const SizedBox(height: 12.0),
                VmButton(
                  label: 'Открыть все стили текста',
                  style: VmButtonStyle.secondary,
                  role: VmButtonRole.accent,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const _TypographyPage(),
                    ),
                  ),
                ),
                const _SectionTitle('Buttons'),
                _ButtonsShowcase(onShowSheet: _showBottomSheet),
                const _SectionTitle('Chips'),
                const _ChipsShowcase(),
                const _SectionTitle('Cards'),
                const _CardsShowcase(),
                const _SectionTitle('Avatar'),
                const _AvatarShowcase(),
                const _SectionTitle('Lists'),
                _ListsShowcase(switchController: _switchController),
                const _SectionTitle('Fields'),
                _FieldsShowcase(
                  searchController: _searchController,
                  priceController: _priceController,
                  heightController: _heightController,
                  weightController: _weightController,
                  dateController: _dateController,
                  sexController: _sexController,
                ),
                const _SectionTitle('Pickers'),
                VmCard(
                  child: VmPickerGroup.controlled(
                    _pickerController,
                    items: const [
                      PickerItem(id: 'home', title: 'Для вас'),
                      PickerItem(id: 'remote', title: 'Удаленно'),
                      PickerItem(id: 'part_time', title: 'Подработка'),
                    ],
                  ),
                ),
                const _SectionTitle('Loading'),
                const _LoadingShowcase(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showBottomSheet() {
    return showVmBottomSheet<void>(
      context,
      (context) => VmBottomSheet(
        title: const Text('Bottom sheet'),
        body: const Text('Компонент для коротких выборов и подтверждений.'),
        action: VmButton(label: 'Готово', role: VmButtonRole.accent, onPressed: () => Navigator.pop(context)),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
      child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}

class _ColorGrid extends StatelessWidget {
  const _ColorGrid();

  @override
  Widget build(BuildContext context) {
    final colors = VmThemeColors.of(context);

    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: [
        _ColorSwatch('Primary', colors.primary),
        _ColorSwatch('Success', colors.success),
        _ColorSwatch('Accent', colors.accent),
        _ColorSwatch('Danger', colors.danger),
        _ColorSwatch('Surface', colors.surface),
        _ColorSwatch('Surface High', colors.surfaceHigh),
        _ColorSwatch('Border', colors.borderStrong),
        _ColorSwatch('Secondary Text', colors.textSecondary),
      ],
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch(this.label, this.color);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = VmThemeColors.of(context);

    return SizedBox(
      width: 150.0,
      child: VmCard(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 56.0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: colors.borderStrong),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(label, style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}

class _TypographyShowcase extends StatelessWidget {
  const _TypographyShowcase();

  @override
  Widget build(BuildContext context) {
    return VmCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VmText.displayLarge('Flutter / React Native Developer', maxLines: 2),
          const SizedBox(height: 12.0),
          const VmText.headlineMedium('от 500 \$ за месяц, на руки'),
          const SizedBox(height: 12.0),
          const VmText.bodyLarge(
            'Полная занятость · Стажировка · Опыт от 1 года до 3 лет · График 5/2',
            maxLines: 3,
          ),
          const SizedBox(height: 12.0),
          const VmText.bodySmall('Москва · опубликована 24 апреля'),
          const SizedBox(height: 12.0),
          VmText.markup(
            'Нажмите <link>подробнее</link>',
            type: VmTypographySize.bodyMedium,
            builders: {
              'link': (tag) => TextSpan(
                children: tag.children,
                style: TextStyle(color: VmThemeColors.of(context).primary),
              ),
            },
          ),
        ],
      ),
    );
  }
}

class _TypographyPage extends StatelessWidget {
  const _TypographyPage();

  @override
  Widget build(BuildContext context) {
    final colors = VmThemeColors.of(context);

    return VmScaffold(
      appBar: AppBar(title: const Text('Типографика')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
        children: [
          const _TypeSample('Display Large', VmText.displayLarge('Большой экранный заголовок')),
          const _TypeSample('Display Medium', VmText.displayMedium('Заголовок витрины')),
          const _TypeSample('Display Small', VmText.displaySmall('Крупный раздел')),
          const _TypeSample('Headline Large', VmText.headlineLarge('Flutter разработчик')),
          const _TypeSample('Headline Medium', VmText.headlineMedium('200 000 - 300 000 ₽')),
          const _TypeSample('Headline Small', VmText.headlineSmall('Курсы для вас')),
          const _TypeSample('Title Large', VmText.titleLarge('Статистика за неделю')),
          const _TypeSample('Title Medium', VmText.titleMedium('Выберите цель')),
          const _TypeSample('Title Small', VmText.titleSmall('Настройки')),
          const _TypeSample('Body Large', VmText.bodyLarge('Разрешите оповещать вас о сообщениях и звонках.')),
          const _TypeSample('Body Medium', VmText.bodyMedium('Вакансия перенесена в архив')),
          const _TypeSample('Body Small', VmText.bodySmall('Опубликована 24 апреля')),
          const _TypeSample('Label Large', VmText.labelLarge('Откликнуться')),
          const _TypeSample('Label Medium', VmText.labelMedium('Создать резюме')),
          const _TypeSample('Label Small', VmText.labelSmall('Сейчас смотрят')),
          _TypeSample(
            'Link',
            VmText.bodyMedium(
              'Поднять в поиске',
              color: colors.primary,
              onTap: () {},
            ),
          ),
          _TypeSample(
            'Selectable',
            VmText.bodyMedium(
              '+7 996 217-55-49',
              selectable: true,
              color: colors.textSecondary,
            ),
          ),
          _TypeSample(
            'Markup',
            VmText.markup(
              'Осталось <count>2 места</count> из 10',
              type: VmTypographySize.bodyMedium,
              builders: {
                'count': (tag) => TextSpan(
                  children: tag.children,
                  style: TextStyle(color: colors.warning, fontWeight: FontWeight.w600),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeSample extends StatelessWidget {
  const _TypeSample(this.label, this.child);

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: VmCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VmText.labelSmall(label, color: VmThemeColors.of(context).textSecondary),
            const SizedBox(height: 8.0),
            child,
          ],
        ),
      ),
    );
  }
}

class _ButtonsShowcase extends StatelessWidget {
  const _ButtonsShowcase({required this.onShowSheet});

  final VoidCallback onShowSheet;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.0,
      children: [
        VmButton(label: 'Откликнуться', role: VmButtonRole.accent, size: VmButtonSize.large, onPressed: onShowSheet),
        Row(
          spacing: 12.0,
          children: [
            Expanded(
              child: VmButton(
                label: 'Написать в чат',
                style: VmButtonStyle.secondary,
                role: VmButtonRole.accent,
                onPressed: () {},
              ),
            ),
            VmButton.iconOnly(
              label: 'В избранное',
              icon: const Icon(Icons.favorite_border),
              style: VmButtonStyle.secondary,
              onPressed: () {},
            ),
            VmButton.iconOnly(
              label: 'Фильтры',
              icon: const Icon(Icons.tune),
              style: VmButtonStyle.outline,
              role: VmButtonRole.accent,
              onPressed: () {},
            ),
          ],
        ),
        Row(
          spacing: 12.0,
          children: [
            Expanded(
              child: VmButton(
                label: 'Недоступно',
                enabled: false,
                onPressed: () {},
              ),
            ),
            Expanded(
              child: VmButton(
                label: 'Загрузка',
                loading: true,
                onPressed: () {},
              ),
            ),
          ],
        ),
        VmButton(
          label: 'Выйти из приложения',
          style: VmButtonStyle.ghost,
          role: VmButtonRole.destructive,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _ChipsShowcase extends StatelessWidget {
  const _ChipsShowcase();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: [
        VmChip(label: 'Для вас', selected: true),
        VmChip(label: 'У дома'),
        VmChip(label: 'Подработка'),
        VmChip(label: 'Можно без резюме', tone: VmChipTone.success),
        VmChip(label: 'Архив'),
      ],
    );
  }
}

class _CardsShowcase extends StatelessWidget {
  const _CardsShowcase();

  @override
  Widget build(BuildContext context) {
    final colors = VmThemeColors.of(context);

    return Column(
      spacing: 12.0,
      children: [
        VmCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Сейчас смотрят 4 человека',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colors.success),
                  ),
                  const Spacer(),
                  const Icon(Icons.favorite_border),
                ],
              ),
              const SizedBox(height: 16.0),
              Text('Flutter / React Native Developer (IOS)', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 12.0),
              Text('от 500 \$ за месяц', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16.0),
              const Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  VmChip(label: 'Опыт от 1 года до 3 лет'),
                  VmChip(label: 'Выплаты раз в месяц'),
                  VmChip(label: 'Можно без резюме', tone: VmChipTone.success),
                ],
              ),
            ],
          ),
        ),
        const Row(
          spacing: 12.0,
          children: [
            Expanded(
              child: VmCard(tone: VmCardTone.success, child: Text('186 человек\nуже откликнулось')),
            ),
            Expanded(
              child: VmCard(tone: VmCardTone.success, child: Text('5 человек\nсейчас смотрят')),
            ),
          ],
        ),
      ],
    );
  }
}

class _AvatarShowcase extends StatelessWidget {
  const _AvatarShowcase();

  @override
  Widget build(BuildContext context) {
    return const VmCard(
      child: Row(
        spacing: 16.0,
        children: [
          VmAvatar.small(label: 'VM'),
          VmAvatar.medium(label: 'VM'),
          VmAvatar.large(label: 'VM'),
        ],
      ),
    );
  }
}

class _ListsShowcase extends StatelessWidget {
  const _ListsShowcase({required this.switchController});

  final ValueNotifier<bool> switchController;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.0,
      children: [
        const VmListSection(
          children: [
            VmListSectionTile(title: 'Пользователь', leading: Icon(Icons.account_circle_outlined)),
            VmListSectionTile(title: 'Уведомления', leading: Icon(Icons.notifications_none_outlined)),
            VmListSectionTile(title: 'Звонки', leading: Icon(Icons.phone_iphone_outlined)),
            VmListSectionTile(title: 'Выйти из приложения', leading: Icon(Icons.logout), destructive: true),
          ],
        ),
        VmCard(
          padding: EdgeInsets.zero,
          child: VmSwitchListTile.controlled(switchController, title: const Text('Получать уведомления')),
        ),
      ],
    );
  }
}

class _FieldsShowcase extends StatelessWidget {
  const _FieldsShowcase({
    required this.searchController,
    required this.priceController,
    required this.heightController,
    required this.weightController,
    required this.dateController,
    required this.sexController,
  });

  final TextEditingController searchController;
  final TextEditingController priceController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final DateController dateController;
  final SexController<DemoSex> sexController;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.0,
      children: [
        VmLabel(
          title: const Text('Поиск'),
          child: VmTextField(
            controller: searchController,
            hintText: 'Должность, ключевые слова',
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search)),
          ),
        ),
        VmLabel(
          title: const Text('Стоимость'),
          child: PriceField(controller: priceController, hintText: '500'),
        ),
        const VmLabel(
          title: Text('Поле с ошибкой'),
          child: VmTextField(
            hintText: 'Введите email',
            errorText: 'Некорректный email',
            maxLines: 1,
          ),
        ),
        const VmLabel(
          title: Text('Отключенное поле'),
          child: VmTextField(
            hintText: 'Недоступно',
            helperText: 'Поле нельзя редактировать',
            enabled: false,
            maxLines: 1,
          ),
        ),
        VmLabel(
          title: const Text('Дата рождения'),
          child: DateField(controller: dateController),
        ),
        VmLabel(
          title: const Text('Пол'),
          child: SexField2<DemoSex>(controller: sexController, items: DemoSex.values, labelBuilder: _sexLabel),
        ),
        Row(
          spacing: 12.0,
          children: [
            Expanded(child: HeightField(controller: heightController)),
            Expanded(child: WeightField(controller: weightController)),
          ],
        ),
        const DateTimeField(hintText: 'Дата и время события'),
        const DurationField(),
      ],
    );
  }

  String _sexLabel(DemoSex sex) => switch (sex) {
    DemoSex.male => 'Мужской',
    DemoSex.female => 'Женский',
  };
}

class _LoadingShowcase extends StatelessWidget {
  const _LoadingShowcase();

  @override
  Widget build(BuildContext context) {
    final colors = VmThemeColors.of(context);

    return VmCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 16.0,
            children: [
              VmLoader.small(),
              VmLoader.medium(),
              VmLoader.large(),
            ],
          ),
          const SizedBox(height: 20.0),
          Shimmer(
            size: const Size(double.infinity, 76.0),
            radius: const Radius.circular(20.0),
            background: colors.surfaceHigh,
            highlight: colors.surfaceHighest,
          ),
        ],
      ),
    );
  }
}
