import 'package:experimental/models/item.dart';
import 'package:experimental/pages/items/item_page.dart';
import 'package:experimental/widgets/list_item_widget.dart';
import 'package:experimental/widgets/massive_headline_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ItemsCatalog extends StatelessWidget {
  final List<Item> items;

  const ItemsCatalog({
    Key? key,
    required this.items,
  }) : super(key: key);

  static const String routeName = '/items-catalog';

  @override
  Widget build(BuildContext context) {
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
          const MassiveHeadlineText(text: 'Catalog' // Using Item's name
              ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                // Check if there are any images in the item's images list
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
                      // Pass the imageUrl to the ListItemWidget
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
