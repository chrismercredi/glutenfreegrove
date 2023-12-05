import 'package:experimental/theme/cart_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartTotalWidget extends StatefulWidget {
  const CartTotalWidget({super.key, required this.prices});

  final List<double> prices;

  @override
  State<CartTotalWidget> createState() => _CartTotalWidgetState();
}

class _CartTotalWidgetState extends State<CartTotalWidget> {
  double get subtotal =>
      widget.prices.reduce((value, element) => value + element);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      color: Colors.black, // Set the background color of the card to black
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // This makes the corners square
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Subtotal: \$${subtotal.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set text color to white
                  fontFamily: GoogleFonts.bebasNeue().fontFamily,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/checkout-page');
                },
                style: Theme.of(context)
                    .whiteTextButtonStyle(), // Use the updated style
                child: const Text(
                  'Checkout',
                  style:
                      TextStyle(color: Colors.black), // Set text color to black
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
