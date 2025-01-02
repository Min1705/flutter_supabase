import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart' as customer_user;

class RegisterService with ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  Future<bool> register(customer_user.User user) async {
    final response = await _client.from('customers').insert([
      {
        'email': user.email,
        'password': user.password,
        'full_name': user.fullName,
        'address': user.address,
        'phone_number': user.phoneNumber,
        'imgUrl': user.imgUrl,
      }
    ]);
    return true;
  }
}
