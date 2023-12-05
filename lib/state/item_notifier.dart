import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/models.dart';

class ItemNotifier extends ChangeNotifier {
  final String apiUrl = 'https://your-api-url.com/items'; // Your API endpoint
  List<Item> _items = [];
  bool _isLoading = false;

  List<Item> get items => _items;
  bool get isLoading => _isLoading;

  // Fetch items from the backend
  Future<void> fetchItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Iterable json = jsonDecode(response.body);
        _items = List<Item>.from(json.map((model) => Item.fromMap(model)));
      } else {
        // Handle errors or non-200 responses
        print('Failed to load items');
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
