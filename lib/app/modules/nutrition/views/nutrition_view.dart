import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../controllers/nutrition_controller.dart';
import '../../../widgets/custom_widgets.dart';
import '../../../utils/theme.dart';
// local helper below to avoid extension name conflicts

String _capitalize(String s) {
  if (s.isEmpty) return s;
  return s[0].toUpperCase() + s.substring(1);
}

class NutritionView extends StatelessWidget {
  final nutritionController = Get.put(NutritionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildAppBar(),
              SliverToBoxAdapter(
                child: Obx(() {
                  if (nutritionController.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    );
                  }

                  return AnimationLimiter(
                    child: Column(
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 375),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(child: widget),
                        ),
                        children: [
                          _buildCaloriesSummary(),
                          _buildWaterTracker(),
                          _buildMacronutrientChart(),
                          _buildMealsSection(),
                          _buildMealSuggestions(),
                          const SizedBox(height: 100), // Bottom padding
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddFoodDialog(),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add Food',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Nutrition',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.primaryGradient,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => nutritionController.refreshData(),
          icon: const Icon(
            Icons.refresh,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildCaloriesSummary() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        final nutrition = nutritionController.dailyNutrition.value;
        if (nutrition == null) return const SizedBox();

        return GlassCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Daily Calories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${nutrition.totalCalories.toInt()} / ${nutrition.calorieGoal.toInt()}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CircularPercentIndicator(
                radius: 80.0,
                lineWidth: 8.0,
                percent: nutrition.calorieProgress,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${nutrition.remainingCalories.toInt()}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Text(
                      'remaining',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                progressColor: AppColors.primary,
                backgroundColor: AppColors.surface,
                circularStrokeCap: CircularStrokeCap.round,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildNutrientCard(
                      'Protein',
                      '${nutrition.totalProtein.toInt()}g',
                      '${nutrition.proteinGoal.toInt()}g',
                      nutrition.proteinProgress,
                      AppColors.primaryGradient,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildNutrientCard(
                      'Carbs',
                      '${nutrition.totalCarbs.toInt()}g',
                      '${nutrition.carbsGoal.toInt()}g',
                      nutrition.carbsProgress,
                      AppColors.accentGradient,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildNutrientCard(
                      'Fat',
                      '${nutrition.totalFat.toInt()}g',
                      '${nutrition.fatGoal.toInt()}g',
                      nutrition.fatProgress,
                      AppColors.secondaryGradient,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildNutrientCard(String label, String current, String goal,
      double progress, List<Color> gradient) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.surface, width: 1),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            current,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            'of $goal',
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 8),
          LinearPercentIndicator(
            lineHeight: 4,
            percent: progress.clamp(0.0, 1.0),
            backgroundColor: AppColors.surface,
            linearGradient: LinearGradient(colors: gradient),
            barRadius: const Radius.circular(2),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildWaterTracker() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        final nutrition = nutritionController.dailyNutrition.value;
        if (nutrition == null) return const SizedBox();

        return GlassCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Water Intake',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${nutrition.totalWater.toInt()}ml / ${nutrition.waterGoal.toInt()}ml',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LinearPercentIndicator(
                lineHeight: 12,
                percent: nutrition.waterProgress,
                backgroundColor: AppColors.surface,
                progressColor: const Color(0xFF00BCD4),
                barRadius: const Radius.circular(6),
                leading: const Icon(
                  Icons.water_drop,
                  color: Color(0xFF00BCD4),
                  size: 20,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: nutritionController.quickWaterAmounts
                    .map(
                      (amount) => Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () =>
                                nutritionController.addWaterEntry(amount),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00BCD4).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: const Color(0xFF00BCD4), width: 1),
                              ),
                              child: Text(
                                '+${amount.toInt()}ml',
                                style: const TextStyle(
                                  color: Color(0xFF00BCD4),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildMacronutrientChart() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GlassCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Macronutrient Breakdown',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              final macros = nutritionController.getMacroBreakdown();
              if (macros.isEmpty) {
                return const Center(
                  child: Text(
                    'Add some food to see your macronutrient breakdown',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 120,
                      child: PieChart(
                        PieChartData(
                          sections: macros
                              .map((macro) => PieChartSectionData(
                                    color: macro['color'],
                                    value: macro['value'].toDouble(),
                                    title: '${macro['percentage']}%',
                                    titleStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    radius: 50,
                                  ))
                              .toList(),
                          sectionsSpace: 2,
                          centerSpaceRadius: 25,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: macros
                          .map(
                            (macro) => Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: macro['color'],
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      macro['name'],
                                      style: const TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${macro['value'].toInt()}g',
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMealsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Today\'s Meals',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...['breakfast', 'lunch', 'dinner', 'snack'].map(
            (mealType) => _buildMealCard(mealType),
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard(String mealType) {
    return Obx(() {
      final nutrition = nutritionController.dailyNutrition.value;
      if (nutrition == null) return const SizedBox();

      final meals = nutrition.getMealsByType(mealType);
      final calories = nutrition.getMealCalories(mealType);

      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: GlassCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: _getMealTypeGradient(mealType)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _getMealTypeIcon(mealType),
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _capitalize(mealType),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            '${calories.toInt()} calories',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      nutritionController.setMealType(mealType);
                      _showAddFoodDialog();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              if (meals.isNotEmpty) ...[
                const SizedBox(height: 12),
                ...meals.map((meal) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meal.foodName,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${meal.quantity} ${meal.servingUnit}',
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${meal.totalCalories.toInt()} cal',
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => nutritionController
                                    .removeFoodEntry(meal.id),
                                child: const Icon(
                                  Icons.remove_circle_outline,
                                  color: AppColors.accent,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ] else ...[
                const SizedBox(height: 8),
                Text(
                  'No food added yet',
                  style: TextStyle(
                    color: AppColors.textSecondary.withOpacity(0.7),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }

  List<Color> _getMealTypeGradient(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return [const Color(0xFFFFBE0B), const Color(0xFFFF8500)];
      case 'lunch':
        return [const Color(0xFF06D6A0), const Color(0xFF00BCD4)];
      case 'dinner':
        return [const Color(0xFF6366F1), const Color(0xFF8B5CF6)];
      case 'snack':
        return [const Color(0xFFFF6B6B), const Color(0xFFFF8E53)];
      default:
        return AppColors.primaryGradient;
    }
  }

  IconData _getMealTypeIcon(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return Icons.free_breakfast;
      case 'lunch':
        return Icons.lunch_dining;
      case 'dinner':
        return Icons.dinner_dining;
      case 'snack':
        return Icons.cookie;
      default:
        return Icons.restaurant;
    }
  }

  Widget _buildMealSuggestions() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Meal Suggestions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: nutritionController.mealSuggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion =
                        nutritionController.mealSuggestions[index];
                    return Container(
                      width: 280,
                      margin: const EdgeInsets.only(right: 16),
                      child: _buildMealSuggestionCard(suggestion),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildMealSuggestionCard(suggestion) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _capitalize(suggestion.mealType),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.timer,
                      size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    '${suggestion.prepTimeMinutes}min',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            suggestion.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildNutrientBadge('${suggestion.estimatedCalories.toInt()} cal',
                  AppColors.primary),
              const SizedBox(width: 8),
              _buildNutrientBadge(
                  '${suggestion.estimatedProtein.toInt()}g protein',
                  AppColors.accent),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            suggestion.ingredients.take(3).join(', ') +
                (suggestion.ingredients.length > 3 ? '...' : ''),
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Row(
            children: [
              ...suggestion.tags.take(2).map(
                    (tag) => Container(
                      margin: const EdgeInsets.only(right: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _showAddFoodDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: MediaQuery.of(Get.context!).size.height * 0.8,
          child: GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Add Food',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon:
                          const Icon(Icons.close, color: AppColors.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildMealTypeSelector(),
                const SizedBox(height: 16),
                _buildFoodSearch(),
                const SizedBox(height: 16),
                _buildCategoryFilter(),
                const SizedBox(height: 16),
                Expanded(child: _buildFoodList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMealTypeSelector() {
    return Obx(() => Row(
          children: ['breakfast', 'lunch', 'dinner', 'snack']
              .map(
                (mealType) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      onTap: () => nutritionController.setMealType(mealType),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          gradient:
                              nutritionController.selectedMealType.value ==
                                      mealType
                                  ? LinearGradient(
                                      colors: AppColors.primaryGradient)
                                  : null,
                          color: nutritionController.selectedMealType.value !=
                                  mealType
                              ? AppColors.surface.withOpacity(0.3)
                              : null,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _capitalize(mealType),
                          style: TextStyle(
                            color: nutritionController.selectedMealType.value ==
                                    mealType
                                ? Colors.white
                                : AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ));
  }

  Widget _buildFoodSearch() {
    return CustomTextField(
      controller: nutritionController.searchController,
      label: 'Search',
      hint: 'Search foods...',
      prefixIcon: const Icon(Icons.search),
    );
  }

  Widget _buildCategoryFilter() {
    return Obx(() => SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: nutritionController.foodCategories.length,
            itemBuilder: (context, index) {
              final category = nutritionController.foodCategories[index];
              final isSelected =
                  nutritionController.selectedCategory.value == category;

              return Container(
                margin: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => nutritionController.setCategory(category),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(colors: AppColors.primaryGradient)
                          : null,
                      color: !isSelected
                          ? AppColors.surface.withOpacity(0.3)
                          : null,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color:
                            isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  Widget _buildFoodList() {
    return Obx(() => ListView.builder(
          itemCount: nutritionController.filteredFoods.length,
          itemBuilder: (context, index) {
            final food = nutritionController.filteredFoods[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () => _showFoodDetailsDialog(food),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.surface, width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: _getCategoryGradient(food.category)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _getCategoryIcon(food.category),
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food.name,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${food.caloriesPerServing.toInt()} cal per ${food.servingUnit}',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        food.category,
                        style: const TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  List<Color> _getCategoryGradient(String category) {
    switch (category) {
      case 'Fruits':
        return [const Color(0xFFFF6B6B), const Color(0xFFFF8E53)];
      case 'Vegetables':
        return [const Color(0xFF06D6A0), const Color(0xFF00BCD4)];
      case 'Proteins':
        return [const Color(0xFF6366F1), const Color(0xFF8B5CF6)];
      case 'Grains':
        return [const Color(0xFFFFBE0B), const Color(0xFFFF8500)];
      case 'Dairy':
        return [const Color(0xFF00BCD4), const Color(0xFF0097A7)];
      case 'Snacks':
        return [const Color(0xFFFF8A80), const Color(0xFFFF5722)];
      case 'Beverages':
        return [const Color(0xFF81C784), const Color(0xFF4CAF50)];
      default:
        return AppColors.primaryGradient;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Fruits':
        return Icons.apple;
      case 'Vegetables':
        return Icons.eco;
      case 'Proteins':
        return Icons.lunch_dining;
      case 'Grains':
        return Icons.grain;
      case 'Dairy':
        return Icons.local_drink;
      case 'Snacks':
        return Icons.cookie;
      case 'Beverages':
        return Icons.local_cafe;
      default:
        return Icons.restaurant;
    }
  }

  void _showFoodDetailsDialog(food) {
    nutritionController.selectFood(food);

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          child: GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: _getCategoryGradient(food.category)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getCategoryIcon(food.category),
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            food.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            food.category,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon:
                          const Icon(Icons.close, color: AppColors.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildNutritionInfo('Calories',
                          '${food.caloriesPerServing.toInt()}', 'cal'),
                    ),
                    Expanded(
                      child: _buildNutritionInfo(
                          'Protein', '${food.proteinPerServing.toInt()}', 'g'),
                    ),
                    Expanded(
                      child: _buildNutritionInfo(
                          'Carbs', '${food.carbsPerServing.toInt()}', 'g'),
                    ),
                    Expanded(
                      child: _buildNutritionInfo(
                          'Fat', '${food.fatPerServing.toInt()}', 'g'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Quantity',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => Row(
                      children: [
                        Expanded(
                          child: Slider(
                            value: nutritionController.foodQuantity.value,
                            min: 0.5,
                            max: 5.0,
                            divisions: 9,
                            activeColor: AppColors.primary,
                            onChanged: (value) =>
                                nutritionController.updateFoodQuantity(value),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 80,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.surface.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${nutritionController.foodQuantity.value} ${food.servingUnit}',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )),
                if (food.benefits.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  const Text(
                    'Benefits',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: food.benefits
                        .map<Widget>(
                          (benefit) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              benefit,
                              style: const TextStyle(
                                color: AppColors.success,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
                const SizedBox(height: 20),
                GradientButton(
                  text:
                      'Add to ${nutritionController.selectedMealType.value.capitalize}',
                  onPressed: () {
                    Get.back(); // Close food details
                    nutritionController.addFoodEntry();
                  },
                  icon: Icons.add,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionInfo(String label, String value, String unit) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            unit,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
