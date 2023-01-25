import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Cross extends StatelessWidget {
  const Cross({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100),
      painter: MyPainter(),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const pointMode = ui.PointMode.lines;
    final points = [
      const Offset(25, 75),
      const Offset(75, 25),
      const Offset(75, 75),
      const Offset(25, 25),
    ];
    final paint = Paint()
      ..color = Colors.red.withOpacity(0.6)
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
