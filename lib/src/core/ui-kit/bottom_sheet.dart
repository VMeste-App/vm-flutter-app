import 'package:flutter/material.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';

class VmBottomSheet extends StatelessWidget {
  const VmBottomSheet({super.key, this.title, required this.body, this.action});

  final Widget? title;
  final Widget body;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      enableDrag: false,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(padding: EdgeInsets.only(top: 8.0), child: _DragHandle()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    const Spacer(),
                    if (title case final Widget title)
                      Expanded(
                        flex: 3,
                        child: Align(
                          child: DefaultTextStyle(
                            style: context.theme.textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                            child: title,
                          ),
                        ),
                      ),

                    const Flexible(
                      child: Align(alignment: Alignment.centerRight, child: CloseButton()),
                    ),
                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.all(16.0), child: body),
              if (action case final Widget action) Padding(padding: const EdgeInsets.all(16.0), child: action),
            ],
          ),
        );
      },
    );
  }
}

Future<T?> showVmBottomSheet<T>(BuildContext context, WidgetBuilder builder) {
  return showModalBottomSheet<T>(context: context, builder: builder, isScrollControlled: true);
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    final BottomSheetThemeData bottomSheetTheme = Theme.of(context).bottomSheetTheme;
    final handleSize = bottomSheetTheme.dragHandleSize ?? const Size(32, 4);

    return Container(
      height: handleSize.height,
      width: handleSize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(handleSize.height / 2),
        color: bottomSheetTheme.dragHandleColor ?? Colors.grey,
      ),
    );
  }
}
