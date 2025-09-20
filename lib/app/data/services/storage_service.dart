import 'package:get_storage/get_storage.dart';
import '../../utils/constants.dart';

class StorageService {
  static final _box = GetStorage();
  
  // First time app launch
  static bool get isFirstTime => _box.read(AppConstants.isFirstTime) ?? true;
  static set isFirstTime(bool value) => _box.write(AppConstants.isFirstTime, value);
  
  // Onboarding completion
  static bool get onboardingCompleted => _box.read(AppConstants.onboardingCompleted) ?? false;
  static set onboardingCompleted(bool value) => _box.write(AppConstants.onboardingCompleted, value);
  
  // User authentication
  static String? get userToken => _box.read(AppConstants.userToken);
  static set userToken(String? value) => _box.write(AppConstants.userToken, value);
  
  // User data
  static Map<String, dynamic>? get userData => _box.read(AppConstants.userData);
  static set userData(Map<String, dynamic>? value) => _box.write(AppConstants.userData, value);
  
  // Theme
  static bool get isDarkMode => _box.read(AppConstants.darkMode) ?? true;
  static set isDarkMode(bool value) => _box.write(AppConstants.darkMode, value);
  
  // Fitness data
  static int get dailyGoal => _box.read(AppConstants.dailyGoal) ?? 30; // minutes
  static set dailyGoal(int value) => _box.write(AppConstants.dailyGoal, value);
  
  static int get waterIntake => _box.read(AppConstants.waterIntake) ?? 0; // glasses
  static set waterIntake(int value) => _box.write(AppConstants.waterIntake, value);
  
  static int get currentStreak => _box.read(AppConstants.currentStreak) ?? 0;
  static set currentStreak(int value) => _box.write(AppConstants.currentStreak, value);
  
  // Clear all data
  static void clearAll() => _box.erase();
  
  // Initialize storage
  static Future<void> init() async {
    await GetStorage.init();
  }
}