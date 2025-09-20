import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/services/storage_service.dart';
import '../../../data/models/user.dart';
import '../../../utils/constants.dart';
import 'dart:math';

class HomeController extends GetxController {
  // Observable variables
  final user = Rxn<User>();
  final currentStreak = 0.obs;
  final dailyCalories = 0.obs;
  final activeMinutes = 0.obs;
  final waterIntake = 0.obs;
  final dailyGoal = 30.obs; // minutes
  final waterGoal = 8.obs; // glasses
  final motivationalQuote = ''.obs;
  final greeting = ''.obs;
  final todayWorkouts = <Map<String, dynamic>>[].obs;
  final quickStats = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    updateGreeting();
    loadDailyData();
    setMotivationalQuote();
    loadTodayWorkouts();
    loadQuickStats();
  }

  void loadUserData() {
    final userData = StorageService.userData;
    if (userData != null) {
      user.value = User.fromJson(userData);
    }
  }

  void updateGreeting() {
    final hour = DateTime.now().hour;
    final name = user.value?.name.split(' ').first ?? 'Fitness Enthusiast';

    if (hour < 12) {
      greeting.value = 'Good Morning, $name 🌅';
    } else if (hour < 17) {
      greeting.value = 'Good Afternoon, $name ☀️';
    } else {
      greeting.value = 'Good Evening, $name 🌙';
    }
  }

  void loadDailyData() {
    // Load from storage or generate mock data
    currentStreak.value = StorageService.currentStreak;
    waterIntake.value = StorageService.waterIntake;
    dailyGoal.value = StorageService.dailyGoal;

    // Mock data for calories and active minutes
    activeMinutes.value = Random().nextInt(45);
    dailyCalories.value = Random().nextInt(400) + 100;
  }

  void setMotivationalQuote() {
    final quotes = AppConstants.motivationalQuotes;
    final randomIndex = Random().nextInt(quotes.length);
    motivationalQuote.value = quotes[randomIndex];
  }

  void loadTodayWorkouts() {
    // Mock workout data
    todayWorkouts.value = [
      {
        'id': '1',
        'title': 'Morning Yoga',
        'duration': '20 min',
        'type': 'Yoga',
        'completed': false,
        'icon': '🧘‍♀️',
        'gradient': ['0xFF6366F1', '0xFF4F46E5'],
      },
      {
        'id': '2',
        'title': 'HIIT Cardio',
        'duration': '15 min',
        'type': 'Cardio',
        'completed': false,
        'icon': '🔥',
        'gradient': ['0xFFFF6B6B', '0xFFFF8E8E'],
      },
      {
        'id': '3',
        'title': 'Strength Training',
        'duration': '30 min',
        'type': 'Strength',
        'completed': true,
        'icon': '💪',
        'gradient': ['0xFF06D6A0', '0xFF05A082'],
      },
    ];
  }

  void loadQuickStats() {
    quickStats.value = [
      {
        'title': 'Calories Burned',
        'value': '${dailyCalories.value}',
        'unit': 'kcal',
        'icon': '🔥',
        'progress': (dailyCalories.value / 500).clamp(0.0, 1.0),
        'gradient': ['0xFFFF6B6B', '0xFFFF8E8E'],
      },
      {
        'title': 'Active Minutes',
        'value': '${activeMinutes.value}',
        'unit': 'min',
        'icon': '⏱️',
        'progress': (activeMinutes.value / dailyGoal.value).clamp(0.0, 1.0),
        'gradient': ['0xFF6366F1', '0xFF4F46E5'],
      },
      {
        'title': 'Water Intake',
        'value': '${waterIntake.value}',
        'unit': 'glasses',
        'icon': '💧',
        'progress': (waterIntake.value / waterGoal.value).clamp(0.0, 1.0),
        'gradient': ['0xFF06D6A0', '0xFF05A082'],
      },
      {
        'title': 'Current Streak',
        'value': '${currentStreak.value}',
        'unit': 'days',
        'icon': '🔥',
        'progress': (currentStreak.value / 30).clamp(0.0, 1.0),
        'gradient': ['0xFFFFBE0B', '0xFFF59E0B'],
      },
    ];
  }

  void completeWorkout(String workoutId) {
    final index = todayWorkouts.indexWhere((w) => w['id'] == workoutId);
    if (index != -1) {
      todayWorkouts[index]['completed'] = true;
      todayWorkouts.refresh();

      // Update stats
      activeMinutes.value += 15;
      dailyCalories.value += 50;

      // Update streak if this is the first workout today
      if (todayWorkouts.where((w) => w['completed'] == true).length == 1) {
        currentStreak.value++;
        StorageService.currentStreak = currentStreak.value;
      }

      loadQuickStats();

      Get.snackbar(
        'Great Job! 🎉',
        'Workout completed successfully',
        backgroundColor: const Color(0xFF06D6A0),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void addWater() {
    if (waterIntake.value < waterGoal.value) {
      waterIntake.value++;
      StorageService.waterIntake = waterIntake.value;
      loadQuickStats();

      if (waterIntake.value == waterGoal.value) {
        Get.snackbar(
          'Hydration Goal Achieved! 💧',
          'You\'ve reached your daily water goal',
          backgroundColor: const Color(0xFF06D6A0),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }

  void refreshData() {
    loadDailyData();
    setMotivationalQuote();
    loadTodayWorkouts();
    loadQuickStats();
  }

  // Quick actions
  void startQuickWorkout() {
    Get.toNamed('/workout-list');
  }

  void trackNutrition() {
    Get.toNamed('/nutrition');
  }

  void viewProgress() {
    Get.toNamed('/progress');
  }

  void openProfile() {
    Get.toNamed('/profile');
  }
}
