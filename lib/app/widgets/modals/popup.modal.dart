import 'package:Intellio/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomPopupModal extends StatelessWidget {
  final String? title;
  final Widget? content;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? contentPadding;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  final double? elevation;

  const CustomPopupModal({
    Key? key,
    this.title,
    this.content,
    this.actions,
    this.contentPadding,
    this.shape,
    this.backgroundColor,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title!, style: h2.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color),) : null,
      content: content,
      actions: actions,
      contentPadding: contentPadding ?? const EdgeInsets.all(20),
      shape: shape,
      backgroundColor: backgroundColor,
      elevation: elevation,
    );
  }
}