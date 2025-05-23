import 'package:bhadranee_employee/controller/email_login_controller.dart';
import 'package:bhadranee_employee/routes/app_routes.dart';
import 'package:bhadranee_employee/views/booking_form_screen.dart';
import 'package:bhadranee_employee/views/dashboard_screen.dart';
import 'package:bhadranee_employee/views/notification_screen.dart';
import 'package:bhadranee_employee/views/number_login_screen.dart';
import 'package:bhadranee_employee/views/otp_screen.dart';
import 'package:bhadranee_employee/views/payment_processing_screen.dart';
import 'package:bhadranee_employee/views/payment_success_screen.dart';
import 'package:bhadranee_employee/views/profile_screen.dart';
import 'package:bhadranee_employee/views/splash_screen.dart';
import 'package:bhadranee_employee/views/vehicle_screen.dart';
import 'package:bhadranee_employee/widgets/main_screen.dart';
import 'package:get/get.dart';

import '../views/login_screen_.dart';
import '../views/register_screen.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(
      name: AppRoutes.mainScreen,
      page: () => MainScaffold(),
    ),
    GetPage(name: AppRoutes.numLoginScreen, page: () => NumberLoginScreen()),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(name: AppRoutes.registerPage, page: () => RegisterScreen()),
    GetPage(name: AppRoutes.dashboardScreen, page: () => DashboardScreen()),
    GetPage(name: AppRoutes.otpScreen, page: () => OtpScreen()),
    GetPage(name: AppRoutes.vehicleScreen, page: () => VehicleScreen()),
    GetPage(name: AppRoutes.formScreen, page: () => BookingFormScreen()),
    GetPage(
        name: AppRoutes.notificationScreen, page: () => NotificationScreen()),
    GetPage(
      name: AppRoutes.profileScreen,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.paymentSuccessScreen,
      page: () => const PaymentSuccessPage(),
    ),
    GetPage(
      name: AppRoutes.paymentProcessingScreen,
      page: () => PaymentProcessingScreen(),
    ),
  ];
}
