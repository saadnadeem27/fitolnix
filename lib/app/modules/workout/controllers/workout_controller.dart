import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../../data/models/workout.dart';
import '../../../utils/constants.dart';

class WorkoutController extends GetxController {
  // Observable variables
  final workouts = <Workout>[].obs;
  final filteredWorkouts = <Workout>[].obs;
  final selectedCategory = 'All'.obs;
  final selectedDifficulty = 'All'.obs;
  final searchQuery = ''.obs;
  final isLoading = false.obs;
  final favoriteWorkouts = <String>[].obs;

  // Timer variables
  final isTimerRunning = false.obs;
  final currentExerciseIndex = 0.obs;
  final timerSeconds = 0.obs;
  final currentWorkout = Rxn<Workout>();
  final workoutStartTime = Rxn<DateTime>();

  // Controllers
  final searchController = TextEditingController();

  final categories = ['All', ...AppConstants.workoutCategories].obs;
  final difficulties = ['All', ...AppConstants.difficultyLevels].obs;

  @override
  void onInit() {
    super.onInit();
    loadWorkouts();
    loadFavorites();
  }

  @override
  void onClose() {
    _timer?.cancel();
    searchController.dispose();
    super.onClose();
  }

  void loadWorkouts() {
    isLoading.value = true;

    // Mock workout data - in real app, this would come from API/Database
    final mockWorkouts = [
      Workout(
        id: '1',
        title: 'Morning Yoga Flow',
        description:
            'Start your day with energizing yoga poses to wake up your body and mind.',
        category: 'Yoga',
        difficulty: 'Beginner',
        duration: 20,
        caloriesBurned: 80,
        imageUrl: null,
        exercises: [
          Exercise(
            id: '1-1',
            name: 'Mountain Pose',
            description: 'Stand tall with feet together, arms at sides',
            sets: 1,
            reps: 1,
            duration: 60,
            instructions:
                'Stand with feet together, engage core, reach arms overhead',
          ),
          Exercise(
            id: '1-2',
            name: 'Downward Dog',
            description: 'Inverted V-shape pose',
            sets: 1,
            reps: 1,
            duration: 90,
            instructions: 'Start on hands and knees, lift hips up and back',
          ),
          Exercise(
            id: '1-3',
            name: 'Warrior I',
            description: 'Standing lunge with arms overhead',
            sets: 2,
            reps: 1,
            duration: 60,
            instructions: 'Step one foot back, bend front knee, arms up',
          ),
        ],
      ),
      Workout(
        id: '2',
        title: 'HIIT Fat Burner',
        description:
            'High-intensity interval training to torch calories and boost metabolism.',
        category: 'HIIT',
        difficulty: 'Intermediate',
        duration: 25,
        caloriesBurned: 300,
        exercises: [
          Exercise(
            id: '2-1',
            name: 'Burpees',
            description: 'Full body explosive movement',
            sets: 4,
            reps: 15,
            instructions:
                'Squat down, jump back to plank, do push-up, jump forward, jump up',
          ),
          Exercise(
            id: '2-2',
            name: 'Mountain Climbers',
            description: 'High-intensity cardio movement',
            sets: 4,
            reps: 30,
            instructions:
                'Start in plank, alternate bringing knees to chest rapidly',
          ),
          Exercise(
            id: '2-3',
            name: 'Jump Squats',
            description: 'Explosive lower body movement',
            sets: 4,
            reps: 20,
            instructions: 'Squat down, then jump up explosively, land softly',
          ),
        ],
      ),
      Workout(
        id: '3',
        title: 'Upper Body Strength',
        description:
            'Build strong shoulders, chest, and arms with this targeted routine.',
        category: 'Strength',
        difficulty: 'Advanced',
        duration: 45,
        caloriesBurned: 250,
        exercises: [
          Exercise(
            id: '3-1',
            name: 'Push-ups',
            description: 'Classic chest and arm exercise',
            sets: 4,
            reps: 15,
            instructions: 'Start in plank, lower chest to ground, push back up',
          ),
          Exercise(
            id: '3-2',
            name: 'Pike Push-ups',
            description: 'Shoulder-focused variation',
            sets: 3,
            reps: 12,
            instructions:
                'Start in downward dog position, lower head to ground',
          ),
          Exercise(
            id: '3-3',
            name: 'Tricep Dips',
            description: 'Target the back of your arms',
            sets: 3,
            reps: 15,
            instructions: 'Sit on edge of chair, lower body down using arms',
          ),
        ],
      ),
      Workout(
        id: '4',
        title: 'Cardio Dance Party',
        description:
            'Fun and energetic dance workout to get your heart pumping.',
        category: 'Cardio',
        difficulty: 'Beginner',
        duration: 30,
        caloriesBurned: 200,
        exercises: [
          Exercise(
            id: '4-1',
            name: 'Side Steps',
            description: 'Basic side-to-side movement',
            sets: 1,
            reps: 1,
            duration: 120,
            instructions: 'Step side to side with arm movements',
          ),
          Exercise(
            id: '4-2',
            name: 'Grapevines',
            description: 'Cross-step dance move',
            sets: 1,
            reps: 1,
            duration: 180,
            instructions: 'Step to side, cross behind, step side, tap',
          ),
        ],
      ),
      Workout(
        id: '5',
        title: 'Full Body Mobility',
        description:
            'Improve flexibility and range of motion with gentle stretches.',
        category: 'Mobility',
        difficulty: 'Beginner',
        duration: 15,
        caloriesBurned: 50,
        exercises: [
          Exercise(
            id: '5-1',
            name: 'Cat-Cow Stretch',
            description: 'Spinal mobility exercise',
            sets: 1,
            reps: 10,
            instructions: 'On hands and knees, arch and round your back',
          ),
          Exercise(
            id: '5-2',
            name: 'Hip Circles',
            description: 'Hip mobility exercise',
            sets: 2,
            reps: 10,
            instructions: 'Stand and make large circles with your hips',
          ),
        ],
      ),
    ];

    workouts.value = mockWorkouts;
    filteredWorkouts.value = mockWorkouts;
    isLoading.value = false;
  }

