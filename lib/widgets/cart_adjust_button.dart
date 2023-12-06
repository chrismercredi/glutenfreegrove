import 'package:flutter/material.dart';

import '../src/items/theme/item_theme_extensions.dart';

class CartAdjustButton extends StatelessWidget {
  final int itemCount;
  final VoidCallback onButtonPressed;

  const CartAdjustButton({
    Key? key,
    required this.itemCount,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: itemCount > 0 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: itemCount > 0 ? 50.0 : 0.0,
        width: double.infinity,
        child: TextButton(
          onPressed: itemCount > 0 ? onButtonPressed : null,
          style: Theme.of(context).blackTextButtonStyle(),
          child: const Text('-1 to cart'),
        ),
      ),
    );
  }
}
