import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MassiveHeadlineText extends StatelessWidget {
  final String? text;
  const MassiveHeadlineText({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '?',
      style: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.staatliches().fontFamily,
      ),
    );
  }
}
