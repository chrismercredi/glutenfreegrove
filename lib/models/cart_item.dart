import '../src/items/models/item.dart';

class CartItem {
  final Item item;
  int quantity;

  CartItem({required this.item, this.quantity = 1});

  double get totalPrice => item.isSale && item.salePrice != null
      ? item.salePrice! * quantity
      : item.price * quantity;
}
