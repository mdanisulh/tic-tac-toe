import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Grid extends StatelessWidget {
  const Grid({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 300),
      painter: MyPainter(),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const pointMode = ui.PointMode.lines;
    final points = [
      const Offset(100, 0),
      const Offset(100, 300),
      const Offset(200, 0),
      const Offset(200, 300),
      const Offset(0, 100),
      const Offset(300, 100),
      const Offset(0, 200),
      const Offset(300, 200),
      // Offset(270, 100),
    ];
    final paint = Paint()
      ..color = Colors.purple.withOpacity(0.6)
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
