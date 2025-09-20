import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app/data/services/storage_service.dart';
import 'app/data/services/supabase_config.dart';
import 'app/utils/theme.dart';
import 'app/modules/auth/views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await StorageService.init();
  await SupabaseConfig.initialize();

  runApp(FitolnixApp());
}

class FitolnixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fitolnix',
      theme: AppTheme.darkTheme.copyWith(
        textTheme: GoogleFonts.interTextTheme(AppTheme.darkTheme.textTheme),
      ),
      debugShowCheckedModeBanner: false,
      // Using a direct home widget so app runs even if route definitions
      // (app_pages.dart) are not available. Navigation can still use
      // direct constructors via Get.to(() => SomeView()).
      home: SplashView(),
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
