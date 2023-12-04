import 'package:flutter/material.dart';

extension ProfileThemeExtensions on ThemeData {
  InputDecoration emailInputDecoration() {
    return const InputDecoration(
      labelText: 'Email',
      labelStyle: TextStyle(
        color: Colors.black, // Label text color when it's not focused
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: Colors.black), // Underline color when focused
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: Colors.black), // Underline color when not focused
      ),
      // Adding cursor color here won't work, as it's not part of InputDecoration
    );
  }

  InputDecoration usernameInputDecoration() {
    return const InputDecoration(
      labelText: 'Username',
      labelStyle: TextStyle(
        color: Colors.black, // Label text color when it's not focused
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: Colors.black), // Underline color when focused
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: Colors.black), // Underline color when not focused
      ),
      // Adding cursor color here won't work, as it's not part of InputDecoration
    );
  }

  // Define a method for common text style
  TextStyle emailTextStyle() {
    return const TextStyle(
      color: Colors.black, // Text color
    );
  }

  // Define methods for cursor
  Color get emailCursorColor => Colors.black;
  double get emailCursorWidth => 8;

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
