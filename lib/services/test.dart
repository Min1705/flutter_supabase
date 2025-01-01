// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// class AuthService with ChangeNotifier {
//   final SupabaseClient _client = Supabase.instance.client;
//
//   Future<bool> login(String email, String password) async {
//     try {
//       final response = await _client
//           .from('customers')
//           .select()
//           .eq('email', email)
//           .eq('password', password)
//           .single();
//       // Đăng nhập thành công
//       //return true;
//
//       if (response != null) {
//         final token = _generateToken();
//
//         // Cập nhật token vào cơ sở dữ liệu
//         await _client
//             .from('customers')
//             .update({'token': token}).eq('email', email);
//
//         // Trả về token
//         return token;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       // Xử lý ngoại lệ
//       print("erorrs Login: $e");
//       return null;
//     }
//   }
//
//   String _generateToken() {
//     const _chars =
//         'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
//     final _random = Random.secure();
//     return List.generate(32, (index) => _chars[_random.nextInt(_chars.length)])
//         .join();
//   }
// }
