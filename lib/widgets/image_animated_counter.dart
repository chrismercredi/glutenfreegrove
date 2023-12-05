import 'package:animated_flip_counter/animated_flip_counter.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'jagged_container.dart';

class ImageAnimatedCounter extends StatefulWidget {
  final ValueNotifier<int> itemCount;

  const ImageAnimatedCounter({Key? key, required this.itemCount})
      : super(key: key);

  @override
  State<ImageAnimatedCounter> createState() => _ImageAnimatedCounterState();
}

class _ImageAnimatedCounterState extends State<ImageAnimatedCounter> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        JaggedContainer(
          strokeWidth: 4,
          onEdit: () {},
          aspectRatio: 1.0,
          networkImage: 'https://picsum.photos/600',
          maxHeight: 400,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              curve: Curves.bounceInOut,
              width: 96,
              height: widget.itemCount.value == 0 ? 0 : 96,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: AnimatedFlipCounter(
                value: widget.itemCount.value,
                textStyle: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.bebasNeue().fontFamily,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
