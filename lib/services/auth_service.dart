import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService with ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  Future<bool> login(String email, String password) async {
    try {
      final response = await _client
          .from('customers')
          .select()
          .eq('email', email)
          .eq('password', password)
          .single();
      // Đăng nhập thành công
      return true;
    } catch (e) {
      // Xử lý ngoại lệ
      print("errors Login: $e");
      return false;
    }
  }
}
