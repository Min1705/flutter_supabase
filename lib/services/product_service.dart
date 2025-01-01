import 'package:supabase/supabase.dart';
import 'package:test_supabase/app/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = SupabaseClientInstance.client;

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final response = await _client.from('products').select();

    if (response.isEmpty) {
      throw Exception('No data returned from Supabase');
    }

    return List<Map<String, dynamic>>.from(response as List);
  }
}
