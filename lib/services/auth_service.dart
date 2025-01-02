/*
import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

class AuthService with ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  String? _email;
  String? _token;
  String? _tokenTimer;

  String? get email => _email;
  String? get token => _token;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

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


  void logout() {
    _email = null;
    _token = null;
    notifyListeners();
  }
}
 */

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
import 'dart:math';

class AuthService with ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  String? _email;
  String? _token;
  Map<String, dynamic>? _userData;

  String? get email => _email;
  String? get token => _token;
  Map<String, dynamic>? get userData => _userData;
  String _generateToken() {
    final random = Random.secure();
    final values = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await _client
          .from('customers')
          .select()
          .eq('email', email)
          .eq('password', password)
          .single();
      if (response != null) {
        _email = email;
        _token = _generateToken();
        _userData = response;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }

  Future<void> fetchUserData() async {
    if (_email != null) {
      final response = await _client
          .from('customers')
          .select()
          .eq('email', _email!)
          .single();
      _userData = response;
      notifyListeners();
    }
  }

  void logout() {
    _email = null;
    _token = null;
    _userData = null;
    notifyListeners();
  }
}
