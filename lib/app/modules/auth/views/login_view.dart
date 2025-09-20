import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../../widgets/custom_widgets.dart';
import '../../../utils/theme.dart';
import 'signup_view.dart';

class LoginView extends StatelessWidget {
  // Using getter instead of top-level field to avoid constant expression errors
  // Try to find an existing AuthController; if not found, create and register one.
  AuthController get authController {
    try {
      return Get.find<AuthController>();
    } catch (_) {
      // Binding might not have been executed (e.g., view pushed without GetPage binding)
      return Get.put(AuthController());
    }
  }

  const LoginView({super.key});

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),

                // App Logo/Title
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
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
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.fitness_center,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Welcome Back!',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Sign in to continue your fitness journey',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Login Form
                GlassCard(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                    key: authController.loginFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                        const SizedBox(height: 8),
                        Obx(() => CustomTextField(
                              label: 'Password',
                              hint: 'Enter your password',
                              controller: authController.passwordController,
                              obscureText:
                                  !authController.isPasswordVisible.value,
                              prefixIcon: const Icon(
                                Icons.lock_outlined,
                                color: AppColors.textSecondary,
                              ),
                              suffixIcon: IconButton(
                                onPressed:
                                    authController.togglePasswordVisibility,
                                icon: Icon(
                                  authController.isPasswordVisible.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              validator: authController.validatePassword,
                            )),
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // TODO: Implement forgot password
                              Get.snackbar(
                                'Coming Soon',
                                'Forgot password feature will be available soon',
                                backgroundColor: AppColors.warning,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP,
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Obx(() => GradientButton(
                              text: 'Sign In',
                              onPressed: authController.login,
                              isLoading: authController.isLoading.value,
                            )),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Social Login Options
                Text(
                  'Or continue with',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textTertiary,
                        fontSize: 12,
                      ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _buildSocialButton(
                        'Google',
                        Icons.g_mobiledata,
                        () {
                          Get.snackbar(
                            'Coming Soon',
                            'Google sign-in will be available soon',
                            backgroundColor: AppColors.warning,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildSocialButton(
                        'Apple',
                        Icons.apple,
                        () {
                          Get.snackbar(
                            'Coming Soon',
                            'Apple sign-in will be available soon',
                            backgroundColor: AppColors.warning,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                          );
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SignupView());
                      },
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String text, IconData icon, VoidCallback onTap) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.textPrimary,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
