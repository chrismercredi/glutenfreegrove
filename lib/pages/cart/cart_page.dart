import 'package:experimental/utils/utils.dart';
import 'package:experimental/widgets/cart_list_item_widget.dart';
import 'package:experimental/widgets/cart_total_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../models/models.dart';
import '../../widgets/widgets.dart';
import '../pages.dart';

class CartPage extends StatelessWidget {
  final List<Item> items;

  const CartPage({
    Key? key,
    required this.items,
  }) : super(key: key);

  static const String routeName = '/cart-page';

  @override
  Widget build(BuildContext context) {
    List<double> itemPrices = items.map((item) => item.price).toList();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {}, // TODO: Implement search
            icon: const Icon(
              Icons.shopping_cart,
              semanticLabel: 'Shopping cart',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              children: [
                const Gap(16),
                const MassiveHeadlineText(text: 'Cart' // Using Item's name
                    ),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final imageUrl =
                          item.images.isNotEmpty ? item.images[0] : null;

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ItemPage(item: item),
                            ),
                          );
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                          child: CartListItemWidget(
                            itemName: item.name,
                            itemDescription: item.description,
                            itemPrice: item.price,
                            image: imageUrl != null
                                ? NetworkImage(imageUrl)
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CartTotalWidget(
                prices: itemPrices,
              ),
            )
          ],
        ),
      ),
    );
  }
}
