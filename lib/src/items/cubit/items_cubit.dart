import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../items.dart';

part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final ItemRepository itemRepository;

  ItemsCubit({required this.itemRepository}) : super(ItemsInitial());
  // Method to load all items
  Future<void> loadItems() async {
    try {
      emit(ItemsLoading());
      final items = await itemRepository.getAllItems();
      emit(ItemsLoaded(items));
    } catch (e) {
      emit(ItemsError(e.toString()));
    }
  }

  // Method to add an item
  Future<void> addItem(Item item) async {
    try {
      emit(ItemsLoading());
      final newItem = await itemRepository.createItem(item);
      // Optionally, you can fetch all items again or update the state list
      loadItems();
    } catch (e) {
      emit(ItemsError(e.toString()));
    }
  }

  // Method to update an item
  Future<void> updateItem(Item item) async {
    try {
      emit(ItemsLoading());
      final updatedItem = await itemRepository.updateItem(item);
      loadItems();
    } catch (e) {
      emit(ItemsError(e.toString()));
    }
  }

  // Method to delete an item
  Future<void> deleteItem(int itemId) async {
    try {
      emit(ItemsLoading());
      await itemRepository.deleteItem(itemId);
      loadItems();
    } catch (e) {
      emit(ItemsError(e.toString()));
    }
  }
}
