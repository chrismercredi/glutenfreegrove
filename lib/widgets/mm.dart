import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MM extends StatelessWidget {
  const MM({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'MM',
      style: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.staatliches().fontFamily,
      ),
    );
  }
}
