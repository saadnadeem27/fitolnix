// App constants
class AppConstants {
  static const String appName = 'Fitolnix';
  static const String appVersion = '1.0.0';
  
  // Storage keys
  static const String isFirstTime = 'is_first_time';
  static const String onboardingCompleted = 'onboarding_completed';
  static const String userToken = 'user_token';
  static const String userData = 'user_data';
  static const String darkMode = 'dark_mode';
  static const String dailyGoal = 'daily_goal';
  static const String waterIntake = 'water_intake';
  static const String currentStreak = 'current_streak';
  
  // Fitness goals
  static const List<String> fitnessGoals = [
    'Lose Weight',
    'Gain Muscle',
    'Stay Fit',
    'Improve Endurance',
  ];
  
  // Workout categories
  static const List<String> workoutCategories = [
    'Strength',
    'Cardio',
    'Yoga',
    'HIIT',
    'Mobility',
  ];
  
  // Difficulty levels
  static const List<String> difficultyLevels = [
    'Beginner',
    'Intermediate',
    'Advanced',
  ];
  
  // Motivational quotes
  static const List<String> motivationalQuotes = [
    "The only bad workout is the one that didn't happen.",
    "Your body can do it. It's your mind you need to convince.",
    "Success isn't given. It's earned in the gym.",
    "Push yourself because no one else is going to do it for you.",
    "Great things never come from comfort zones.",
    "Train insane or remain the same.",
    "The pain you feel today will be the strength you feel tomorrow.",
    "Champions keep playing until they get it right.",
  ];
  
  // Achievement titles
  static const Map<String, String> achievements = {
    'first_workout': 'First Step 🎯',
    'streak_3': '3 Day Streak 🔥',
    'streak_7': 'Week Warrior 💪',
    'streak_30': 'Monthly Master 👑',
    'calories_500': 'Calorie Crusher 🚀',
    'calories_1000': 'Thousand Burner 💥',
    'workouts_10': 'Perfect Ten ⭐',
    'workouts_50': 'Fitness Fanatic 🏆',
    'workouts_100': 'Century Club 🎉',
  };
}