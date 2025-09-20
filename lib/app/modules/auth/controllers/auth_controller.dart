import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/services/storage_service.dart';
import '../../../data/models/user.dart';
import '../../../routes/app_pages.dart';
import '../views/login_view.dart';
import '../../home/views/home_view.dart';

class AuthController extends GetxController {
  // Observable variables
  final isLoading = false.obs;
  final currentStep = 0.obs;
  final selectedGoal = ''.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  // Form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final selectedGender = 'Male'.obs;

  // Form keys
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  final personalInfoFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // Only check navigation after splash screen if we're not on splash/onboarding routes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.currentRoute != '/splash' && Get.currentRoute != '/onboarding') {
        checkFirstTime();
      }
    });
  }

  // @override
  // void onClose() {
  //   nameController.dispose();
  //   emailController.dispose();
  //   passwordController.dispose();
  //   confirmPasswordController.dispose();
  //   ageController.dispose();
  //   heightController.dispose();
  //   weightController.dispose();
  //   super.onClose();
  // }

  void checkFirstTime() {
    // Only check for existing login if user has completed onboarding
    if (!StorageService.isFirstTime && StorageService.onboardingCompleted) {
      // Check if user is logged in
      if (StorageService.userToken != null) {
        Get.offAll(() => HomeView());
      } else {
        Get.offAll(() => LoginView());
      }
    }
    // If first time or onboarding not completed, stay on current route (splash -> onboarding)
  }

  void completeOnboarding() {
    StorageService.isFirstTime = false;
    StorageService.onboardingCompleted = true;
    Get.off(() => LoginView());
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void selectGoal(String goal) {
    selectedGoal.value = goal;
  }

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  Future<void> login() async {
    // if (!loginFormKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock user data
      final user = User(
        id: '1',
        name: 'Alex Johnson',
        email: emailController.text,
        age: 25,
        height: 175,
        weight: 70,
        gender: 'Male',
        fitnessGoal: 'Stay Fit',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save user data
      StorageService.userToken = 'mock_token_123';
      StorageService.userData = user.toJson();

      // Using direct navigation instead of named routes
      Get.offAll(() => HomeView());
      Get.snackbar(
        'Welcome!',
        'Successfully logged in',
        backgroundColor: const Color(0xFF06D6A0),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed. Please try again.',
        backgroundColor: const Color(0xFFEA4335),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup() async {
    if (!signupFormKey.currentState!.validate()) return;
    if (!personalInfoFormKey.currentState!.validate()) return;
    if (selectedGoal.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select your fitness goal',
        backgroundColor: const Color(0xFFEA4335),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 3));

      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: nameController.text,
        email: emailController.text,
        age: int.parse(ageController.text),
        height: double.parse(heightController.text),
        weight: double.parse(weightController.text),
        gender: selectedGender.value,
        fitnessGoal: selectedGoal.value,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save user data
      StorageService.userToken = 'mock_token_${user.id}';
      StorageService.userData = user.toJson();

      // Using direct navigation instead of named routes
      Get.offAll(() => HomeView());
      Get.snackbar(
        'Welcome to Fitolnix!',
        'Account created successfully',
        backgroundColor: const Color(0xFF06D6A0),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Signup failed. Please try again.',
        backgroundColor: const Color(0xFFEA4335),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    StorageService.userToken = null;
    StorageService.userData = null;
    // Using direct navigation instead of named routes
    Get.offAll(() => LoginView());
  }

  // Validators
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? validateNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }
}
