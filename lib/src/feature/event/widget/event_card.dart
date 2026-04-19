import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vm_app/src/core/theme/colors.dart';
import 'package:vm_app/src/core/ui-kit/avatar.dart';
import 'package:vm_app/src/core/ui-kit/fields/duration_field.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/feature/favorite/widget/scope/favorite_event_scope.dart';

class VmEventCard extends StatelessWidget {
  const VmEventCard({
    super.key,
    required this.event,
    this.onPressed,
  });

  final VmEvent event;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card.outlined(
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
              // Название
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      event.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const _FavoriteButton(10),
                ],
              ),

              const SizedBox(height: 12),

              // Дата, время и место проведения
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat('dd MMMM HH:mm').format(event.dt), //  'Завтра в 01:04',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: SizedBox.square(
                              dimension: 5.0,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            event.duration.toText, // '2 часа',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      const Row(
                        children: [
                          Icon(
                            Icons.place_outlined,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Парк Горького, поле №3',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const VmAvatar.small(),
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
              const Padding(
                padding: EdgeInsetsDirectional.symmetric(vertical: 16.0),
                child: _Members(),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${event.cost} Р'),
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
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton(this.id);

  final VmEventId id;

  @override
  Widget build(BuildContext context) {
    final isFavorite = FavoriteScope$Event.isFavorite(context, id);
    final icon = isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded;

    return GestureDetector(
      onTap: () => isFavorite ? FavoriteScope$Event.remove(context, id) : FavoriteScope$Event.add(context, id),
      child: RepaintBoundary(
        child: Icon(
          icon,
          color: FavoriteScope$Event.isFavorite(context, id) ? Colors.red : null,
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
  const _Members();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '8 из 10 участников',
              style: TextStyle(color: Colors.grey),
            ),
            Text('Осталось 2', style: TextStyle(color: AppColors.orange1)),
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
                color: AppColors.orange1,
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
