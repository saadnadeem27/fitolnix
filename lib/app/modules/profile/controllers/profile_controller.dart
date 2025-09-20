import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final storage = GetStorage();

  // User Info
  RxString userName = 'John Doe'.obs;
  RxString userEmail = 'john.doe@example.com'.obs;
  RxString userPhone = '+1 234 567 8900'.obs;
  RxString userLocation = 'New York, USA'.obs;
  RxString userBio = 'Fitness enthusiast on a journey to better health!'.obs;
  RxString memberSince = 'Member since January 2024'.obs;

  // Stats
  RxInt totalWorkouts = 156.obs;
  RxInt totalHours = 89.obs;
  RxDouble totalCaloriesBurned = 12450.0.obs;
  RxInt streakDays = 23.obs;

  // Settings
  RxBool isDarkMode = true.obs;
  RxBool notificationsEnabled = true.obs;
  RxBool workoutReminders = true.obs;
  RxBool nutritionReminders = true.obs;
  RxBool progressUpdates = true.obs;
  RxBool soundEnabled = true.obs;
  RxBool vibrationEnabled = true.obs;
  RxString selectedLanguage = 'English'.obs;
  RxString selectedUnit = 'Metric'.obs;

  // Premium
  RxBool isPremium = false.obs;
  RxString subscriptionType = 'Free'.obs;
  RxString subscriptionExpiry = ''.obs;

  // Goals
  RxString fitnessGoal = 'Build Muscle'.obs;
  RxInt weeklyGoal = 5.obs;
  RxDouble targetWeight = 75.0.obs;
  RxDouble currentWeight = 68.5.obs;
  RxDouble targetCalories = 2500.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    // Load user data from storage
    userName.value = storage.read('userName') ?? 'John Doe';
    userEmail.value = storage.read('userEmail') ?? 'john.doe@example.com';
    userPhone.value = storage.read('userPhone') ?? '+1 234 567 8900';
    userLocation.value = storage.read('userLocation') ?? 'New York, USA';
    userBio.value = storage.read('userBio') ??
        'Fitness enthusiast on a journey to better health!';

    // Load settings
    isDarkMode.value = storage.read('isDarkMode') ?? true;
    notificationsEnabled.value = storage.read('notificationsEnabled') ?? true;
    workoutReminders.value = storage.read('workoutReminders') ?? true;
    nutritionReminders.value = storage.read('nutritionReminders') ?? true;
    progressUpdates.value = storage.read('progressUpdates') ?? true;
    soundEnabled.value = storage.read('soundEnabled') ?? true;
    vibrationEnabled.value = storage.read('vibrationEnabled') ?? true;
    selectedLanguage.value = storage.read('selectedLanguage') ?? 'English';
    selectedUnit.value = storage.read('selectedUnit') ?? 'Metric';

    // Load premium status
    isPremium.value = storage.read('isPremium') ?? false;
    subscriptionType.value = storage.read('subscriptionType') ?? 'Free';

    // Load goals
    fitnessGoal.value = storage.read('fitnessGoal') ?? 'Build Muscle';
    weeklyGoal.value = storage.read('weeklyGoal') ?? 5;
    targetWeight.value = storage.read('targetWeight') ?? 75.0;
    currentWeight.value = storage.read('currentWeight') ?? 68.5;
    targetCalories.value = storage.read('targetCalories') ?? 2500.0;
  }

  void saveUserData() {
    // Save user data to storage
    storage.write('userName', userName.value);
    storage.write('userEmail', userEmail.value);
    storage.write('userPhone', userPhone.value);
    storage.write('userLocation', userLocation.value);
    storage.write('userBio', userBio.value);

    // Save settings
    storage.write('isDarkMode', isDarkMode.value);
    storage.write('notificationsEnabled', notificationsEnabled.value);
    storage.write('workoutReminders', workoutReminders.value);
    storage.write('nutritionReminders', nutritionReminders.value);
    storage.write('progressUpdates', progressUpdates.value);
    storage.write('soundEnabled', soundEnabled.value);
    storage.write('vibrationEnabled', vibrationEnabled.value);
    storage.write('selectedLanguage', selectedLanguage.value);
    storage.write('selectedUnit', selectedUnit.value);

    // Save goals
    storage.write('fitnessGoal', fitnessGoal.value);
    storage.write('weeklyGoal', weeklyGoal.value);
    storage.write('targetWeight', targetWeight.value);
    storage.write('currentWeight', currentWeight.value);
    storage.write('targetCalories', targetCalories.value);
  }

  void updateUserInfo({
    String? name,
    String? email,
    String? phone,
    String? location,
    String? bio,
  }) {
    if (name != null) userName.value = name;
    if (email != null) userEmail.value = email;
    if (phone != null) userPhone.value = phone;
    if (location != null) userLocation.value = location;
    if (bio != null) userBio.value = bio;
    saveUserData();
  }

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    saveUserData();
  }

  void toggleNotifications() {
    notificationsEnabled.value = !notificationsEnabled.value;
    saveUserData();
  }

  void toggleWorkoutReminders() {
    workoutReminders.value = !workoutReminders.value;
    saveUserData();
  }

  void toggleNutritionReminders() {
    nutritionReminders.value = !nutritionReminders.value;
    saveUserData();
  }

  void toggleProgressUpdates() {
    progressUpdates.value = !progressUpdates.value;
    saveUserData();
  }

  void toggleSound() {
    soundEnabled.value = !soundEnabled.value;
    saveUserData();
  }

  void toggleVibration() {
    vibrationEnabled.value = !vibrationEnabled.value;
    saveUserData();
  }

  void updateLanguage(String language) {
    selectedLanguage.value = language;
    saveUserData();
    Get.updateLocale(Locale(language.toLowerCase()));
  }

  void updateUnit(String unit) {
    selectedUnit.value = unit;
    saveUserData();
  }

  void updateGoals({
    String? goal,
    int? weekly,
    double? weight,
    double? calories,
  }) {
    if (goal != null) fitnessGoal.value = goal;
    if (weekly != null) weeklyGoal.value = weekly;
    if (weight != null) targetWeight.value = weight;
    if (calories != null) targetCalories.value = calories;
    saveUserData();
  }

  void updateCurrentWeight(double weight) {
    currentWeight.value = weight;
    saveUserData();
  }

  double get weightProgress => currentWeight.value / targetWeight.value;

  List<Map<String, dynamic>> get achievements => [
        {
          'title': 'First Workout',
          'description': 'Complete your first workout',
          'achieved': true,
          'icon': Icons.fitness_center,
          'color': const Color(0xFF4CAF50),
        },
        {
          'title': 'Week Warrior',
          'description': 'Complete 7 workouts in a week',
          'achieved': true,
          'icon': Icons.local_fire_department,
          'color': const Color(0xFFFF9800),
        },
        {
          'title': 'Consistency King',
          'description': 'Maintain a 30-day streak',
          'achieved': streakDays.value >= 30,
          'icon': Icons.auto_awesome,
          'color': const Color(0xFF9C27B0),
        },
        {
          'title': 'Century Club',
          'description': 'Complete 100 workouts',
          'achieved': totalWorkouts.value >= 100,
          'icon': Icons.military_tech,
          'color': const Color(0xFF2196F3),
        },
        {
          'title': 'Calorie Crusher',
          'description': 'Burn 10,000 calories',
          'achieved': totalCaloriesBurned.value >= 10000,
          'icon': Icons.whatshot,
          'color': const Color(0xFFF44336),
        },
        {
          'title': 'Goal Getter',
          'description': 'Reach your target weight',
          'achieved': (currentWeight.value - targetWeight.value).abs() <= 1.0,
          'icon': Icons.emoji_events,
          'color': const Color(0xFFFFD700),
        },
      ];

  List<Map<String, dynamic>> get premiumFeatures => [
        {
          'title': 'Advanced Analytics',
          'description': 'Detailed progress insights and trends',
          'icon': Icons.analytics,
        },
        {
          'title': 'Custom Workouts',
          'description': 'Create and share your own workout plans',
          'icon': Icons.fitness_center,
        },
        {
          'title': 'Nutrition AI',
          'description': 'AI-powered meal planning and recommendations',
          'icon': Icons.smart_toy,
        },
        {
          'title': 'Priority Support',
          'description': '24/7 premium customer support',
          'icon': Icons.support_agent,
        },
        {
          'title': 'Export Data',
          'description': 'Export your fitness data in multiple formats',
          'icon': Icons.download,
        },
        {
          'title': 'No Ads',
          'description': 'Enjoy an ad-free experience',
          'icon': Icons.block,
        },
      ];

  void upgradeToPremium() {
    isPremium.value = true;
    subscriptionType.value = 'Premium';
    subscriptionExpiry.value =
        DateTime.now().add(const Duration(days: 365)).toString();
    storage.write('isPremium', true);
    storage.write('subscriptionType', 'Premium');
    storage.write('subscriptionExpiry', subscriptionExpiry.value);

    Get.snackbar(
      'Welcome to Premium!',
      'You now have access to all premium features',
      backgroundColor: const Color(0xFF4CAF50),
      colorText: Colors.white,
      icon: const Icon(Icons.star, color: Colors.white),
    );
  }

  void logout() {
    // Clear user session
    storage.remove('userToken');
    storage.remove('isLoggedIn');

    Get.snackbar(
      'Logged Out',
      'You have been successfully logged out',
      backgroundColor: const Color(0xFF2196F3),
      colorText: Colors.white,
    );

    // Navigate to login
    Get.offAllNamed('/login');
  }

  void deleteAccount() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        title: const Text(
          'Delete Account',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              storage.erase();
              Get.offAllNamed('/login');
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
