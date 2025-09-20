import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../../widgets/custom_widgets.dart';
import '../../../utils/theme.dart';
import '../../../utils/constants.dart';

class SignupView extends StatelessWidget {
  final authController = Get.find<AuthController>();

  SignupView({super.key});

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
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
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
                    Text(
                      'Create Account',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),

              // Progress Indicator
              Obx(() => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: List.generate(3, (index) {
                        final isActive =
                            index <= authController.currentStep.value;
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                              right: index < 2 ? 8 : 0,
                            ),
                            height: 4,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.primary
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      }),
                    ),
                  )),

              // Content
              Expanded(
                child: Obx(() {
                  switch (authController.currentStep.value) {
                    case 0:
                      return _buildAccountInfoStep();
                    case 1:
                      return _buildPersonalInfoStep();
                    case 2:
                      return _buildGoalSelectionStep();
                    default:
                      return _buildAccountInfoStep();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Text(
            'Account Information',
            style: Get.textTheme.headlineLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Enter your basic account details',
            style: Get.textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          GlassCard(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: authController.signupFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    label: 'Full Name',
                    hint: 'Enter your full name',
                    controller: authController.nameController,
                    prefixIcon: const Icon(
                      Icons.person_outlined,
                      color: AppColors.textSecondary,
                    ),
                    validator: (value) =>
                        authController.validateRequired(value, 'Name'),
                  ),
                  CustomTextField(
                    label: 'Email',
                    hint: 'Enter your email',
                    controller: authController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: AppColors.textSecondary,
                    ),
                    validator: authController.validateEmail,
                  ),
                  Obx(() => CustomTextField(
                        label: 'Password',
                        hint: 'Create a password',
                        controller: authController.passwordController,
                        obscureText: !authController.isPasswordVisible.value,
                        prefixIcon: const Icon(
                          Icons.lock_outlined,
                          color: AppColors.textSecondary,
                        ),
                        suffixIcon: IconButton(
                          onPressed: authController.togglePasswordVisibility,
                          icon: Icon(
                            authController.isPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        validator: authController.validatePassword,
                      )),
                  Obx(() => CustomTextField(
                        label: 'Confirm Password',
                        hint: 'Confirm your password',
                        controller: authController.confirmPasswordController,
                        obscureText:
                            !authController.isConfirmPasswordVisible.value,
                        prefixIcon: const Icon(
                          Icons.lock_outlined,
                          color: AppColors.textSecondary,
                        ),
                        suffixIcon: IconButton(
                          onPressed:
                              authController.toggleConfirmPasswordVisibility,
                          icon: Icon(
                            authController.isConfirmPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        validator: authController.validateConfirmPassword,
                        margin: EdgeInsets.zero,
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          GradientButton(
            text: 'Continue',
            onPressed: () {
              if (authController.signupFormKey.currentState!.validate()) {
                authController.nextStep();
              }
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: Get.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: Text(
                  'Sign In',
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Text(
            'Personal Details',
            style: Get.textTheme.headlineLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Help us personalize your experience',
            style: Get.textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          GlassCard(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: authController.personalInfoFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    label: 'Age',
                    hint: 'Enter your age',
                    controller: authController.ageController,
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(
                      Icons.cake_outlined,
                      color: AppColors.textSecondary,
                    ),
                    validator: (value) =>
                        authController.validateNumber(value, 'Age'),
                  ),

                  // Gender Selection
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gender',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => Row(
                            children: [
                              Expanded(
                                child: _buildGenderOption('Male'),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildGenderOption('Female'),
                              ),
                            ],
                          )),
                      const SizedBox(height: 16),
                    ],
                  ),

                  CustomTextField(
                    label: 'Height (cm)',
                    hint: 'Enter your height',
                    controller: authController.heightController,
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(
                      Icons.height,
                      color: AppColors.textSecondary,
                    ),
                    validator: (value) =>
                        authController.validateNumber(value, 'Height'),
                  ),

                  CustomTextField(
                    label: 'Weight (kg)',
                    hint: 'Enter your weight',
                    controller: authController.weightController,
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(
                      Icons.monitor_weight_outlined,
                      color: AppColors.textSecondary,
                    ),
                    validator: (value) =>
                        authController.validateNumber(value, 'Weight'),
                    margin: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: GlassCard(
                  onTap: authController.previousStep,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const Center(
                    child: Text(
                      'Back',
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
              Expanded(
                flex: 2,
                child: GradientButton(
                  text: 'Continue',
                  onPressed: () {
                    if (authController.personalInfoFormKey.currentState!
                        .validate()) {
                      authController.nextStep();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoalSelectionStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Text(
            'Fitness Goal',
            style: Get.textTheme.headlineLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose your primary fitness objective',
            style: Get.textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          Obx(() => Column(
                children: AppConstants.fitnessGoals.map((goal) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: _buildGoalCard(goal),
                  );
                }).toList(),
              )),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: GlassCard(
                  onTap: authController.previousStep,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const Center(
                    child: Text(
                      'Back',
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
              Expanded(
                flex: 2,
                child: Obx(() => GradientButton(
                      text: 'Create Account',
                      onPressed: authController.signup,
                      isLoading: authController.isLoading.value,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    return Obx(() => GlassCard(
          onTap: () => authController.selectGender(gender),
          padding: const EdgeInsets.symmetric(vertical: 12),
          gradient: authController.selectedGender.value == gender
              ? AppColors.primaryGradient
                  .map((c) => c.withOpacity(0.2))
                  .toList()
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                gender == 'Male' ? Icons.male : Icons.female,
                color: authController.selectedGender.value == gender
                    ? AppColors.primary
                    : AppColors.textSecondary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                gender,
                style: TextStyle(
                  color: authController.selectedGender.value == gender
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildGoalCard(String goal) {
    final icons = {
      'Lose Weight': Icons.trending_down,
      'Gain Muscle': Icons.fitness_center,
      'Stay Fit': Icons.favorite,
      'Improve Endurance': Icons.directions_run,
    };

    final gradients = {
      'Lose Weight': AppColors.accentGradient,
      'Gain Muscle': AppColors.primaryGradient,
      'Stay Fit': AppColors.secondaryGradient,
      'Improve Endurance': [AppColors.warning, const Color(0xFFF59E0B)],
    };

    return Obx(() => GlassCard(
          onTap: () => authController.selectGoal(goal),
          padding: const EdgeInsets.all(20),
          gradient: authController.selectedGoal.value == goal
              ? gradients[goal]!.map((c) => c.withOpacity(0.2)).toList()
              : null,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradients[goal]!,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icons[goal],
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  goal,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (authController.selectedGoal.value == goal)
                Icon(
                  Icons.check_circle,
                  color: gradients[goal]!.first,
                  size: 24,
                ),
            ],
          ),
        ));
  }
}
