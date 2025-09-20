part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const ONBOARDING = _Paths.ONBOARDING;
  static const LOGIN = _Paths.LOGIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const HOME = _Paths.HOME;
  static const WORKOUT_LIST = _Paths.WORKOUT_LIST;
  static const WORKOUT_DETAIL = _Paths.WORKOUT_DETAIL;
  static const PROGRESS = _Paths.PROGRESS;
  static const NUTRITION = _Paths.NUTRITION;
  static const PROFILE = _Paths.PROFILE;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const ONBOARDING = '/onboarding';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const HOME = '/home';
  static const WORKOUT_LIST = '/workout-list';
  static const WORKOUT_DETAIL = '/workout-detail';
  static const PROGRESS = '/progress';
  static const NUTRITION = '/nutrition';
  static const PROFILE = '/profile';
}