import 'package:crossingwords/src/theme/main_theme.dart';
import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    Key? key,
    required this.backgroundColor,
    required this.icon,
    required this.onPressed,
    this.padding = 0.0,
    this.radius,
  }) : super(key: key);
  final Color backgroundColor;
  final Widget icon;
  final VoidCallback onPressed;
  final double padding;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: icon,
        ),
      ),
    );
  }
}
