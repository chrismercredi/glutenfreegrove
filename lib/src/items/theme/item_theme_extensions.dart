import 'package:flutter/material.dart';

extension ItemThemeExtensions on ThemeData {
  // New method for the ElevatedButton style
  ButtonStyle blackSquareButtonStyle() {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black, // Text color
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Square corners
      ),
    );
  }

  // New method for the TextButton style
  ButtonStyle blackTextButtonStyle() {
    return TextButton.styleFrom(
      foregroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Square corners
      ), // Text color
    );
  }

  // New method for the OutlinedButton style
  ButtonStyle blackOutlinedButtonStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Square corners
      ),
      side: const BorderSide(color: Colors.black), // Black border
    );
  }
}
