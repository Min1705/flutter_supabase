import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/product_model.dart';

class Category with ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Product>> getProductByCategoryId(int categoryId) async {
    try {
      final response = await _client
          .from('products')
          .select('id, title, price, image_url')
          .eq('category_id', categoryId);

      if (response.isEmpty) {
        throw Exception("No products found for category ID: $categoryId");
      }

      // Map the response to a list of Product objects
      return (response as List)
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching products by category: $e");
      return [];
    }
  }
}
