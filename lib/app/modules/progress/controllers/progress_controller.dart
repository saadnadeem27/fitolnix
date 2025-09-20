import 'package:get/get.dart';
import '../../../data/models/progress.dart';

class ProgressController extends GetxController {
  // Observable variables
  final weeklyProgress = <DayProgress>[].obs;
  final monthlyStats = Rx<MonthlyStats?>(null);
  final achievements = <Achievement>[].obs;
  final currentWeekData = <double>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProgressData();
  }

  void loadProgressData() {
    isLoading.value = true;

    // Load weekly progress data
    _loadWeeklyProgress();

    // Load monthly stats
    _loadMonthlyStats();

    // Load achievements
    _loadAchievements();

    isLoading.value = false;
  }

  void _loadWeeklyProgress() {
    final now = DateTime.now();
    final weekData = <DayProgress>[];

    // Generate data for the current week
    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dayName = _getDayName(date.weekday);

      // Mock data - in real app, this would come from storage/API
      final workoutsCompleted = (date.day * 0.3).round().clamp(0, 3);
      final caloriesBurned = workoutsCompleted * 250 + (date.day * 15);
      final minutesActive = workoutsCompleted * 45 + (date.day * 10);

      weekData.add(DayProgress(
        day: dayName,
        date: date,
        workoutsCompleted: workoutsCompleted,
        caloriesBurned: caloriesBurned,
        minutesActive: minutesActive,
        goalAchieved: workoutsCompleted >= 1,
      ));
    }

    weeklyProgress.value = weekData;
    currentWeekData.value =
        weekData.map((d) => d.workoutsCompleted.toDouble()).toList();
  }

  void _loadMonthlyStats() {
    final now = DateTime.now();

    // Mock monthly data
    monthlyStats.value = MonthlyStats(
      month: _getMonthName(now.month),
      year: now.year,
      totalWorkouts: 18,
      totalCaloriesBurned: 4250,
      totalMinutesActive: 890,
      averageWorkoutsPerWeek: 4.5,
      streakDays: 7,
      goalCompletionRate: 0.85,
    );
  }

  void _loadAchievements() {
    achievements.value = [
      Achievement(
        id: '1',
        title: 'First Week Warrior',
        description: 'Complete 7 workouts in a week',
        iconPath: 'assets/achievements/week_warrior.json',
        isUnlocked: true,
        unlockedDate: DateTime.now().subtract(const Duration(days: 3)),
        category: 'Consistency',
      ),
      Achievement(
        id: '2',
        title: 'Calorie Crusher',
        description: 'Burn 1000 calories in a single workout',
        iconPath: 'assets/achievements/calorie_crusher.json',
        isUnlocked: true,
        unlockedDate: DateTime.now().subtract(const Duration(days: 10)),
        category: 'Intensity',
      ),
      Achievement(
        id: '3',
        title: 'Strength Seeker',
        description: 'Complete 10 strength training workouts',
        iconPath: 'assets/achievements/strength_seeker.json',
        isUnlocked: false,
        category: 'Training',
        progress: 7,
        target: 10,
      ),
      Achievement(
        id: '4',
        title: 'Cardio King',
        description: 'Complete 5 cardio workouts in a row',
        iconPath: 'assets/achievements/cardio_king.json',
        isUnlocked: false,
        category: 'Training',
        progress: 3,
        target: 5,
      ),
      Achievement(
        id: '5',
        title: 'Yoga Master',
        description: 'Practice yoga for 30 days straight',
        iconPath: 'assets/achievements/yoga_master.json',
        isUnlocked: false,
        category: 'Mindfulness',
        progress: 12,
        target: 30,
      ),
      Achievement(
        id: '6',
        title: 'Early Bird',
        description: 'Complete 10 morning workouts',
        iconPath: 'assets/achievements/early_bird.json',
        isUnlocked: false,
        category: 'Schedule',
        progress: 4,
        target: 10,
      ),
    ];
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  // Get achievements by category
  List<Achievement> getAchievementsByCategory(String category) {
    return achievements.where((a) => a.category == category).toList();
  }

  // Get unlocked achievements
  List<Achievement> getUnlockedAchievements() {
    return achievements.where((a) => a.isUnlocked).toList();
  }

  // Get achievements in progress
  List<Achievement> getAchievementsInProgress() {
    return achievements
        .where((a) => !a.isUnlocked && a.progress != null)
        .toList();
  }

  // Get all achievement categories
  List<String> getAchievementCategories() {
    return achievements.map((a) => a.category).toSet().toList();
  }

  // Calculate overall progress percentage
  double getOverallProgress() {
    if (achievements.isEmpty) return 0.0;

    final unlockedCount = achievements.where((a) => a.isUnlocked).length;
    return unlockedCount / achievements.length;
  }

  // Get weekly completion rate
  double getWeeklyCompletionRate() {
    if (weeklyProgress.isEmpty) return 0.0;

    final completedDays = weeklyProgress.where((d) => d.goalAchieved).length;
    return completedDays / weeklyProgress.length;
  }

  // Get current streak
  int getCurrentStreak() {
    return monthlyStats.value?.streakDays ?? 0;
  }

  // Get total workouts this month
  int getTotalWorkoutsThisMonth() {
    return monthlyStats.value?.totalWorkouts ?? 0;
  }

  // Get total calories burned this month
  int getTotalCaloriesThisMonth() {
    return monthlyStats.value?.totalCaloriesBurned ?? 0;
  }

  // Refresh data
  void refreshData() {
    loadProgressData();
  }
}
