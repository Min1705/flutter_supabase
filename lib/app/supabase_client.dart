import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientInstance {
  static const String supabaseUrl = 'https://tsqfzxuiakkpulcjqlov.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRzcWZ6eHVpYWtrcHVsY2pxbG92Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIyNDMxNzQsImV4cCI6MjA0NzgxOTE3NH0.E0VsNth-sXZDJD2Nv6UdzngifqcOjEIBqiq2e_3xNus';

  static final SupabaseClient _client =
      SupabaseClient(supabaseUrl, supabaseAnonKey);

  SupabaseClientInstance._privateConstructor();

  static SupabaseClient get client => _client;
}
