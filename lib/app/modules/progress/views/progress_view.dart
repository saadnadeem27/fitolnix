import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../controllers/progress_controller.dart';
import '../../../widgets/custom_widgets.dart';
import '../../../utils/theme.dart';

class ProgressView extends StatelessWidget {
  final progressController = Get.put(ProgressController());

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
                  if (progressController.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
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
                          _buildStatsOverview(),
                          _buildWeeklyProgress(),
                          _buildMonthlyChart(),
                          _buildAchievements(),
                          const SizedBox(height: 80), // Bottom padding
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
          'Progress',
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
          onPressed: () => progressController.refreshData(),
          icon: const Icon(
            Icons.refresh,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsOverview() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'This Month',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Obx(() {
            final stats = progressController.monthlyStats.value;
            if (stats == null) return const SizedBox();
            
            return Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    Icons.fitness_center,
                    '${stats.totalWorkouts}',
                    'Workouts',
                    AppColors.primaryGradient,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    Icons.local_fire_department,
                    '${stats.totalCaloriesBurned}',
                    'Calories',
                    AppColors.accentGradient,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    Icons.timer,
                    '${stats.totalMinutesActive}',
                    'Minutes',
                    AppColors.secondaryGradient,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String value, String label, List<Color> gradient) {
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

  Widget _buildWeeklyProgress() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'This Week',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => Row(
            children: progressController.weeklyProgress.map((day) => 
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: _buildDayProgress(day),
                ),
              ),
            ).toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildDayProgress(day) {
    return GlassCard(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            day.day,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          CircularPercentIndicator(
            radius: 20.0,
            lineWidth: 4.0,
            percent: day.workoutsCompleted / 3.0,
            center: Text(
              '${day.workoutsCompleted}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            progressColor: day.goalAchieved ? AppColors.success : AppColors.primary,
            backgroundColor: AppColors.surface,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          const SizedBox(height: 4),
          Icon(
            day.goalAchieved ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: day.goalAchieved ? AppColors.success : AppColors.textTertiary,
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyChart() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Monthly Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              final stats = progressController.monthlyStats.value;
              if (stats == null) return const SizedBox();
              
              return Row(
                children: [
                  Expanded(
                    child: _buildCircularProgress(
                      'Goal Rate',
                      stats.goalCompletionRate,
                      AppColors.success,
                    ),
                  ),
                  Expanded(
                    child: _buildCircularProgress(
                      'Streak',
                      stats.streakDays / 30.0,
                      AppColors.accent,
                    ),
                  ),
                  Expanded(
                    child: _buildCircularProgress(
                      'Weekly Avg',
                      stats.averageWorkoutsPerWeek / 7.0,
                      AppColors.primary,
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

  Widget _buildCircularProgress(String label, double percentage, Color color) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 35.0,
          lineWidth: 6.0,
          percent: percentage.clamp(0.0, 1.0),
          center: Text(
            '${(percentage * 100).round()}%',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          progressColor: color,
          backgroundColor: AppColors.surface,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAchievements() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Achievements',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Obx(() {
            final recentAchievements = progressController.getUnlockedAchievements()
                .take(3)
                .toList();
            
            return SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recentAchievements.length,
                itemBuilder: (context, index) {
                  final achievement = recentAchievements[index];
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 12),
                    child: _buildAchievementCard(achievement),
                  );
                },
              ),
            );
          }),
          const SizedBox(height: 16),
          Obx(() {
            final overallProgress = progressController.getOverallProgress();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overall Progress: ${(overallProgress * 100).round()}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                LinearPercentIndicator(
                  lineHeight: 8,
                  percent: overallProgress,
                  backgroundColor: AppColors.surface,
                  linearGradient: LinearGradient(colors: AppColors.primaryGradient),
                  barRadius: const Radius.circular(4),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(achievement) {
    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: AppColors.primaryGradient),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.emoji_events,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            achievement.title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}