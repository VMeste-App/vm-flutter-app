import 'package:flutter/material.dart';
import 'package:vm_app/src/core/theme/colors.dart';

class VmEventCard extends StatelessWidget {
  const VmEventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.neutral4, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Футбольный матч в парке Горького',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Icon(Icons.calendar_month_outlined),
                SizedBox(width: 8),
                Text('Завтра в 01:04'),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox.square(
                    dimension: 5.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Text('2 часа'),
              ],
            ),
            const SizedBox(height: 12.0),
            const Row(
              children: [
                Icon(Icons.place_outlined),
                SizedBox(width: 8.0),
                Text('Парк Горького, поле №3'),
              ],
            ),
            const SizedBox(height: 16.0),
            const Wrap(
              spacing: 8.0,
              children: [
                _Chip(child: Text('Футбол')),
                _Chip(child: Text('18+')),
                _Chip(child: Icon(Icons.man_2_rounded, size: 20)),
              ],
            ),
            const SizedBox(height: 16.0),
            const _Members(),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('3000 Р'),
                SizedBox(
                  width: 120,
                  height: 48,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                      padding: EdgeInsets.zero,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    child: const Text('Участвовать'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: AppColors.neutral3,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        child: child,
      ),
    );
  }
}

class _Members extends StatelessWidget {
  const _Members({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('8 из 10 участников'),
            Text('Осталось 2', style: TextStyle(color: AppColors.blue3)),
          ],
        ),
        SizedBox(height: 8.0),
        Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                color: AppColors.neutral3,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 8.0,
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                color: AppColors.blue3,
              ),
              child: SizedBox(
                width: 200,
                height: 8.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// {@template event_card}
/// VmAvatar widget.
/// {@endtemplate}
class VmAvatar extends StatelessWidget {
  /// {@macro event_card}
  const VmAvatar({
    super.key, // ignore: unused_element_parameter
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: 32.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.neutral4,
          shape: BoxShape.circle,
        ),
        child: Center(child: Text('А')),
      ),
    );
  }
}
