import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:experimental/models/item.dart';
import 'package:experimental/pages/items/item_page.dart';
import 'package:experimental/state/item_notifier.dart'; // Import your ItemNotifier
import 'package:experimental/state/cart_notifier.dart';
import 'package:experimental/widgets/list_item_widget.dart';
import 'package:experimental/widgets/massive_headline_text.dart';
import 'package:gap/gap.dart';

class ItemsCatalog extends StatelessWidget {
  static const String routeName = '/items-catalog';

  const ItemsCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemNotifier =
        Provider.of<ItemNotifier>(context); // Access ItemNotifier
    final cartNotifier =
        Provider.of<CartNotifier>(context); // Access CartNotifier

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
      body: Column(
        children: [
          const Gap(16),
          const MassiveHeadlineText(text: 'Catalog'),
          Expanded(
            child: ListView.builder(
              itemCount:
                  itemNotifier.items.length, // Use the length from ItemNotifier
              itemBuilder: (context, index) {
                final item = itemNotifier.items[index];

                final imageUrl = item.images.isNotEmpty ? item.images[0] : null;

                return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ItemPage(item: item),
                        ),
                      );
                    },
                    child: ListItemWidget(
                      itemName: item.name,
                      itemDescription: item.description,
                      itemPrice: item.price,
                      image: imageUrl != null ? NetworkImage(imageUrl) : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
