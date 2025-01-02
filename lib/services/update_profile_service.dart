import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateProfileService {
  final SupabaseClient _client = Supabase.instance.client;
  Future<bool> updateUserProfile(String email, UserProfile userProfile) async {
    try {
      final response = await _client
          .from('customers')
          .update(userProfile.toJson())
          .eq('email', email)
          .single();
      if (kDebugMode) {
        print('Error updating profile ');
        return false;
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return false; // Xử lý lỗi
    }
  }
}

class UserProfile {
  final String fullName;
  final String address;
  final String phoneNumber;
  final String imgUrl;
  final String email;

  UserProfile({
    required this.fullName,
    required this.address,
    required this.phoneNumber,
    required this.imgUrl,
    required this.email,
  });

  // Hàm chuyển đổi từ JSON sang đối tượng UserProfile
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      fullName: json['full_name'] ?? 'Unknown',
      address: json['address'] ?? 'No address',
      phoneNumber: json['phone_number'] ?? 'No phone number',
      email: json['email'] ?? 'No Email',
      imgUrl: json['imgUrl'] ?? 'default.png',
    );
  }

  // Hàm chuyển đổi từ đối tượng UserProfile sang JSON
  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'address': address,
      'phone_number': phoneNumber,
      'email': email,
      'imgUrl': imgUrl,
    };
  }
}
