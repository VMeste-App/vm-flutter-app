import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/colors.dart';
import 'package:ui_kit/src/theme/typography.dart';

class VmText extends StatefulWidget {
  // dart format off
  const VmText.displayLarge(String this.text, {super.key, this.color, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines, this.selectable = false, this.emphasized = false, this.onTap}) : type = VmTypographySize.displayLarge, span = null;
  const VmText.displayMedium(String this.text, {super.key, this.color, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines, this.selectable = false, this.emphasized = false, this.onTap}) : type = VmTypographySize.displayMedium, span = null;
  const VmText.displaySmall(String this.text, {super.key, this.color, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines, this.selectable = false, this.emphasized = false, this.onTap}) : type = VmTypographySize.displaySmall, span = null;
  const VmText.headlineLarge(String this.text, {super.key, this.color, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines, this.selectable = false, this.emphasized = false, this.onTap}) : type = VmTypographySize.headlineLarge, span = null;
  const VmText.headlineMedium(String this.text, {super.key, this.color, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines, this.selectable = false, this.emphasized = false, this.onTap}) : type = VmTypographySize.headlineMedium, span = null;
  const VmText.headlineSmall(String this.text, {super.key, this.color, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines, this.selectable = false, this.emphasized = false, this.onTap}) : type = VmTypographySize.headlineSmall, span = null;
  const VmText.titleLarge(String this.text, {super.key, this.color, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines, this.selectable = false, this.emphasized = false, this.onTap}) : type = VmTypographySize.titleLarge, span = null;
  const VmText.titleMedium(String this.text, {super.key, this.color, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines, this.selectable = false, this.emphasized = false, this.onTap}) : type = VmTypographySize.titleMedium, span = null;
  const VmText.titleSmall(String this.text, {super.key, this.color, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines, this.selectable = false, this.emphasized = false, this.onTap}) : type = VmTypographySize.titleSmall, span = null;
  const VmText.bodyLarge(String this.text, {super.key, this.color, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines, this.selectable = false, this.emphasized = false, this.onTap}) : type = VmTypographySize.bodyLarge, span = null;
  const VmText.bodyMedium(String this.text, {super.key, this.color, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines, this.selectable = false, this.emphasized = false, this.onTap}) : type = VmTypographySize.bodyMedium, span = null;
  const VmText.bodySmall(String this.text, {super.key, this.color, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines, this.selectable = false, this.emphasized = false, this.onTap}) : type = VmTypographySize.bodySmall, span = null;
  const VmText.labelLarge(String this.text, {super.key, this.color, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines, this.selectable = false, this.emphasized = false, this.onTap}) : type = VmTypographySize.labelLarge, span = null;
  const VmText.labelMedium(String this.text, {super.key, this.color, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines, this.selectable = false, this.emphasized = false, this.onTap}) : type = VmTypographySize.labelMedium, span = null;
  const VmText.labelSmall(String this.text, {super.key, this.color, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines, this.selectable = false, this.emphasized = false, this.onTap}) : type = VmTypographySize.labelSmall, span = null;

  const VmText.rich({
    required InlineSpan this.span,
    required this.type,
    super.key,
    this.color,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    this.selectable = false,
    this.emphasized = false,
    this.onTap,
  }) : text = null;

  factory VmText.markup(
    String markup, {
    required VmTypographySize type,
    Key? key,
    Color? color,
    TextAlign textAlign = TextAlign.start,
    TextOverflow? overflow = TextOverflow.ellipsis,
    int? maxLines,
    bool selectable = false,
    bool emphasized = false,
    VoidCallback? onTap,
    Map<String, VmTextMarkupBuilder> builders = const {},
  }) {
    return VmText.rich(
      key: key,
      type: type,
      color: color,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      selectable: selectable,
      emphasized: emphasized,
      onTap: onTap,
      span: VmTextMarkup.parse(markup, builders: builders),
    );
  }
  // dart format on

  final String? text;
  final InlineSpan? span;
  final Color? color;
  final TextAlign textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final VmTypographySize type;
  final bool selectable;
  final bool emphasized;
  final VoidCallback? onTap;

  @override
  State<VmText> createState() => _VmTextState();
}

class _VmTextState extends State<VmText> {
  TapGestureRecognizer? _tapGestureRecognizer;

  bool get _isLink => widget.onTap != null;

  @override
  void initState() {
    super.initState();
    _updateTapGestureRecognizer();
  }

  @override
  void didUpdateWidget(covariant VmText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.onTap != widget.onTap) {
      _updateTapGestureRecognizer();
    }
  }

  @override
  void dispose() {
    _tapGestureRecognizer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = VmThemeColors.of(context);
    final baseStyle = VmTextStyles.getTextStyle(widget.type);
    final resolvedStyle = baseStyle.copyWith(
      color: widget.color ?? (_isLink ? colors.primary : colors.textPrimary),
      fontWeight: widget.emphasized ? FontWeight.w600 : null,
      overflow: widget.overflow,
      decoration: _isLink ? TextDecoration.underline : null,
      decorationColor: _isLink ? colors.primary : null,
    );
    final span = TextSpan(
      mouseCursor: widget.onTap != null ? SystemMouseCursors.click : null,
      recognizer: _tapGestureRecognizer,
      style: resolvedStyle,
      children: [
        widget.span ?? TextSpan(text: widget.text),
      ],
    );

    if (widget.selectable) {
      return SelectableText.rich(
        span,
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        selectionColor: colors.primary.withValues(alpha: 0.2),
      );
    }

    return Text.rich(
      span,
      textAlign: widget.textAlign,
      overflow: widget.overflow,
      maxLines: widget.maxLines,
      selectionColor: colors.primary.withValues(alpha: 0.2),
    );
  }

  void _updateTapGestureRecognizer() {
    _tapGestureRecognizer?.dispose();
    _tapGestureRecognizer = null;

    if (widget.onTap != null) {
      _tapGestureRecognizer = TapGestureRecognizer()..onTap = widget.onTap;
    }
  }
}

