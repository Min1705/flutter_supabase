/*
import 'package:supabase/supabase.dart';

import 'package:test_supabase/app/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final SupabaseClient _client = SupabaseClientInstance.client;

  Future<List<Map<String, dynamic>>> getProfile() async {
    final response = await _client
        .from('customers')
        .select('full_name,email, phone_number, address, password');

    if (response.isEmpty) {
      throw Exception('No data returned from Supabase');
    }

    return List<Map<String, dynamic>>.from(response as List);
  }
}
*/
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getProfileByEmail(String email) async {
    final response = await _client
        .from('customers')
        .select('full_name, email, phone_number, address, password')
        .eq('email', email)
        .single();

    if (response.isEmpty) {
      throw Exception('No data returned for the specified email');
    }

    return List<Map<String, dynamic>>.from(response as List);
  }
}
