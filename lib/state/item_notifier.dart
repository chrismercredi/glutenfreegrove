import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/models.dart';
import '../utils/utils.dart';

class ItemNotifier extends ChangeNotifier {
  List<Item> _items = [];
  bool _isLoading = false;

  ItemNotifier();

  List<Item> get items => _items;
  bool get isLoading => _isLoading;

  // Fetch items from the backend
  Future<void> fetchItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await supabase
          .from('items') // Replace with your table name
          .select();

      if (response.error == null) {
        _items = List<Item>.from(
          (response.data as List).map((item) => Item.fromMap(item)),
        );
      } else {
        // Handle errors
        print('Failed to load items: ${response.error?.message}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error fetching items: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Add other methods as needed, such as addItem, removeItem, etc.
}
