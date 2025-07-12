import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template text_field}
/// VmTextField widget.
/// {@endtemplate}
class VmTextField extends StatelessWidget {
  /// {@macro text_field}
  const VmTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLines,
    this.minLines,
    this.readOnly = false,
    this.maxLength,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.onTapOutside,
    this.decoration,
    this.textAlign,
    this.enabled,
    this.onTap,
    this.enableInteractiveSelection,
    this.autofillHints,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType? keyboardType;

  /// {@macro flutter.widgets.TextField.textInputAction}
  final TextInputAction? textInputAction;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int? maxLines;

  /// {@macro flutter.widgets.editableText.minLines}
  final int? minLines;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.services.lengthLimitingTextInputFormatter.maxLength}
  final int? maxLength;

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final ValueChanged<String>? onSubmitted;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// {@macro flutter.widgets.editableText.onTapOutside}
  final TapRegionCallback? onTapOutside;

  final InputDecoration? decoration;

  final TextAlign? textAlign;

  final bool? enabled;
  final VoidCallback? onTap;
  final bool? enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.autofillHints}
  /// {@macro flutter.services.AutofillConfiguration.autofillHints}
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      autofocus: autofocus,
      obscureText: obscureText,
      autocorrect: autocorrect,
      maxLines: maxLines,
      minLines: minLines,
      readOnly: readOnly,
      maxLength: maxLength,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      onTapOutside: onTapOutside,
      style: const TextStyle(fontSize: 14, height: 1.25),
      decoration: decoration,
      textAlign: textAlign ?? TextAlign.start,
      onTap: onTap,
      enableInteractiveSelection: enableInteractiveSelection,
      autofillHints: autofillHints,
    );
  }
}
