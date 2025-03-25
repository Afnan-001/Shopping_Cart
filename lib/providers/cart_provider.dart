import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/models/cart_item_model.dart';

import '../models/product_model.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) => CartNotifier());

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      state[index].quantity++;
    } else {
      state = [...state, CartItem(product: product)];
    }
  }

  void removeFromCart(int productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void updateQuantity(int productId, int newQuantity) {
    if (newQuantity <= 0) return removeFromCart(productId);
    state = state.map((item) {
      if (item.product.id == productId) item.quantity = newQuantity;
      return item;
    }).toList();
  }

  double get totalPrice => state.fold(0, (sum, item) => sum + item.totalPrice);
}