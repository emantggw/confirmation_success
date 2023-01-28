import 'package:flutter/material.dart';
import 'dart:math' as math;

class CirPainter extends CustomPainter {
  final double deg;
  final double innerCirSize;
  final Offset refCenter;
  final Color color;
  CirPainter(
      {required this.deg,
      required this.innerCirSize,
      required this.refCenter,
      required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..color = color;

    canvas.drawArc(
        Offset(refCenter.dx - innerCirSize * 1.1,
                refCenter.dy - innerCirSize * 1.1) &
            Size(innerCirSize * 2.2, innerCirSize * 2.2),
        math.pi / 2, //radians
        deg, //radians
        false,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
