import 'package:get/get.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/splash_view.dart';
import '../modules/auth/views/onboarding_view.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/signup_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/workout/views/workout_list_view.dart';
import '../modules/workout/views/workout_detail_view.dart';
import '../modules/progress/bindings/progress_binding.dart';
import '../modules/progress/views/progress_view.dart';
import '../modules/nutrition/bindings/nutrition_binding.dart';
import '../modules/nutrition/views/nutrition_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
    ),
    GetPage(
      name: _Paths.WORKOUT_LIST,
      page: () => WorkoutListView(),
    ),
    GetPage(
      name: _Paths.WORKOUT_DETAIL,
      page: () => WorkoutDetailView(),
    ),
    GetPage(
      name: _Paths.PROGRESS,
      page: () => ProgressView(),
      binding: ProgressBinding(),
    ),
    GetPage(
      name: _Paths.NUTRITION,
      page: () => NutritionView(),
      binding: NutritionBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}