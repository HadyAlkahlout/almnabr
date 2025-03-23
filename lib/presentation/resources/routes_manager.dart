import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teqani/data/responses/main/dashboard/dashboard_response.dart';
import 'package:teqani/domain/model/auth/otp_data.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/ui/auth/login/login_screen.dart';
import 'package:teqani/presentation/ui/auth/otp/otp_screen.dart';
import 'package:teqani/presentation/ui/main/home_content/dashboard/dashboard_screen.dart';
import 'package:teqani/presentation/ui/main/home_content/settings/settings_screen.dart';
import 'package:teqani/presentation/ui/onboarding/onboarding_screen.dart';
import 'package:teqani/presentation/ui/splash/splash_screen.dart';
import 'package:teqani/presentation/ui/main/wir_form/wir_form_screen.dart';
import 'package:teqani/presentation/ui/main/home/home_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String otpRoute = "/otp";
  static const String mainRoute = "/main";
  static const String wirRoute = "/main/wir";

  static const int dashboardIndex = 0;
  static const int settingIndex = 1;
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // Splash Screen
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      // Onboarding Screen
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      // Login Screen
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      // OTP Screen
      case Routes.otpRoute:
        return MaterialPageRoute(builder: (_) {
          print('Arguments : ${routeSettings.arguments}');
          final otpData = routeSettings.arguments as OtpData;
          return OtpScreen(
            otpData: otpData,
          );
        });
      // Main Screen
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      // WIR Form Screen
      case Routes.wirRoute:
        return MaterialPageRoute(builder: (_) {
          print('Arguments : ${routeSettings.arguments}');
          final form = routeSettings.arguments as AppForm;
          return WIRFormScreen(
            form: form,
          );
        });
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => _noRoutScreen(),
    );
  }

  static Widget _noRoutScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.noRouteFound).tr(),
      ),
      body: Center(child: Text(AppStrings.noRouteFound).tr()),
    );
  }

  static Widget getMainScreen(int index) {
    switch (index) {
      // Dashboard Screen
      case Routes.dashboardIndex:
        return DashboardScreen();
      // Setting Screen
      case Routes.settingIndex:
        return SettingsScreen();
      default:
        return _noRoutScreen();
    }
  }
}