  void loadFavorites() {
    // In real app, load from storage
    favoriteWorkouts.value = ['1', '3']; // Mock favorites
  }

  void filterWorkouts() {
    var filtered = workouts.where((workout) {
      final categoryMatch = selectedCategory.value == 'All' ||
          workout.category == selectedCategory.value;
      final difficultyMatch = selectedDifficulty.value == 'All' ||
          workout.difficulty == selectedDifficulty.value;
      final searchMatch = searchQuery.value.isEmpty ||
          workout.title
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()) ||
          workout.description
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());

      return categoryMatch && difficultyMatch && searchMatch;
    }).toList();

    filteredWorkouts.value = filtered;
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    filterWorkouts();
  }

  void setDifficulty(String difficulty) {
    selectedDifficulty.value = difficulty;
    filterWorkouts();
  }

  void searchWorkouts(String query) {
    searchQuery.value = query;
    filterWorkouts();
  }

  void toggleFavorite(String workoutId) {
    if (favoriteWorkouts.contains(workoutId)) {
      favoriteWorkouts.remove(workoutId);
      Get.snackbar(
        'Removed from Favorites',
        'Workout removed from your favorites',
        backgroundColor: const Color(0xFFFF6B6B),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      favoriteWorkouts.add(workoutId);
      Get.snackbar(
        'Added to Favorites ❤️',
        'Workout added to your favorites',
        backgroundColor: const Color(0xFF06D6A0),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void startWorkout(Workout workout) {
    currentWorkout.value = workout;
    currentExerciseIndex.value = 0;
    workoutStartTime.value = DateTime.now();
    Get.toNamed('/workout-timer', arguments: workout);
  }

  void startTimer(int seconds) {
    timerSeconds.value = seconds;
    isTimerRunning.value = true;

    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        timer.cancel();
        isTimerRunning.value = false;
        _onTimerComplete();
      }
    });
  }

  Timer? _timer;

  void _onTimerComplete() {
    // Move to next exercise or complete workout
    if (currentExerciseIndex.value <
        currentWorkout.value!.exercises.length - 1) {
      currentExerciseIndex.value++;
      Get.snackbar(
        'Exercise Complete! 🎉',
        'Moving to next exercise',
        backgroundColor: const Color(0xFF06D6A0),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      _completeWorkout();
    }
  }

  void pauseTimer() {
    isTimerRunning.value = false;
  }

  void resumeTimer() {
    if (timerSeconds.value > 0) {
      isTimerRunning.value = true;
      startTimer(timerSeconds.value);
    }
  }

  void skipExercise() {
    if (currentExerciseIndex.value <
        currentWorkout.value!.exercises.length - 1) {
      currentExerciseIndex.value++;
      isTimerRunning.value = false;
    } else {
      _completeWorkout();
    }
  }

  void _completeWorkout() {
    isTimerRunning.value = false;
    final duration = DateTime.now().difference(workoutStartTime.value!);

    Get.back(); // Return to workout detail or list
    Get.snackbar(
      'Workout Complete! 🎉🏆',
      'Great job! You completed the workout in ${duration.inMinutes} minutes',
      backgroundColor: const Color(0xFF06D6A0),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 4),
    );

    // Update user stats here
    currentWorkout.value = null;
    currentExerciseIndex.value = 0;
  }

  void exitWorkout() {
    isTimerRunning.value = false;
    currentWorkout.value = null;
    currentExerciseIndex.value = 0;
    Get.back();
  }

  List<Workout> getFavoriteWorkouts() {
    return workouts.where((w) => favoriteWorkouts.contains(w.id)).toList();
  }

  Color getCategoryColor(String category) {
    switch (category) {
      case 'Strength':
        return const Color(0xFF6366F1);
      case 'Cardio':
        return const Color(0xFFFF6B6B);
      case 'Yoga':
        return const Color(0xFF06D6A0);
      case 'HIIT':
        return const Color(0xFFFFBE0B);
      case 'Mobility':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData getCategoryIcon(String category) {
    switch (category) {
      case 'Strength':
        return Icons.fitness_center;
      case 'Cardio':
        return Icons.favorite;
      case 'Yoga':
        return Icons.self_improvement;
      case 'HIIT':
        return Icons.flash_on;
      case 'Mobility':
        return Icons.accessibility_new;
      default:
        return Icons.sports_gymnastics;
    }
  }
}
