import 'package:supabase_flutter/supabase_flutter.dart';
import '../app/supabase_client.dart';

class SupabaseService {
  final SupabaseClient _client = SupabaseClientInstance.client;

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
