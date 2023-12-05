import 'dart:math';

import 'package:flutter/material.dart';

class JaggedHandDrawnBorderPainter extends CustomPainter {
  // Random offsets for the hand-drawn effect
  final List<Offset> _randomOffsets;
  final double strokeWidth;

  final Color _color = Colors.black;

  // Constructor to generate random offsets
  JaggedHandDrawnBorderPainter({this.strokeWidth = 4.0})
      : _randomOffsets = List.generate(
            100,
            (_) => Offset(
                Random().nextDouble() * 4 - 2, Random().nextDouble() * 4 - 2));

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    var path = Path();
    path.moveTo(0, 0);

    // Top border
    for (double i = 0; i <= size.width; i++) {
      path.lineTo(i, _randomOffsets[(i % _randomOffsets.length).toInt()].dy);
    }

    // Right border
    for (double i = 0; i <= size.height; i++) {
      path.lineTo(
          size.width + _randomOffsets[(i % _randomOffsets.length).toInt()].dx,
          i);
    }

    // Bottom border
    for (double i = size.width; i >= 0; i--) {
      path.lineTo(i,
          size.height + _randomOffsets[(i % _randomOffsets.length).toInt()].dy);
    }

    // Left border
    for (double i = size.height; i >= 0; i--) {
      path.lineTo(_randomOffsets[(i % _randomOffsets.length).toInt()].dx, i);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
