import 'package:supabase_flutter/supabase_flutter.dart';
import '../app/supabase_client.dart';
import '../models/product_model.dart';

class SupabaseService {
  final SupabaseClient _client = SupabaseClientInstance.client;

  Future<List<Product>> getAllProductModel() async {
    final response = await _client.from('products').select();

    if (response.isEmpty) {
      throw Exception('No data returned from Supabase');
    }

    return (response as List<dynamic>)
        .map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
  }

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

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final response = await _client
        .from('products')
        .select('title,price,description,image_url,stock_quantity');

    // Kiểm tra xem response có lỗi hay không
    if (response.isEmpty) {
      throw Exception('No data returned from Supabase');
    }

    // Chuyển đổi dữ liệu từ JSON thành danh sách Map
    return List<Map<String, dynamic>>.from(response as List);
  }
}
