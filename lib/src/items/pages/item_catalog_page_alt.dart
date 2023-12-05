import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../widgets/widgets.dart';
import '../items.dart';

// class ItemsCatalogAlt extends StatelessWidget {
//   final List<Item> items;

//   const ItemsCatalogAlt({
//     Key? key,
//     required this.items,
//   }) : super(key: key);

//   static const String routeName = '/items-catalog-alt';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             onPressed: () {}, // TODO: Implement search
//             icon: const Icon(
//               Icons.shopping_cart,
//               semanticLabel: 'Shopping cart',
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           const Gap(16),
//           const MassiveHeadlineText(text: 'Catalog' // Using Item's name
//               ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//                 final item = items[index];
//                 final imageUrl = item.images.isNotEmpty ? item.images[0] : null;

//                 return InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => ItemPage(item: item),
//                       ),
//                     );
//                   },
//                   child: ListItemWidgetAlt(
//                     itemName: item.name,
//                     itemDescription: item.description,
//                     itemPrice: item.price,
//                     image: imageUrl != null ? NetworkImage(imageUrl) : null,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:experimental/models/item.dart';
// import 'package:experimental/pages/items/item_page.dart';
// import 'package:experimental/widgets/list_item_widget_alt.dart';
// import 'package:experimental/widgets/massive_headline_text.dart';
// import 'package:flutter/material.dart';

// class ItemsCatalogAlt extends StatelessWidget {
//   final List<Item> items;

//   const ItemsCatalogAlt({
//     Key? key,
//     required this.items,
//   }) : super(key: key);

//   static const String routeName = '/items-catalog-alt';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             expandedHeight: 400.0,
//             floating: false,
//             pinned: true,
//             actions: [
//               IconButton(
//                 onPressed: () {}, // TODO: Implement search
//                 icon: const Icon(
//                   Icons.shopping_cart,
//                   semanticLabel: 'Shopping cart',
//                 ),
//               ),
//             ],
//             flexibleSpace: FlexibleSpaceBar(
//               title: const MassiveHeadlineText(text: 'Catalog'),
//               background: Image.network(
//                 'https://picsum.photos/seed/200/300', // Replace with your image asset
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 final item = items[index];
//                 final imageUrl = item.images.isNotEmpty ? item.images[0] : null;

//                 return InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => ItemPage(item: item),
//                       ),
//                     );
//                   },
//                   child: ListItemWidgetAlt(
//                     itemName: item.name,
//                     itemDescription: item.description,
//                     itemPrice: item.price,
//                     image: imageUrl != null ? NetworkImage(imageUrl) : null,
//                   ),
//                 );
//               },
//               childCount: items.length,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
