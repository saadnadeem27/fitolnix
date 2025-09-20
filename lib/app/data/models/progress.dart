class DayProgress {
  final String day;
  final DateTime date;
  final int workoutsCompleted;
  final int caloriesBurned;
  final int minutesActive;
  final bool goalAchieved;

  DayProgress({
    required this.day,
    required this.date,
    required this.workoutsCompleted,
    required this.caloriesBurned,
    required this.minutesActive,
    required this.goalAchieved,
  });

  factory DayProgress.fromJson(Map<String, dynamic> json) {
    return DayProgress(
      day: json['day'],
      date: DateTime.parse(json['date']),
      workoutsCompleted: json['workoutsCompleted'],
      caloriesBurned: json['caloriesBurned'],
      minutesActive: json['minutesActive'],
      goalAchieved: json['goalAchieved'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'date': date.toIso8601String(),
      'workoutsCompleted': workoutsCompleted,
      'caloriesBurned': caloriesBurned,
      'minutesActive': minutesActive,
      'goalAchieved': goalAchieved,
    };
  }
}

class MonthlyStats {
  final String month;
  final int year;
  final int totalWorkouts;
  final int totalCaloriesBurned;
  final int totalMinutesActive;
  final double averageWorkoutsPerWeek;
  final int streakDays;
  final double goalCompletionRate;

  MonthlyStats({
    required this.month,
    required this.year,
    required this.totalWorkouts,
    required this.totalCaloriesBurned,
    required this.totalMinutesActive,
    required this.averageWorkoutsPerWeek,
    required this.streakDays,
    required this.goalCompletionRate,
  });

  factory MonthlyStats.fromJson(Map<String, dynamic> json) {
    return MonthlyStats(
      month: json['month'],
      year: json['year'],
      totalWorkouts: json['totalWorkouts'],
      totalCaloriesBurned: json['totalCaloriesBurned'],
      totalMinutesActive: json['totalMinutesActive'],
      averageWorkoutsPerWeek: json['averageWorkoutsPerWeek'],
      streakDays: json['streakDays'],
      goalCompletionRate: json['goalCompletionRate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'year': year,
      'totalWorkouts': totalWorkouts,
      'totalCaloriesBurned': totalCaloriesBurned,
      'totalMinutesActive': totalMinutesActive,
      'averageWorkoutsPerWeek': averageWorkoutsPerWeek,
      'streakDays': streakDays,
      'goalCompletionRate': goalCompletionRate,
    };
  }
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconPath;
  final bool isUnlocked;
  final DateTime? unlockedDate;
  final String category;
  final int? progress;
  final int? target;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.isUnlocked,
    this.unlockedDate,
    required this.category,
    this.progress,
    this.target,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      iconPath: json['iconPath'],
      isUnlocked: json['isUnlocked'],
      unlockedDate: json['unlockedDate'] != null
          ? DateTime.parse(json['unlockedDate'])
          : null,
      category: json['category'],
      progress: json['progress'],
      target: json['target'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'iconPath': iconPath,
      'isUnlocked': isUnlocked,
      'unlockedDate': unlockedDate?.toIso8601String(),
      'category': category,
      'progress': progress,
      'target': target,
    };
  }

  double get progressPercentage {
    if (progress == null || target == null || target == 0) return 0.0;
    return (progress! / target!).clamp(0.0, 1.0);
  }

  bool get hasProgress => progress != null && target != null;
}
