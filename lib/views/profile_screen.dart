import 'package:flutter/material.dart';
import 'package:test_supabase/views/login_screen.dart';
import 'package:test_supabase/widgets/bottom_navigation_bar.dart';

class ProfileScreen extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const ProfileScreen(
      {super.key, required this.onTap, required this.currentIndex});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              const LoginScreen();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to your profile!'),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: widget.currentIndex, // Truyền giá trị currentIndex
        onTap: widget.onTap, // Truyền hàm onTap
      ),
    );
  }
}
