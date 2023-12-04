import 'package:fast_noise/fast_noise.dart';
import 'package:flutter/material.dart';

class HandDrawnBorderPainterPerlin extends CustomPainter {
  NoiseType noiseType = NoiseType.perlin;
  int octaves = 5;
  double frequency = 0.05;
  late List<List<double>> noiseArray;

  HandDrawnBorderPainterPerlin() {
    noiseArray = noise2(
      1000,
      1000,
      noiseType: noiseType,
      octaves: octaves,
      frequency: frequency,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    var path = Path();
    path.moveTo(0, 0);

    // Drawing the border using the noise array
    for (double i = 0; i <= size.width; i++) {
      double noiseValue = noise(i, 0) * 4; // Adjust the noise scaling as needed
      path.lineTo(i, noiseValue);
    }
    for (double i = 0; i <= size.height; i++) {
      double noiseValue =
          noise(size.width, i) * 4; // Adjust the noise scaling as needed
      path.lineTo(size.width, i + noiseValue);
    }
    for (double i = size.width; i >= 0; i--) {
      double noiseValue =
          noise(i, size.height) * 4; // Adjust the noise scaling as needed
      path.lineTo(i, size.height + noiseValue);
    }
    for (double i = size.height; i >= 0; i--) {
      double noiseValue = noise(0, i) * 4; // Adjust the noise scaling as needed
      path.lineTo(0, i + noiseValue);
    }

    canvas.drawPath(path, paint);
  }

  double noise(double x, double y) {
    int xi = x.toInt().clamp(0, noiseArray.length - 1);
    int yi = y.toInt().clamp(0, noiseArray[0].length - 1);
    return noiseArray[xi][yi];
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
