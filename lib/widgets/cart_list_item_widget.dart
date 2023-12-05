import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

/// A smaller list item widget to display summary details
class CartListItemWidget extends StatelessWidget {
  final String itemName;
  final String itemDescription;
  final double itemPrice;
  final double itemQuantity;
  final ImageProvider<Object>? image; // Optional image

  const CartListItemWidget({
    Key? key,
    this.itemName = 'Item name',
    this.itemDescription = 'Item description',
    this.itemPrice = 20.0,
    this.itemQuantity = 3.0,
    this.image, // Image can be null
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double itemTotalPrice = itemPrice * itemQuantity; // Calculate total price

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black), // Black border
        color: Colors.white, // White background
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: image != null
            ? Image(image: image!)
            : const Icon(Icons.shopping_cart, size: 40.0), // Fallback to icon
        title: Text(
          itemName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.bebasNeue().fontFamily,
          ),
        ),
        subtitle: Text(
          itemDescription,
          style: TextStyle(
            fontSize: 16,
            fontFamily: GoogleFonts.amaticSc().fontFamily,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${itemPrice.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.bebasNeue().fontFamily,
              ),
            ),
            const Gap(4),
            Text(
              'x ${itemQuantity.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.bebasNeue().fontFamily,
              ),
            ),
            const Gap(4),
            Text(
              '= \$${itemTotalPrice.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.bebasNeue().fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
