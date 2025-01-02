/*
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_supabase/services/auth_service.dart';
import 'package:test_supabase/services/banner_service.dart';
import 'package:test_supabase/services/cart_service.dart';
import 'package:test_supabase/services/register_service.dart';
import 'package:test_supabase/services/slide_show_service.dart';
import 'package:test_supabase/views/banner_screen.dart';
import 'package:test_supabase/views/cart_screen.dart';
import 'package:test_supabase/views/home_screen.dart';
import 'package:test_supabase/views/profile_screen.dart';
import 'package:test_supabase/views/slide_show_screen.dart';
import 'app/supabase_client.dart';
import 'package:provider/provider.dart';
import 'views/login_screen.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;
  const AuthGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, auth, _) {
        if (auth.token == null) {
          return const LoginScreen();
        }
        return child;
      },
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseClientInstance.supabaseUrl,
    anonKey: SupabaseClientInstance.supabaseAnonKey,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthService()),
      ChangeNotifierProvider(create: (_) => CartService()),
      ChangeNotifierProvider(create: (_) => RegisterService()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products List',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xffffffff)),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(
              currentIndex: 0,
              onTap: (index) {
                Navigator.popAndPushNamed(context, _getRouteForIndex(index));
              },
            ),
        '/cart': (context) => CartScreen(
              currentIndex: 2,
              onTap: (index) {
                Navigator.popAndPushNamed(context, _getRouteForIndex(index));
              },
            ),
        '/profile': (context) => ProfileScreen(
              currentIndex: 3,
              onTap: (index) {
                Navigator.popAndPushNamed(
                  context,
                  _getRouteForIndex(index),
                  //arguments: ModalRoute.of(context)!.settings.arguments,
                );
              },
            ),
      },
      debugShowCheckedModeBanner: false,
    );
  }

  String _getRouteForIndex(int index) {
    switch (index) {
      case 0:
        return '/home';
      case 1:
        return '/slideshow';
      case 2:
        return '/cart';
      case 3:
        return '/profile';
      default:
        return '/home';
    }
  }
}
*/

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_supabase/services/auth_service.dart';
import 'package:test_supabase/services/cart_service.dart';
import 'package:test_supabase/services/register_service.dart';
import 'package:test_supabase/views/home_screen.dart';
import 'package:test_supabase/views/cart_screen.dart';
import 'package:test_supabase/views/profile_screen.dart';
import 'app/supabase_client.dart';
import 'package:provider/provider.dart';
import 'views/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseClientInstance.supabaseUrl,
    anonKey: SupabaseClientInstance.supabaseAnonKey,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthService()),
      ChangeNotifierProvider(create: (_) => CartService()),
      ChangeNotifierProvider(create: (_) => RegisterService()),
      //ChangeNotifierProvider(create: (_) => ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products List',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xffffffff)),
      home: Consumer<AuthService>(
        builder: (context, auth, _) {
          return auth.token != null
              ? _buildHomeScreen(context, 0)
              : const LoginScreen();
        },
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(
              currentIndex: 0,
              onTap: (index) {
                Navigator.popAndPushNamed(context, _getRouteForIndex(index));
              },
            ),
        '/cart': (context) => CartScreen(
              currentIndex: 2,
              onTap: (index) {
                Navigator.popAndPushNamed(context, _getRouteForIndex(index));
              },
            ),
        '/profile': (context) => ProfileScreen(
              currentIndex: 3,
              onTap: (index) {
                Navigator.popAndPushNamed(
                  context,
                  _getRouteForIndex(index),
                );
              },
            ),
      },
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _buildHomeScreen(BuildContext context, int index) => HomeScreen(
        currentIndex: index,
        onTap: (index) {
          Navigator.popAndPushNamed(context, _getRouteForIndex(index));
        },
      );

  String _getRouteForIndex(int index) {
    switch (index) {
      case 0:
        return '/home';
      case 1:
        return '/slideshow';
      case 2:
        return '/cart';
      case 3:
        return '/profile';
      default:
        return '/home';
    }
  }
}
