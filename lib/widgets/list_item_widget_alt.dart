import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Large list item detail with big image and overlayed details
class ListItemWidgetAlt extends StatelessWidget {
  final String itemName;
  final String itemDescription;
  final double itemPrice;
  final ImageProvider<Object>? image; // Optional image

  const ListItemWidgetAlt({
    Key? key,
    this.itemName = 'Item name',
    this.itemDescription = 'Item description',
    this.itemPrice = 20.0,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400, // Fixed height
      decoration: BoxDecoration(
        color: Colors.white, // White background
        border: Border.all(color: Colors.black), // Black border
      ),
      child: Stack(
        children: [
          // Image as the underlay
          Positioned.fill(
            child: image != null
                ? Image(image: image!, fit: BoxFit.cover)
                : const Icon(Icons.shopping_cart,
                    size: 100.0), // Fallback to icon
          ),
          // Overlay details at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color:
                    Colors.black.withOpacity(0.9), // Semi-transparent overlay
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Item name and description on the left
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: GoogleFonts.bebasNeue().fontFamily,
                          ),
                        ),
                        Text(
                          itemDescription,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: GoogleFonts.amaticSc().fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Price on the right
                  Text(
                    '\$${itemPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: GoogleFonts.bebasNeue().fontFamily,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
