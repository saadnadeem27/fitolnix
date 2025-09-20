class Food {
  final String id;
  final String name;
  final String category;
  final double caloriesPerServing;
  final double proteinPerServing;
  final double carbsPerServing;
  final double fatPerServing;
  final double fiberPerServing;
  final String servingUnit;
  final String? imageUrl;
  final List<String> benefits;

  Food({
    required this.id,
    required this.name,
    required this.category,
    required this.caloriesPerServing,
    required this.proteinPerServing,
    required this.carbsPerServing,
    required this.fatPerServing,
    required this.fiberPerServing,
    required this.servingUnit,
    this.imageUrl,
    this.benefits = const [],
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      caloriesPerServing: json['caloriesPerServing'].toDouble(),
      proteinPerServing: json['proteinPerServing'].toDouble(),
      carbsPerServing: json['carbsPerServing'].toDouble(),
      fatPerServing: json['fatPerServing'].toDouble(),
      fiberPerServing: json['fiberPerServing'].toDouble(),
      servingUnit: json['servingUnit'],
      imageUrl: json['imageUrl'],
      benefits: List<String>.from(json['benefits'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'caloriesPerServing': caloriesPerServing,
      'proteinPerServing': proteinPerServing,
      'carbsPerServing': carbsPerServing,
      'fatPerServing': fatPerServing,
      'fiberPerServing': fiberPerServing,
      'servingUnit': servingUnit,
      'imageUrl': imageUrl,
      'benefits': benefits,
    };
  }
}

class FoodEntry {
  final String id;
  final String foodId;
  final String foodName;
  final double quantity;
  final String servingUnit;
  final double totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFat;
  final double totalFiber;
  final DateTime timestamp;
  final String mealType; // breakfast, lunch, dinner, snack

  FoodEntry({
    required this.id,
    required this.foodId,
    required this.foodName,
    required this.quantity,
    required this.servingUnit,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
    required this.totalFiber,
    required this.timestamp,
    required this.mealType,
  });

  factory FoodEntry.fromJson(Map<String, dynamic> json) {
    return FoodEntry(
      id: json['id'],
      foodId: json['foodId'],
      foodName: json['foodName'],
      quantity: json['quantity'].toDouble(),
      servingUnit: json['servingUnit'],
      totalCalories: json['totalCalories'].toDouble(),
      totalProtein: json['totalProtein'].toDouble(),
      totalCarbs: json['totalCarbs'].toDouble(),
      totalFat: json['totalFat'].toDouble(),
      totalFiber: json['totalFiber'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      mealType: json['mealType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'foodId': foodId,
      'foodName': foodName,
      'quantity': quantity,
      'servingUnit': servingUnit,
      'totalCalories': totalCalories,
      'totalProtein': totalProtein,
      'totalCarbs': totalCarbs,
      'totalFat': totalFat,
      'totalFiber': totalFiber,
      'timestamp': timestamp.toIso8601String(),
      'mealType': mealType,
    };
  }
}

class WaterEntry {
  final String id;
  final double amount; // in ml
  final DateTime timestamp;

  WaterEntry({
    required this.id,
    required this.amount,
    required this.timestamp,
  });

  factory WaterEntry.fromJson(Map<String, dynamic> json) {
    return WaterEntry(
      id: json['id'],
      amount: json['amount'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

class DailyNutrition {
  final DateTime date;
  final double totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFat;
  final double totalFiber;
  final double totalWater;
  final List<FoodEntry> meals;
  final List<WaterEntry> waterEntries;
  final double calorieGoal;
  final double proteinGoal;
  final double carbsGoal;
  final double fatGoal;
  final double waterGoal;

  DailyNutrition({
    required this.date,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
    required this.totalFiber,
    required this.totalWater,
    required this.meals,
    required this.waterEntries,
    required this.calorieGoal,
    required this.proteinGoal,
    required this.carbsGoal,
    required this.fatGoal,
    required this.waterGoal,
  });

  factory DailyNutrition.fromJson(Map<String, dynamic> json) {
    return DailyNutrition(
      date: DateTime.parse(json['date']),
      totalCalories: json['totalCalories'].toDouble(),
      totalProtein: json['totalProtein'].toDouble(),
      totalCarbs: json['totalCarbs'].toDouble(),
      totalFat: json['totalFat'].toDouble(),
      totalFiber: json['totalFiber'].toDouble(),
      totalWater: json['totalWater'].toDouble(),
      meals: (json['meals'] as List).map((m) => FoodEntry.fromJson(m)).toList(),
      waterEntries: (json['waterEntries'] as List)
          .map((w) => WaterEntry.fromJson(w))
          .toList(),
      calorieGoal: json['calorieGoal'].toDouble(),
      proteinGoal: json['proteinGoal'].toDouble(),
      carbsGoal: json['carbsGoal'].toDouble(),
      fatGoal: json['fatGoal'].toDouble(),
      waterGoal: json['waterGoal'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'totalCalories': totalCalories,
      'totalProtein': totalProtein,
      'totalCarbs': totalCarbs,
      'totalFat': totalFat,
      'totalFiber': totalFiber,
      'totalWater': totalWater,
      'meals': meals.map((m) => m.toJson()).toList(),
      'waterEntries': waterEntries.map((w) => w.toJson()).toList(),
      'calorieGoal': calorieGoal,
      'proteinGoal': proteinGoal,
      'carbsGoal': carbsGoal,
      'fatGoal': fatGoal,
      'waterGoal': waterGoal,
    };
  }

  // Helper methods
  double get calorieProgress =>
      calorieGoal > 0 ? (totalCalories / calorieGoal).clamp(0.0, 1.0) : 0.0;
  double get proteinProgress =>
      proteinGoal > 0 ? (totalProtein / proteinGoal).clamp(0.0, 1.0) : 0.0;
  double get carbsProgress =>
      carbsGoal > 0 ? (totalCarbs / carbsGoal).clamp(0.0, 1.0) : 0.0;
  double get fatProgress =>
      fatGoal > 0 ? (totalFat / fatGoal).clamp(0.0, 1.0) : 0.0;
  double get waterProgress =>
      waterGoal > 0 ? (totalWater / waterGoal).clamp(0.0, 1.0) : 0.0;

  double get remainingCalories =>
      (calorieGoal - totalCalories).clamp(0.0, double.infinity);
  double get remainingProtein =>
      (proteinGoal - totalProtein).clamp(0.0, double.infinity);
  double get remainingCarbs =>
      (carbsGoal - totalCarbs).clamp(0.0, double.infinity);
  double get remainingFat => (fatGoal - totalFat).clamp(0.0, double.infinity);
  double get remainingWater =>
      (waterGoal - totalWater).clamp(0.0, double.infinity);

  List<FoodEntry> getMealsByType(String mealType) {
    return meals.where((meal) => meal.mealType == mealType).toList();
  }

  double getMealCalories(String mealType) {
    return getMealsByType(mealType)
        .fold(0.0, (sum, meal) => sum + meal.totalCalories);
  }
}

class MealSuggestion {
  final String id;
  final String name;
  final String category;
  final String mealType;
  final List<String> ingredients;
  final String instructions;
  final double estimatedCalories;
  final double estimatedProtein;
  final double estimatedCarbs;
  final double estimatedFat;
  final int prepTimeMinutes;
  final String difficulty;
  final List<String> tags;
  final String? imageUrl;

  MealSuggestion({
    required this.id,
    required this.name,
    required this.category,
    required this.mealType,
    required this.ingredients,
    required this.instructions,
    required this.estimatedCalories,
    required this.estimatedProtein,
    required this.estimatedCarbs,
    required this.estimatedFat,
    required this.prepTimeMinutes,
    required this.difficulty,
    this.tags = const [],
    this.imageUrl,
  });

  factory MealSuggestion.fromJson(Map<String, dynamic> json) {
    return MealSuggestion(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      mealType: json['mealType'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: json['instructions'],
      estimatedCalories: json['estimatedCalories'].toDouble(),
      estimatedProtein: json['estimatedProtein'].toDouble(),
      estimatedCarbs: json['estimatedCarbs'].toDouble(),
      estimatedFat: json['estimatedFat'].toDouble(),
      prepTimeMinutes: json['prepTimeMinutes'],
      difficulty: json['difficulty'],
      tags: List<String>.from(json['tags'] ?? []),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'mealType': mealType,
      'ingredients': ingredients,
      'instructions': instructions,
      'estimatedCalories': estimatedCalories,
      'estimatedProtein': estimatedProtein,
      'estimatedCarbs': estimatedCarbs,
      'estimatedFat': estimatedFat,
      'prepTimeMinutes': prepTimeMinutes,
      'difficulty': difficulty,
      'tags': tags,
      'imageUrl': imageUrl,
    };
  }
}
