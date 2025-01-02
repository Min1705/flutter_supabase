import 'package:flutter/material.dart';
import 'package:test_supabase/services/auth_service.dart';
import 'package:test_supabase/views/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:test_supabase/views/update_profile_screen.dart';

import '../widgets/bottom_navigation_bar.dart';

class ProfileScreen extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const ProfileScreen({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _handleLogout() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userData = authService.userData;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('User  Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: userData != null
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Image
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(userData['imgUrl'] ?? ''),
                    ),
                    const SizedBox(height: 10),

                    // Basic Info
                    Text(
                      '${userData['full_name']}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${userData['email']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Personal Information Card
                    _buildInfoCard('Personal Information', [
                      _buildInfoRow('Full Name', userData['full_name']),
                      _buildInfoRow('Email', userData['email']),
                      _buildInfoRow('Phone Number', userData['phone_number']),
                      _buildInfoRow('Address', userData['address']),
                      _buildInfoRow('Password', userData['password']),
                    ]),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          // Thay đổi đường dẫn đến màn hình chỉnh sửa hồ sơ
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UpdateProfileScreen(), // Thay thế bằng màn hình chỉnh sửa hồ sơ của bạn
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Màu nền
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onTap,
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4, // Thêm độ nổi cho thẻ
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Bo góc cho thẻ
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
