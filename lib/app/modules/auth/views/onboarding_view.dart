import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../controllers/auth_controller.dart';
import '../../../widgets/custom_widgets.dart';
import '../../../utils/theme.dart';

class OnboardingView extends StatefulWidget {
  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final authController = Get.put(AuthController());
  final PageController pageController = PageController();

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
          child: PageView(
            controller: pageController,
            children: [
              _buildWelcomePage(),
              _buildGoalSelectionPage(),
              _buildGetStartedPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Spacer(flex: 2),

          // App Logo/Animation Placeholder
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: AppColors.primaryGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.fitness_center,
              size: 80,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 30),

          // Animated Title
          SizedBox(
            height: 50,
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Welcome to Fitolnix',
                  textStyle: const TextStyle(
                    fontSize: 28,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1,
            ),
          ),

          const SizedBox(height: 12),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Your ultimate fitness companion for a healthier, stronger you',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ),

          const Spacer(flex: 2),

          // Features List
          _buildFeatureItem(Icons.fitness_center, 'Personalized Workouts'),
          _buildFeatureItem(Icons.trending_up, 'Track Your Progress'),
          _buildFeatureItem(Icons.restaurant, 'Nutrition Guidance'),
          _buildFeatureItem(Icons.emoji_events, 'Achievements & Rewards'),

          const Spacer(flex: 2),

          GradientButton(
            text: 'Get Started',
            onPressed: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            icon: Icons.arrow_forward,
          ),

          const SizedBox(height: 12),

          TextButton(
            onPressed: () {
              authController.completeOnboarding();
            },
            child: const Text(
              'Already have an account? Sign In',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ),

          const SizedBox(height: 16), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildGoalSelectionPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'What\'s your goal?',
                style: TextStyle(
                  fontSize: 28,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Choose your primary fitness objective to get personalized recommendations',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: ListView(
              children: [
                _buildGoalCard(
                  'Lose Weight',
                  'Burn calories and shed pounds',
                  Icons.trending_down,
                  AppColors.accentGradient,
                ),
                const SizedBox(height: 16),
                _buildGoalCard(
                  'Gain Muscle',
                  'Build strength and muscle mass',
                  Icons.fitness_center,
                  AppColors.primaryGradient,
                ),
                const SizedBox(height: 16),
                _buildGoalCard(
                  'Stay Fit',
                  'Maintain overall health and fitness',
                  Icons.favorite,
                  AppColors.secondaryGradient,
                ),
                const SizedBox(height: 16),
                _buildGoalCard(
                  'Improve Endurance',
                  'Boost stamina and cardiovascular health',
                  Icons.directions_run,
                  [AppColors.warning, const Color(0xFFF59E0B)],
                ),
              ],
            ),
          ),
          Obx(() => GradientButton(
                text: 'Continue',
                onPressed: authController.selectedGoal.value.isEmpty
                    ? () {}
                    : () {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                gradient: authController.selectedGoal.value.isEmpty
                    ? [AppColors.textTertiary, AppColors.textTertiary]
                    : AppColors.primaryGradient,
              )),
        ],
      ),
    );
  }

  Widget _buildGetStartedPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 40),

          Row(
            children: [
              IconButton(
                onPressed: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'You\'re all set!',
                style: TextStyle(
                  fontSize: 28,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const Spacer(),

          // Success Animation Placeholder
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: AppColors.secondaryGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondary.withOpacity(0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.check,
              size: 60,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 40),

          Obx(() => Text(
                'Perfect! We\'ll help you ${authController.selectedGoal.value.toLowerCase()} with personalized workouts and nutrition tips.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              )),

          const Spacer(),

          GradientButton(
            text: 'Start My Journey',
            onPressed: () {
              authController.completeOnboarding();
            },
            icon: Icons.rocket_launch,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.primaryGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(
      String title, String description, IconData icon, List<Color> gradient) {
    return Obx(() => GlassCard(
          onTap: () {
            authController.selectGoal(title);
          },
          padding: const EdgeInsets.all(14),
          gradient: authController.selectedGoal.value == title
              ? gradient.map((c) => c.withOpacity(0.2)).toList()
              : null,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (authController.selectedGoal.value == title)
                Icon(
                  Icons.check_circle,
                  color: gradient.first,
                  size: 20,
                ),
            ],
          ),
        ));
  }
}
