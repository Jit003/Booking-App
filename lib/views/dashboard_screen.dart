import 'package:bhadranee_employee/constant/app_color.dart';
import 'package:bhadranee_employee/controller/login_controller.dart';
import 'package:bhadranee_employee/controller/vehicle_list_controller.dart';
import 'package:bhadranee_employee/widgets/all_vehicle.dart';
import 'package:bhadranee_employee/widgets/big_button.dart';
import 'package:bhadranee_employee/widgets/calender_widget_barat.dart';
import 'package:bhadranee_employee/widgets/calender_widget_eicher.dart';
import 'package:bhadranee_employee/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_images.dart';
import '../controller/booking_controller.dart';
import '../widgets/availability_info.dart';
import '../widgets/calender_skeleton.dart';
import '../widgets/calender_widget_tata.dart';

class DashboardScreen extends StatelessWidget {
  final BookingController bookingController = Get.put(BookingController());
  final AuthController authController = Get.put(AuthController());
  final VehicleController vehicleController = Get.put(VehicleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    vehicleController.fetchVehiclesByCategory("Eicher");
                  },
                  child: const Text(
                    'Book Your Date',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20),

                Obx(() => Row(
                      children: [
                        Expanded(
                          child: customButtonforCal(
                            text: "Tata Setup",
                            isSelected:
                                vehicleController.selectedCategory.value ==
                                    "Tata Setup",
                            onPressed: () => vehicleController
                                .fetchVehiclesByCategory("Tata Setup"),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: customButtonforCal(
                            text: "Barat on wheels",
                            isSelected:
                                vehicleController.selectedCategory.value ==
                                    "Barat on wheels",
                            onPressed: () => vehicleController
                                .fetchVehiclesByCategory("Barat on wheels"),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: customButtonforCal(
                            text: "Eicher",
                            isSelected:
                                vehicleController.selectedCategory.value ==
                                    "Eicher",
                            onPressed: () => vehicleController
                                .fetchVehiclesByCategory("Eicher"),
                          ),
                        ),
                      ],
                    )),

                const SizedBox(height: 20),

                Obx(() {
                  if (bookingController.isLoading.value) {
                    return const Center(child: CalendarSkeleton());
                  }

                  Widget calendarToShow;
                  switch (vehicleController.selectedCalendarType.value) {
                    case 'Tata Setup':
                      calendarToShow = CalendarWidgetforTata();
                      break;
                    case 'Barat on wheels':
                      calendarToShow = CalendarWidgetforBarat();
                      break;
                    case 'Eicher':
                      calendarToShow = CalendarWidgetforEicher();
                      break;
                    default:
                      calendarToShow = const SizedBox(); // Empty fallback
                  }


                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      final inAnimation = Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOut,
                      ));

                      final fadeAnimation = CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      );

                      return SlideTransition(
                        position: inAnimation,
                        child: FadeTransition(
                          opacity: fadeAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      key: ValueKey(vehicleController.selectedCalendarType.value),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: calendarToShow,
                    ),
                  );
                }),

                const SizedBox(height: 20),
                Obx(() {
                  if (bookingController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  Widget calendarToShow;
                  switch (vehicleController.selectedCalendarType.value) {
                    case 'Tata Setup':
                      calendarToShow = AvailabilityInfoForTata();
                      break;
                    case 'Barat on wheels':
                      calendarToShow = AvailabilityInfoForBarat();
                      break;
                    case 'Eicher':
                      calendarToShow = AvailabilityInfoForEicher();
                      break;
                    default:
                      calendarToShow = const SizedBox(); // Empty fallback
                  }


                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      final inAnimation = Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOut,
                      ));

                      final fadeAnimation = CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      );

                      return SlideTransition(
                        position: inAnimation,
                        child: FadeTransition(
                          opacity: fadeAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      key: ValueKey(vehicleController.selectedCalendarType.value),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: calendarToShow,
                    ),
                  );
                }),
                // AllVehicleWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