typedef VmTextMarkupBuilder = InlineSpan Function(VmTextMarkupTag tag);

class VmTextMarkupTag {
  const VmTextMarkupTag({
    required this.name,
    required this.children,
  });

  final String name;
  final List<InlineSpan> children;
}

abstract final class VmTextMarkup {
  static TextSpan parse(
    String markup, {
    Map<String, VmTextMarkupBuilder> builders = const {},
  }) {
    final root = _VmTextMarkupTagNode.root();
    final stack = <_VmTextMarkupTagNode>[root];
    final tagPattern = RegExp(r'<(/?)([a-zA-Z][\w-]*)>');
    var cursor = 0;

    for (final match in tagPattern.allMatches(markup)) {
      if (match.start > cursor) {
        stack.last.children.add(_VmTextMarkupTextNode(markup.substring(cursor, match.start)));
      }

      final isClosingTag = match.group(1) == '/';
      final tagName = match.group(2);
      if (tagName == null) return TextSpan(text: markup);

      if (isClosingTag) {
        if (stack.length == 1 || stack.last.name != tagName) {
          return TextSpan(text: markup);
        }

        stack.removeLast();
      } else {
        final tag = _VmTextMarkupTagNode(tagName);
        stack.last.children.add(tag);
        stack.add(tag);
      }

      cursor = match.end;
    }

    if (cursor < markup.length) {
      stack.last.children.add(_VmTextMarkupTextNode(markup.substring(cursor)));
    }

    if (stack.length != 1) {
      return TextSpan(text: markup);
    }

    return TextSpan(children: root.buildChildren(builders));
  }
}

sealed class _VmTextMarkupNode {
  InlineSpan build(Map<String, VmTextMarkupBuilder> builders);
}

final class _VmTextMarkupTextNode extends _VmTextMarkupNode {
  _VmTextMarkupTextNode(this.text);

  final String text;

  @override
  InlineSpan build(Map<String, VmTextMarkupBuilder> builders) => TextSpan(text: text);
}

final class _VmTextMarkupTagNode extends _VmTextMarkupNode {
  _VmTextMarkupTagNode(this.name);

  _VmTextMarkupTagNode.root() : name = null;

  final String? name;
  final List<_VmTextMarkupNode> children = <_VmTextMarkupNode>[];

  List<InlineSpan> buildChildren(Map<String, VmTextMarkupBuilder> builders) {
    return children.map((child) => child.build(builders)).toList(growable: false);
  }

  @override
  InlineSpan build(Map<String, VmTextMarkupBuilder> builders) {
    final builtChildren = buildChildren(builders);
    final name = this.name;

    if (name == null) return TextSpan(children: builtChildren);

    final builder = builders[name];
    if (builder == null) return TextSpan(children: builtChildren);

    return _VmTextMarkupInteractionExpander.expand(
      builder(VmTextMarkupTag(name: name, children: builtChildren)),
    );
  }
}

abstract final class _VmTextMarkupInteractionExpander {
  static InlineSpan expand(InlineSpan span) {
    return _expand(span, inherited: null);
  }

  static InlineSpan _expand(
    InlineSpan span, {
    required _VmTextMarkupInteraction? inherited,
  }) {
    if (span is! TextSpan) {
      return span;
    }

    final interaction = _VmTextMarkupInteraction.resolve(
      span,
      inherited: inherited,
    );

    return TextSpan(
      text: span.text,
      style: span.style,
      recognizer: interaction.recognizer,
      mouseCursor: interaction.explicitMouseCursor,
      onEnter: interaction.onEnter,
      onExit: interaction.onExit,
      semanticsLabel: span.semanticsLabel,
      semanticsIdentifier: span.semanticsIdentifier,
      locale: span.locale,
      spellOut: span.spellOut,
      children: span.children?.map((child) => _expand(child, inherited: interaction)).toList(growable: false),
    );
  }
}

final class _VmTextMarkupInteraction {
  const _VmTextMarkupInteraction({
    required this.recognizer,
    required this.explicitMouseCursor,
    required this.onEnter,
    required this.onExit,
  });

  factory _VmTextMarkupInteraction.resolve(
    TextSpan span, {
    required _VmTextMarkupInteraction? inherited,
  }) {
    final hasOwnRecognizer = span.recognizer != null;
    final hasOwnMouseCursor = span.mouseCursor != MouseCursor.defer;

    return _VmTextMarkupInteraction(
      recognizer: span.recognizer ?? inherited?.recognizer,
      explicitMouseCursor: hasOwnRecognizer
          ? _explicitMouseCursorForRecognizer(span.mouseCursor)
          : hasOwnMouseCursor
          ? span.mouseCursor
          : inherited?.explicitMouseCursor,
      onEnter: span.onEnter ?? inherited?.onEnter,
      onExit: span.onExit ?? inherited?.onExit,
    );
  }

  final GestureRecognizer? recognizer;
  final MouseCursor? explicitMouseCursor;
  final void Function(PointerEnterEvent event)? onEnter;
  final void Function(PointerExitEvent event)? onExit;

  static MouseCursor? _explicitMouseCursorForRecognizer(MouseCursor mouseCursor) {
    return mouseCursor == SystemMouseCursors.click ? null : mouseCursor;
  }
}
