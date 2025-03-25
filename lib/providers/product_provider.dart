import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/models/product_model.dart';
import 'package:shopping_cart/services/api_service.dart';


final productProvider = StateNotifierProvider<ProductNotifier, AsyncValue<List<Product>>>((ref) {
  return ProductNotifier();
});

class ProductNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  int _page = 0;
  final ApiService _apiService = ApiService();

  ProductNotifier() : super(const AsyncValue.loading()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final newProducts = await _apiService.fetchProducts(skip: _page * 10);
      state = AsyncValue.data([...state.value ?? [], ...newProducts]);
      _page++;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}