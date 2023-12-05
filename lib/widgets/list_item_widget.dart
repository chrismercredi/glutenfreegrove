import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItemWidget extends StatelessWidget {
  final String itemName;
  final String itemDescription;
  final double itemPrice;
  final ImageProvider<Object>? image; // Optional image

  const ListItemWidget({
    Key? key,
    this.itemName = 'Item name',
    this.itemDescription = 'Item description',
    this.itemPrice = 20.0,
    this.image, // Image can be null
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        trailing: Text(
          '\$${itemPrice.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.bebasNeue().fontFamily,
          ),
        ),
      ),
    );
  }
}
