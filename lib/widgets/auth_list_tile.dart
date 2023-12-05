import 'package:flutter/material.dart';

class AuthListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final Function() onButtonPressed;

  const AuthListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      title: Text(title),
      subtitle: Text(
        subtitle,
        maxLines: 2,
      ),
      trailing: TextButton(
        onPressed: onButtonPressed,
        child: Text(buttonText),
      ),
    );
  }
}
