import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://your-project.supabase.co',
  );
  
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'your-anon-key-here',
  );

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      debug: true, // Set to false in production
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
  
  static GoTrueClient get auth => client.auth;
  
  static SupabaseQueryBuilder get users => client.from('users');
  static SupabaseQueryBuilder get workouts => client.from('workouts');
  static SupabaseQueryBuilder get exercises => client.from('exercises');
  static SupabaseQueryBuilder get userWorkouts => client.from('user_workouts');
  static SupabaseQueryBuilder get progress => client.from('progress');
  static SupabaseQueryBuilder get nutrition => client.from('nutrition');
  static SupabaseQueryBuilder get meals => client.from('meals');
}