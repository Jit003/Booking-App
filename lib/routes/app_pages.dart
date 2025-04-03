import 'package:bhadranee_employee/routes/app_routes.dart';
import 'package:bhadranee_employee/views/dashboard_screen.dart';
import 'package:bhadranee_employee/views/login_screen.dart';
import 'package:bhadranee_employee/views/otp_screen.dart';
import 'package:bhadranee_employee/views/splash_screen.dart';
import 'package:bhadranee_employee/views/vehicle_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(
        name: AppRoutes.dashboardScreen, page: () => DashboardScreen()),
    GetPage(name: AppRoutes.otpScreen, page: ()=>OtpScreen()),
    GetPage(name: AppRoutes.vehicleScreen, page: ()=>VehicleScreen())
  ];
}
