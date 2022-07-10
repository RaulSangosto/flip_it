import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/main_theme.dart';

class BackgrounCirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path bg = Path();
    bg.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = backgroundColor;
    canvas.drawPath(bg, paint);

    paint.color = purple.withOpacity(.3);

    canvas.drawCircle(Offset(width * -.1, height * -.02), width * .8, paint);
    canvas.drawCircle(Offset(width * .9, height * .05), width, paint);
    paint.color = purple.withOpacity(.2);
    canvas.drawCircle(Offset(width * -.2, height * 1.15), width * 1.2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class IntenseBackgrounCirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path bg = Path();
    bg.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = backgroundColor;
    canvas.drawPath(bg, paint);

    paint.color = green.withOpacity(.5);
    canvas.drawCircle(Offset(width * -.1, height * -.02), width * .8, paint);

    paint.color = green.withOpacity(.2);
    canvas.drawCircle(Offset(width * .9, height * .05), width, paint);

    paint.color = purple.withOpacity(.4);
    canvas.drawCircle(Offset(width * -.2, height * 1.15), width * 1.2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class BluredBackground extends StatelessWidget {
  const BluredBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: IntenseBackgrounCirclesPainter(),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: Colors.transparent,
          child: child,
        ),
      ),
    );
  }
}
