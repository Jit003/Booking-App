import 'package:bhadranee_employee/api/api_services.dart';
import 'package:bhadranee_employee/api/model/vehicle_list_model.dart';
import 'package:get/get.dart';

class VehicleController extends GetxController {

  var isLoading = false.obs;
  var vehicleList = <Data>[].obs;

  @override
  void onInit(){
    fetchVehicles();
    super.onInit();
  }


  void fetchVehicles() async {
    try {
      isLoading(true);
      final response = await ApiService.fetchVehicles();
      if (response.data != null) {
        vehicleList.assignAll(response.data!);
      }
    } catch (e) {
      print("Error fetching vehicles: $e");
    } finally {
      isLoading(false);
    }
  }

}
