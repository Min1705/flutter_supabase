import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartService with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];
  final SupabaseClient _client = Supabase.instance.client;

  List<Map<String, dynamic>> get cartItems => _cartItems;

  Future<void> fetchCartItems(String email) async {
    try {
      final response = await _client.rpc('exec_query', params: {
        'query': """
          SELECT
              orders.total_amount,
              products.title AS product_name,
              order_details.quantity,
              order_details.unit_price,
              order_details.total_price
          FROM
              customers
          JOIN
              orders ON customers.id = orders.customer_id
          JOIN
              order_details ON orders.id = order_details.order_id
          JOIN
              products ON order_details.product_id = products.id
          WHERE
              customers.email = '$email';
        """
      });

      if (response.error != null) {
        throw response.error!.message;
      }

      final data = response.data as List<dynamic>;
      _cartItems.clear(); // Reset danh sách trước khi thêm mới
      for (var item in data) {
        _cartItems.add({
          'product_name': item['product_name'],
          'quantity': item['quantity'],
          'unit_price': item['unit_price'],
          'total_price': item['total_price'],
          'total_amount': item['total_amount'],
        });
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching cart items: $e');
    }
  }

  // Thêm sản phẩm vào cart
  void addToCart(Map<String, dynamic> product) {
    _cartItems.add(product);
    notifyListeners();
  }

  // Xóa sản phẩm khỏi cart
  void removeFromCart(Map<String, dynamic> product) {
    _cartItems.remove(product);
    notifyListeners();
  }
}
