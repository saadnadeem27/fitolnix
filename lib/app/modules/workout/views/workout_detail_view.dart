import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../controllers/workout_controller.dart';
import '../../../widgets/custom_widgets.dart';
import '../../../utils/theme.dart';

class WorkoutDetailView extends StatelessWidget {
  const WorkoutDetailView({super.key});

  WorkoutController get workoutController => Get.find<WorkoutController>();

  @override
  Widget build(BuildContext context) {
    final workout = Get.arguments;
    if (workout == null) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.backgroundGradient,
            ),
          ),
          child: const Center(
            child: Text(
              'Workout not found',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(workout),
            SliverToBoxAdapter(
              child: AnimationLimiter(
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      _buildWorkoutInfo(workout),
                      _buildExercisesList(workout),
                      const SizedBox(height: 100), // Bottom padding
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildStartButton(workout),
    );
  }

  Widget _buildSliverAppBar(workout) {
    final categoryColor = workoutController.getCategoryColor(workout.category);

    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        Obx(() => IconButton(
              onPressed: () => workoutController.toggleFavorite(workout.id),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  workoutController.favoriteWorkouts.contains(workout.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: workoutController.favoriteWorkouts.contains(workout.id)
                      ? AppColors.accent
                      : Colors.white,
                ),
              ),
            )),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                categoryColor,
                categoryColor.withOpacity(0.8),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Background pattern
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ),
              // Content
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        workout.category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      workout.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutInfo(workout) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Row
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  Icons.timer,
                  '${workout.duration}',
                  'minutes',
                  AppColors.primaryGradient,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  Icons.local_fire_department,
                  '${workout.caloriesBurned}',
                  'calories',
                  AppColors.accentGradient,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  Icons.fitness_center,
                  '${workout.exercises.length}',
                  'exercises',
                  AppColors.secondaryGradient,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Description
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            workout.description,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          // Difficulty
          Row(
            children: [
              const Text(
                'Difficulty: ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              _buildDifficultyChip(workout.difficulty),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      IconData icon, String value, String label, List<Color> gradient) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradient),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        difficulty,
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildExercisesList(workout) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Exercises',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: workout.exercises.length,
            itemBuilder: (context, index) {
              final exercise = workout.exercises[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: _buildExerciseCard(exercise, index + 1),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(exercise, int number) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: AppColors.primaryGradient),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    number.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  exercise.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            exercise.description,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (exercise.sets > 0) ...[
                _buildExerciseInfo('Sets', exercise.sets.toString()),
                const SizedBox(width: 16),
              ],
              if (exercise.reps > 0) ...[
                _buildExerciseInfo('Reps', exercise.reps.toString()),
                const SizedBox(width: 16),
              ],
              if (exercise.duration != null && exercise.duration! > 0)
                _buildExerciseInfo('Duration', '${exercise.duration}s'),
            ],
          ),
          if (exercise.instructions != null) ...[
            const SizedBox(height: 12),
            Text(
              'Instructions: ${exercise.instructions}',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textTertiary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExerciseInfo(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStartButton(workout) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: GradientButton(
        text: 'Start Workout',
        onPressed: () => _showWorkoutTimer(workout),
        icon: Icons.play_arrow,
        height: 56,
      ),
    );
  }

  void _showWorkoutTimer(workout) {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => WorkoutTimerSheet(workout: workout),
    );
  }
}

class WorkoutTimerSheet extends StatelessWidget {
  final workout;
  WorkoutTimerSheet({super.key, required this.workout});

  WorkoutController get workoutController => Get.find<WorkoutController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.backgroundGradient,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textSecondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    workoutController.exitWorkout();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.textPrimary,
                  ),
                ),
                Expanded(
                  child: Text(
                    workout.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 48), // Balance the close button
              ],
            ),
          ),

          // Progress
          Obx(() {
            final currentIndex = workoutController.currentExerciseIndex.value;
            final totalExercises = workout.exercises.length;
            final progress =
                totalExercises > 0 ? (currentIndex + 1) / totalExercises : 0.0;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  LinearPercentIndicator(
                    lineHeight: 8,
                    percent: progress,
                    backgroundColor: AppColors.surface,
                    linearGradient:
                        LinearGradient(colors: AppColors.primaryGradient),
                    barRadius: const Radius.circular(4),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Exercise ${currentIndex + 1} of $totalExercises',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }),

          // Current Exercise
          Expanded(
            child: Obx(() {
              final currentIndex = workoutController.currentExerciseIndex.value;
              if (currentIndex < workout.exercises.length) {
                final exercise = workout.exercises[currentIndex];
                return _buildCurrentExercise(exercise);
              }
              return const Center(
                child: Text(
                  'Workout Complete!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              );
            }),
          ),

          // Timer Controls
          _buildTimerControls(),
        ],
      ),
    );
  }

  Widget _buildCurrentExercise(exercise) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Exercise Icon/Image
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: AppColors.primaryGradient),
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(
              Icons.fitness_center,
              color: Colors.white,
              size: 60,
            ),
          ),

          const SizedBox(height: 24),

          // Exercise Name
          Text(
            exercise.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          // Exercise Description
          Text(
            exercise.description,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          // Exercise Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (exercise.sets > 0)
                _buildExerciseDetail('Sets', exercise.sets.toString()),
              if (exercise.reps > 0)
                _buildExerciseDetail('Reps', exercise.reps.toString()),
              if (exercise.duration != null && exercise.duration! > 0)
                _buildExerciseDetail('Duration', '${exercise.duration}s'),
            ],
          ),

          // Timer Display
          if (exercise.duration != null && exercise.duration! > 0) ...[
            const SizedBox(height: 32),
            Obx(() => Text(
                  _formatTime(workoutController.timerSeconds.value),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                )),
          ],
        ],
      ),
    );
  }

  Widget _buildExerciseDetail(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildTimerControls() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        final currentIndex = workoutController.currentExerciseIndex.value;
        final exercise = workout.exercises[currentIndex];
        final hasTimer = exercise.duration != null && exercise.duration! > 0;

        return Row(
          children: [
            // Skip Button
            Expanded(
              child: GlassCard(
                onTap: workoutController.skipExercise,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Center(
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Start/Pause Button
            Expanded(
              flex: 2,
              child: GradientButton(
                text: hasTimer
                    ? (workoutController.isTimerRunning.value
                        ? 'Pause'
                        : 'Start')
                    : 'Complete',
                onPressed: () {
                  if (hasTimer) {
                    if (workoutController.isTimerRunning.value) {
                      workoutController.pauseTimer();
                    } else {
                      if (workoutController.timerSeconds.value == 0) {
                        workoutController.startTimer(exercise.duration!);
                      } else {
                        workoutController.resumeTimer();
                      }
                    }
                  } else {
                    workoutController.skipExercise();
                  }
                },
                icon: hasTimer
                    ? (workoutController.isTimerRunning.value
                        ? Icons.pause
                        : Icons.play_arrow)
                    : Icons.check,
              ),
            ),
          ],
        );
      }),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
