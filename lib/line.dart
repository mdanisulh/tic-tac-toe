import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Line extends StatelessWidget {
  final int winStart, winEnd;
  const Line({super.key, this.winStart = 0, this.winEnd = 0});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 335),
      painter: MyPainter(winStart: winStart, winEnd: winEnd),
    );
  }
}

class MyPainter extends CustomPainter {
  final int winStart, winEnd;
  MyPainter({this.winStart = 0, this.winEnd = 0});
  @override
  void paint(Canvas canvas, Size size) {
    const pointMode = ui.PointMode.lines;
    late final List<Offset> points;
    if (winStart == 0 && winEnd == 2) {
      points = [const Offset(10, 50), const Offset(290, 50)];
    } else if (winStart == 0 && winEnd == 6) {
      points = [const Offset(52, 10), const Offset(52, 290)];
    } else if (winStart == 0 && winEnd == 8) {
      points = [const Offset(10, 10), const Offset(290, 290)];
    } else if (winStart == 2 && winEnd == 6) {
      points = [const Offset(292, 10), const Offset(12, 290)];
    } else if (winStart == 1 && winEnd == 7) {
      points = [const Offset(152, 10), const Offset(152, 290)];
    } else if (winStart == 2 && winEnd == 8) {
      points = [const Offset(252, 10), const Offset(252, 290)];
    } else if (winStart == 3 && winEnd == 5) {
      points = [const Offset(10, 150), const Offset(290, 150)];
    } else if (winStart == 6 && winEnd == 8) {
      points = [const Offset(10, 250), const Offset(290, 250)];
    }
    final paint = Paint()
      ..color = Colors.green.withOpacity(0.8)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
