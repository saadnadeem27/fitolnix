import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/models/nutrition.dart';

class NutritionController extends GetxController {
  // Observable variables
  final isLoading = false.obs;
  final currentDate = DateTime.now().obs;
  final dailyNutrition = Rx<DailyNutrition?>(null);
  final foodDatabase = <Food>[].obs;
  final mealSuggestions = <MealSuggestion>[].obs;
  final searchQuery = ''.obs;
  final selectedMealType = 'breakfast'.obs;
  final selectedFood = Rx<Food?>(null);
  final foodQuantity = 1.0.obs;

  // Water tracking
  final waterGoal = 2000.0.obs; // ml
  final quickWaterAmounts = [250.0, 500.0, 750.0, 1000.0].obs;

  // Search and filters
  final searchController = TextEditingController();
  final filteredFoods = <Food>[].obs;
  final selectedCategory = 'All'.obs;
  final foodCategories = [
    'All',
    'Fruits',
    'Vegetables',
    'Proteins',
    'Grains',
    'Dairy',
    'Snacks',
    'Beverages'
  ].obs;

  @override
  void onInit() {
    super.onInit();
    loadNutritionData();
    loadFoodDatabase();
    loadMealSuggestions();

    // Listen to search changes
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      filterFoods();
    });

    // Listen to category changes
    ever(selectedCategory, (_) => filterFoods());
    ever(searchQuery, (_) => filterFoods());
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void loadNutritionData() {
    isLoading.value = true;

    // Load today's nutrition data (in real app, this would come from storage/API)
    final today = DateTime.now();

    // Mock data for demonstration
    final mockMeals = <FoodEntry>[];
    final mockWaterEntries = <WaterEntry>[
      WaterEntry(
          id: '1',
          amount: 500,
          timestamp: today.subtract(const Duration(hours: 2))),
      WaterEntry(
          id: '2',
          amount: 250,
          timestamp: today.subtract(const Duration(hours: 1))),
    ];

    final totalWater =
        mockWaterEntries.fold(0.0, (sum, entry) => sum + entry.amount);

    dailyNutrition.value = DailyNutrition(
      date: today,
      totalCalories:
          mockMeals.fold(0.0, (sum, meal) => sum + meal.totalCalories),
      totalProtein: mockMeals.fold(0.0, (sum, meal) => sum + meal.totalProtein),
      totalCarbs: mockMeals.fold(0.0, (sum, meal) => sum + meal.totalCarbs),
      totalFat: mockMeals.fold(0.0, (sum, meal) => sum + meal.totalFat),
      totalFiber: mockMeals.fold(0.0, (sum, meal) => sum + meal.totalFiber),
      totalWater: totalWater,
      meals: mockMeals,
      waterEntries: mockWaterEntries,
      calorieGoal: 2000,
      proteinGoal: 150,
      carbsGoal: 250,
      fatGoal: 65,
      waterGoal: waterGoal.value,
    );

    isLoading.value = false;
  }

  void loadFoodDatabase() {
    // Mock food database (in real app, this would be loaded from API/database)
    foodDatabase.value = [
      // Fruits
      Food(
        id: '1',
        name: 'Apple',
        category: 'Fruits',
        caloriesPerServing: 95,
        proteinPerServing: 0.5,
        carbsPerServing: 25,
        fatPerServing: 0.3,
        fiberPerServing: 4.4,
        servingUnit: 'medium apple',
        benefits: [
          'High in fiber',
          'Rich in antioxidants',
          'Supports heart health'
        ],
      ),
      Food(
        id: '2',
        name: 'Banana',
        category: 'Fruits',
        caloriesPerServing: 105,
        proteinPerServing: 1.3,
        carbsPerServing: 27,
        fatPerServing: 0.4,
        fiberPerServing: 3.1,
        servingUnit: 'medium banana',
        benefits: [
          'High in potassium',
          'Quick energy source',
          'Supports muscle function'
        ],
      ),
      Food(
        id: '3',
        name: 'Blueberries',
        category: 'Fruits',
        caloriesPerServing: 84,
        proteinPerServing: 1.1,
        carbsPerServing: 21,
        fatPerServing: 0.5,
        fiberPerServing: 3.6,
        servingUnit: 'cup',
        benefits: [
          'Antioxidant powerhouse',
          'Supports brain health',
          'Anti-inflammatory'
        ],
      ),

      // Vegetables
      Food(
        id: '4',
        name: 'Broccoli',
        category: 'Vegetables',
        caloriesPerServing: 25,
        proteinPerServing: 3,
        carbsPerServing: 5,
        fatPerServing: 0.3,
        fiberPerServing: 2.3,
        servingUnit: 'cup chopped',
        benefits: [
          'High in vitamin C',
          'Rich in fiber',
          'Supports immune system'
        ],
      ),
      Food(
        id: '5',
        name: 'Spinach',
        category: 'Vegetables',
        caloriesPerServing: 7,
        proteinPerServing: 0.9,
        carbsPerServing: 1.1,
        fatPerServing: 0.1,
        fiberPerServing: 0.7,
        servingUnit: 'cup raw',
        benefits: ['High in iron', 'Rich in folate', 'Supports eye health'],
      ),

      // Proteins
      Food(
        id: '6',
        name: 'Chicken Breast',
        category: 'Proteins',
        caloriesPerServing: 165,
        proteinPerServing: 31,
        carbsPerServing: 0,
        fatPerServing: 3.6,
        fiberPerServing: 0,
        servingUnit: '100g cooked',
        benefits: [
          'High quality protein',
          'Low in fat',
          'Supports muscle growth'
        ],
      ),
      Food(
        id: '7',
        name: 'Salmon',
        category: 'Proteins',
        caloriesPerServing: 208,
        proteinPerServing: 22,
        carbsPerServing: 0,
        fatPerServing: 12,
        fiberPerServing: 0,
        servingUnit: '100g cooked',
        benefits: [
          'Rich in omega-3',
          'Heart healthy',
          'Supports brain function'
        ],
      ),
      Food(
        id: '8',
        name: 'Greek Yogurt',
        category: 'Dairy',
        caloriesPerServing: 100,
        proteinPerServing: 17,
        carbsPerServing: 6,
        fatPerServing: 0.4,
        fiberPerServing: 0,
        servingUnit: '170g container',
        benefits: [
          'High in protein',
          'Contains probiotics',
          'Supports digestive health'
        ],
      ),

      // Grains
      Food(
        id: '9',
        name: 'Brown Rice',
        category: 'Grains',
        caloriesPerServing: 111,
        proteinPerServing: 2.6,
        carbsPerServing: 23,
        fatPerServing: 0.9,
        fiberPerServing: 1.8,
        servingUnit: '½ cup cooked',
        benefits: ['Whole grain', 'Sustained energy', 'Rich in B vitamins'],
      ),
      Food(
        id: '10',
        name: 'Quinoa',
        category: 'Grains',
        caloriesPerServing: 111,
        proteinPerServing: 4.1,
        carbsPerServing: 20,
        fatPerServing: 1.8,
        fiberPerServing: 2.5,
        servingUnit: '½ cup cooked',
        benefits: ['Complete protein', 'Gluten-free', 'High in minerals'],
      ),

      // Snacks
      Food(
        id: '11',
        name: 'Almonds',
        category: 'Snacks',
        caloriesPerServing: 161,
        proteinPerServing: 6,
        carbsPerServing: 6,
        fatPerServing: 14,
        fiberPerServing: 3.5,
        servingUnit: '28g (23 almonds)',
        benefits: [
          'Healthy fats',
          'High in vitamin E',
          'Supports heart health'
        ],
      ),
      Food(
        id: '12',
        name: 'Avocado',
        category: 'Fruits',
        caloriesPerServing: 234,
        proteinPerServing: 2.9,
        carbsPerServing: 12,
        fatPerServing: 21,
        fiberPerServing: 10,
        servingUnit: 'medium avocado',
        benefits: [
          'Healthy monounsaturated fats',
          'High in fiber',
          'Rich in potassium'
        ],
      ),
    ];

    filteredFoods.value = foodDatabase;
  }

  void loadMealSuggestions() {
    mealSuggestions.value = [
      MealSuggestion(
        id: '1',
        name: 'Greek Yogurt Berry Bowl',
        category: 'Healthy',
        mealType: 'breakfast',
        ingredients: [
          'Greek yogurt',
          'Mixed berries',
          'Honey',
          'Granola',
          'Chia seeds'
        ],
        instructions:
            'Mix Greek yogurt with honey. Top with berries, granola, and chia seeds.',
        estimatedCalories: 320,
        estimatedProtein: 20,
        estimatedCarbs: 45,
        estimatedFat: 8,
        prepTimeMinutes: 5,
        difficulty: 'Easy',
        tags: ['High Protein', 'Quick', 'Healthy'],
      ),
      MealSuggestion(
        id: '2',
        name: 'Grilled Chicken Salad',
        category: 'Healthy',
        mealType: 'lunch',
        ingredients: [
          'Chicken breast',
          'Mixed greens',
          'Cherry tomatoes',
          'Cucumber',
          'Olive oil',
          'Lemon'
        ],
        instructions:
            'Grill chicken breast. Combine with fresh vegetables and dress with olive oil and lemon.',
        estimatedCalories: 280,
        estimatedProtein: 35,
        estimatedCarbs: 8,
        estimatedFat: 12,
        prepTimeMinutes: 15,
        difficulty: 'Medium',
        tags: ['Low Carb', 'High Protein', 'Fresh'],
      ),
      MealSuggestion(
        id: '3',
        name: 'Quinoa Buddha Bowl',
        category: 'Vegetarian',
        mealType: 'dinner',
        ingredients: [
          'Quinoa',
          'Roasted vegetables',
          'Chickpeas',
          'Avocado',
          'Tahini',
          'Lemon'
        ],
        instructions:
            'Cook quinoa. Roast vegetables and chickpeas. Assemble bowl with tahini dressing.',
        estimatedCalories: 420,
        estimatedProtein: 16,
        estimatedCarbs: 55,
        estimatedFat: 18,
        prepTimeMinutes: 30,
        difficulty: 'Medium',
        tags: ['Vegetarian', 'Complete Meal', 'Nutrient Dense'],
      ),
      MealSuggestion(
        id: '4',
        name: 'Protein Smoothie',
        category: 'Healthy',
        mealType: 'snack',
        ingredients: [
          'Protein powder',
          'Banana',
          'Spinach',
          'Almond milk',
          'Peanut butter'
        ],
        instructions: 'Blend all ingredients until smooth. Add ice if desired.',
        estimatedCalories: 285,
        estimatedProtein: 25,
        estimatedCarbs: 25,
        estimatedFat: 9,
        prepTimeMinutes: 3,
        difficulty: 'Easy',
        tags: ['Post-Workout', 'High Protein', 'Quick'],
      ),
    ];
  }

  void filterFoods() {
    var filtered = foodDatabase.toList();

    // Filter by category
    if (selectedCategory.value != 'All') {
      filtered = filtered
          .where((food) => food.category == selectedCategory.value)
          .toList();
    }

    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      filtered = filtered.where((food) {
        return food.name
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            food.category
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            food.benefits.any((benefit) => benefit
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()));
      }).toList();
    }

    filteredFoods.value = filtered;
  }

  void selectFood(Food food) {
    selectedFood.value = food;
    foodQuantity.value = 1.0;
  }

  void updateFoodQuantity(double quantity) {
    foodQuantity.value = quantity;
  }

  void addFoodEntry() {
    if (selectedFood.value == null) return;

    final food = selectedFood.value!;
    final quantity = foodQuantity.value;

    final entry = FoodEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      foodId: food.id,
      foodName: food.name,
      quantity: quantity,
      servingUnit: food.servingUnit,
      totalCalories: food.caloriesPerServing * quantity,
      totalProtein: food.proteinPerServing * quantity,
      totalCarbs: food.carbsPerServing * quantity,
      totalFat: food.fatPerServing * quantity,
      totalFiber: food.fiberPerServing * quantity,
      timestamp: DateTime.now(),
      mealType: selectedMealType.value,
    );

    // Update daily nutrition
    final current = dailyNutrition.value!;
    final updatedMeals = [...current.meals, entry];

    dailyNutrition.value = DailyNutrition(
      date: current.date,
      totalCalories: current.totalCalories + entry.totalCalories,
      totalProtein: current.totalProtein + entry.totalProtein,
      totalCarbs: current.totalCarbs + entry.totalCarbs,
      totalFat: current.totalFat + entry.totalFat,
      totalFiber: current.totalFiber + entry.totalFiber,
      totalWater: current.totalWater,
      meals: updatedMeals,
      waterEntries: current.waterEntries,
      calorieGoal: current.calorieGoal,
      proteinGoal: current.proteinGoal,
      carbsGoal: current.carbsGoal,
      fatGoal: current.fatGoal,
      waterGoal: current.waterGoal,
    );

    // Clear selection
    selectedFood.value = null;
    foodQuantity.value = 1.0;

    Get.back(); // Close add food dialog
    Get.snackbar(
      'Food Added! 🍎',
      '${entry.foodName} has been added to ${selectedMealType.value}',
      backgroundColor: const Color(0xFF06D6A0),
      colorText: const Color(0xFFFFFFFF),
      snackPosition: SnackPosition.TOP,
    );
  }

  void removeFoodEntry(String entryId) {
    final current = dailyNutrition.value!;
    final entryToRemove =
        current.meals.firstWhere((meal) => meal.id == entryId);
    final updatedMeals =
        current.meals.where((meal) => meal.id != entryId).toList();

    dailyNutrition.value = DailyNutrition(
      date: current.date,
      totalCalories: current.totalCalories - entryToRemove.totalCalories,
      totalProtein: current.totalProtein - entryToRemove.totalProtein,
      totalCarbs: current.totalCarbs - entryToRemove.totalCarbs,
      totalFat: current.totalFat - entryToRemove.totalFat,
      totalFiber: current.totalFiber - entryToRemove.totalFiber,
      totalWater: current.totalWater,
      meals: updatedMeals,
      waterEntries: current.waterEntries,
      calorieGoal: current.calorieGoal,
      proteinGoal: current.proteinGoal,
      carbsGoal: current.carbsGoal,
      fatGoal: current.fatGoal,
      waterGoal: current.waterGoal,
    );
  }

  void addWaterEntry(double amount) {
    final entry = WaterEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: amount,
      timestamp: DateTime.now(),
    );

    final current = dailyNutrition.value!;
    final updatedWaterEntries = [...current.waterEntries, entry];

    dailyNutrition.value = DailyNutrition(
      date: current.date,
      totalCalories: current.totalCalories,
      totalProtein: current.totalProtein,
      totalCarbs: current.totalCarbs,
      totalFat: current.totalFat,
      totalFiber: current.totalFiber,
      totalWater: current.totalWater + amount,
      meals: current.meals,
      waterEntries: updatedWaterEntries,
      calorieGoal: current.calorieGoal,
      proteinGoal: current.proteinGoal,
      carbsGoal: current.carbsGoal,
      fatGoal: current.fatGoal,
      waterGoal: current.waterGoal,
    );

    Get.snackbar(
      'Water Added! 💧',
      '${amount.toInt()}ml of water logged',
      backgroundColor: const Color(0xFF00BCD4),
      colorText: const Color(0xFFFFFFFF),
      snackPosition: SnackPosition.TOP,
    );
  }

  void setMealType(String mealType) {
    selectedMealType.value = mealType;
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  // Get meal suggestions by type
  List<MealSuggestion> getMealSuggestionsByType(String mealType) {
    return mealSuggestions
        .where((suggestion) => suggestion.mealType == mealType)
        .toList();
  }

  // Get nutrition summary
  Map<String, dynamic> getNutritionSummary() {
    final nutrition = dailyNutrition.value;
    if (nutrition == null) return {};

    return {
      'caloriesProgress': nutrition.calorieProgress,
      'proteinProgress': nutrition.proteinProgress,
      'carbsProgress': nutrition.carbsProgress,
      'fatProgress': nutrition.fatProgress,
      'waterProgress': nutrition.waterProgress,
      'remainingCalories': nutrition.remainingCalories,
      'totalMeals': nutrition.meals.length,
      'waterIntake': nutrition.totalWater,
    };
  }

  // Get macronutrient breakdown
  List<Map<String, dynamic>> getMacroBreakdown() {
    final nutrition = dailyNutrition.value;
    if (nutrition == null) return [];

    final totalMacros =
        nutrition.totalProtein + nutrition.totalCarbs + nutrition.totalFat;
    if (totalMacros == 0) return [];

    return [
      {
        'name': 'Protein',
        'value': nutrition.totalProtein,
        'percentage': (nutrition.totalProtein / totalMacros * 100).round(),
        'color': const Color(0xFF6366F1),
      },
      {
        'name': 'Carbs',
        'value': nutrition.totalCarbs,
        'percentage': (nutrition.totalCarbs / totalMacros * 100).round(),
        'color': const Color(0xFF06D6A0),
      },
      {
        'name': 'Fat',
        'value': nutrition.totalFat,
        'percentage': (nutrition.totalFat / totalMacros * 100).round(),
        'color': const Color(0xFFFFBE0B),
      },
    ];
  }

  void refreshData() {
    loadNutritionData();
  }
}
