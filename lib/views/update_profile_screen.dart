import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_supabase/services/auth_service.dart';

import '../services/update_profile_service.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _fullName;
  String? _phoneNumber;
  String? _address;
  String? _imgUrl;
  bool _isUpdated = false; // Trạng thái cập nhật

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userData = authService.userData;

    // Khởi tạo các trường với dữ liệu hiện tại
    _email = userData?['email'];
    _fullName = userData?['full_name'];
    _phoneNumber = userData?['phone_number'];
    _address = userData?['address'];
    _imgUrl = userData?['imgUrl']; // Nếu có

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: _fullName,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _fullName = value;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _email,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      enabled: false, // Không cho phép chỉnh sửa email
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _phoneNumber,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _phoneNumber = value;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _address,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _address = value;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Tạo đối tượng UserProfile từ các trường nhập liệu
                      UserProfile userProfile = UserProfile(
                        fullName: _fullName!,
                        address: _address!,
                        phoneNumber: _phoneNumber!,
                        email: _email!,
                        imgUrl: _imgUrl ??
                            'default.png', // Giá trị mặc định nếu không có
                      );

                      final updateProfileService = UpdateProfileService();
                      final success =
                          await updateProfileService.updateUserProfile(
                        _email!, // Email của người dùng
                        userProfile, // Đối tượng UserProfile
                      );

                      setState(() {
                        _isUpdated = true; // Cập nhật trạng thái
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile updated successfully!'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Màu nền
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Bạn cần Login để xem thông tin được cập nhật!'),
              const SizedBox(height: 20),
              if (_isUpdated)
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent, // Màu nền
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
