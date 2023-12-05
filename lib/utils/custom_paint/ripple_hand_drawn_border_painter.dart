import 'dart:math';

import 'package:flutter/material.dart';

class RippleHandDrawnBorderPainter extends CustomPainter {
  final List<Offset> _smoothOffsets;
  final double _strokeWidth = 2.0;
  final Color _color = Colors.black;

  RippleHandDrawnBorderPainter()
      : _smoothOffsets = _generateSmoothOffsets(10, 30);

  static List<Offset> _generateSmoothOffsets(int count, double range) {
    final random = Random();
    final List<Offset> offsets = List.generate(
        count,
        (index) => Offset(random.nextDouble() * range - range / 2,
            random.nextDouble() * range - range / 2));
    return _interpolateOffsets(offsets);
  }

  static List<Offset> _interpolateOffsets(List<Offset> offsets) {
    final List<Offset> smoothOffsets = [];
    for (int i = 0; i < offsets.length - 1; i++) {
      smoothOffsets.add(offsets[i]);
      // Linear interpolation between points
      final dxStep = (offsets[i + 1].dx - offsets[i].dx) / 10;
      final dyStep = (offsets[i + 1].dy - offsets[i].dy) / 10;
      for (int j = 1; j < 10; j++) {
        smoothOffsets.add(
            Offset(offsets[i].dx + dxStep * j, offsets[i].dy + dyStep * j));
      }
    }
    smoothOffsets.add(offsets.last); // Add the last point
    return smoothOffsets;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;

    var path = Path();
    path.moveTo(0, 0);

    // Apply the smoother offsets
    for (double i = 0; i <= size.width; i++) {
      path.lineTo(i, _smoothOffsets[(i % _smoothOffsets.length).toInt()].dy);
    }
    for (double i = 0; i <= size.height; i++) {
      path.lineTo(
          size.width + _smoothOffsets[(i % _smoothOffsets.length).toInt()].dx,
          i);
    }
    for (double i = size.width; i >= 0; i--) {
      path.lineTo(i,
          size.height + _smoothOffsets[(i % _smoothOffsets.length).toInt()].dy);
    }
    for (double i = size.height; i >= 0; i--) {
      path.lineTo(_smoothOffsets[(i % _smoothOffsets.length).toInt()].dx, i);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
