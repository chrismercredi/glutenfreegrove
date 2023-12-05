import 'dart:async';

import 'package:experimental/state/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/models.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../../theme/theme.dart' show ItemThemeExtensions;

class ItemPage extends StatefulWidget {
  final Item item;
  final int ipsumParagraphs;
  final CartNotifier cartNotifier;

  const ItemPage({
    super.key,
    required this.item,
    required this.cartNotifier,
    this.ipsumParagraphs = 3,
  });

  static const String routeName = '/items-page';

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final ValueNotifier<int> itemCount = ValueNotifier<int>(0);
  Timer? _debounceTimer;

  @override
  void dispose() {
    itemCount.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String paragraphsOfIpsum = IpsumGenerator.generate(widget.ipsumParagraphs);
    return Scaffold(
      key: const Key('items-page'),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: pageColumnPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(16),
                MassiveHeadlineText(
                  text: widget.item.name, // Using Item's name
                ),
                const Gap(16),
                ImageAnimatedCounter(itemCount: itemCount),
                const Gap(16),
                ListTile(
                  title: Text(
                    widget.item.name, // Using Item's name
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.bebasNeue().fontFamily),
                  ),
                  subtitle: Text(
                    widget.item.description, // Using Item's description
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.amaticSc().fontFamily),
                  ),
                  trailing: Text(
                    '\$${widget.item.price.toStringAsFixed(2)}', // Using Item's price
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.bebasNeue().fontFamily),
                  ),
                ),
                const Gap(16),
                const Gap(16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add the item to the cart
                      widget.cartNotifier.addItem(widget.item);

                      // Update the itemCount
                      setState(() {
                        itemCount.value++;
                      });
                    },
                    style: Theme.of(context).blackSquareButtonStyle(),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('+1 to cart'),
                    ),
                  ),
                ),
                const Gap(16),
                CartAdjustButton(
                  itemCount: itemCount.value,
                  onButtonPressed: () {
                    setState(() {
                      if (itemCount.value > 0) {
                        // Add the item to the cart
                        widget.cartNotifier.removeItem(widget.item.id);
                      }
                    });

                    // Update the itemCount
                    setState(() {
                      itemCount.value--;
                    });
                  },
                ),
                const Gap(16),
                Text(
                  paragraphsOfIpsum,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const Gap(48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
