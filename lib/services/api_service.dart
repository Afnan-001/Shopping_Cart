import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  final String baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts({int skip = 0, int limit = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl?limit=$limit&skip=$skip'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['products'] as List).map((e) => Product.fromJson(e)).toList();
    }
    throw Exception('Failed to load products');
  }
}