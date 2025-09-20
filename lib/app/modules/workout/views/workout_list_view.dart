import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/workout_controller.dart';
import '../../../widgets/custom_widgets.dart';
import '../../../utils/theme.dart';
import 'workout_detail_view.dart';

class WorkoutListView extends StatelessWidget {
  const WorkoutListView({super.key});

  WorkoutController get workoutController {
    // Ensure controller is registered before returning. Use lazyPut if not found.
    if (!Get.isRegistered<WorkoutController>()) {
      Get.put(WorkoutController());
    }
    return Get.find<WorkoutController>();
  }

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
          child: Column(
            children: [
              _buildHeader(),
              _buildSearchBar(),
              _buildFilters(),
              Expanded(child: _buildWorkoutGrid()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Workouts',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Obx(() => Text(
                      '${workoutController.filteredWorkouts.length} workouts available',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    )),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Show favorites
              _showFavorites();
            },
            icon: const Icon(
              Icons.favorite,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomTextField(
        label: '',
        hint: 'Search workouts...',
        controller: workoutController.searchController,
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.textSecondary,
        ),
        margin: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: workoutController.categories.length,
                  itemBuilder: (context, index) {
                    final category = workoutController.categories[index];
                    final isSelected =
                        workoutController.selectedCategory.value == category;

                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: _buildFilterChip(
                        category,
                        isSelected,
                        () => workoutController.setCategory(category),
                        category == 'All'
                            ? Icons.apps
                            : workoutController.getCategoryIcon(category),
                        category == 'All'
                            ? AppColors.primaryGradient
                            : [
                                workoutController.getCategoryColor(category),
                                workoutController.getCategoryColor(category)
                              ],
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap,
      IconData icon, List<Color> gradient) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: isSelected ? LinearGradient(colors: gradient) : null,
          color: isSelected ? null : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.glassBorder,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppColors.textSecondary,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutGrid() {
    return Obx(() {
      if (workoutController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        );
      }

      if (workoutController.filteredWorkouts.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              const Text(
                'No workouts found',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Try adjusting your filters',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        );
      }

      return AnimationLimiter(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          itemCount: workoutController.filteredWorkouts.length,
          itemBuilder: (context, index) {
            final workout = workoutController.filteredWorkouts[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: _buildWorkoutCard(workout),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildWorkoutCard(workout) {
    final categoryColor = workoutController.getCategoryColor(workout.category);
    final categoryIcon = workoutController.getCategoryIcon(workout.category);
    return Hero(
      tag: 'workout-${workout.id}',
      child: GestureDetector(
        onTap: () => Get.to(() => WorkoutDetailView(), arguments: workout),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          constraints: const BoxConstraints(maxHeight: 120), // Constrain height
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.surface, AppColors.surface.withOpacity(0.9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: AppColors.glassBorder.withOpacity(0.15),
              width: 0.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Category Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [categoryColor, categoryColor.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: categoryColor.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    categoryIcon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                // Content Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title and Favorite Row
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              workout.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Obx(() => IconButton(
                                onPressed: () => workoutController
                                    .toggleFavorite(workout.id),
                                icon: Icon(
                                  workoutController.favoriteWorkouts
                                          .contains(workout.id)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: workoutController.favoriteWorkouts
                                          .contains(workout.id)
                                      ? AppColors.accent
                                      : AppColors.textSecondary,
                                  size: 18,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                tooltip: 'Favorite',
                              )),
                        ],
                      ),
                      const SizedBox(height: 2),
                      // Description
                      Text(
                        workout.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          height: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      // Stats Row
                      Row(
                        children: [
                          _buildCompactInfoChip(
                            Icons.local_fire_department,
                            '${workout.caloriesBurned}',
                            AppColors.accent,
                          ),
                          const SizedBox(width: 12),
                          _buildCompactInfoChip(
                            Icons.timer,
                            '${workout.duration}m',
                            AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          _buildDifficultyChip(workout.difficulty),
                          const Spacer(),
                          // Category Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: categoryColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: categoryColor.withOpacity(0.25),
                                width: 0.5,
                              ),
                            ),
                            child: Text(
                              workout.category,
                              style: TextStyle(
                                color: categoryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactInfoChip(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: AppColors.textPrimary.withOpacity(0.9),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDifficultyChip(String difficulty) {
    Color color;
    switch (difficulty) {
      case 'Beginner':
        color = AppColors.success;
        break;
      case 'Intermediate':
        color = AppColors.warning;
        break;
      case 'Advanced':
        color = AppColors.accent;
        break;
      default:
        color = AppColors.textSecondary;
    }

    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            difficulty.substring(0, 3), // Show only first 3 letters
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showFavorites() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.backgroundGradient,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textSecondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Favorite Workouts ❤️',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Flexible(
              child: Obx(() {
                final favorites = workoutController.getFavoriteWorkouts();
                if (favorites.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      'No favorite workouts yet.\nTap the heart icon to add workouts to favorites!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: _buildWorkoutCard(favorites[index]),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
