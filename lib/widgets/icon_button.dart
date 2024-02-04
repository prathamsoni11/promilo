import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton(
      {super.key, required this.onPressed, required this.icon, this.iconSize});

  final void Function()? onPressed;
  final Widget icon;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: onPressed,
      icon: icon,
      iconSize: iconSize,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
