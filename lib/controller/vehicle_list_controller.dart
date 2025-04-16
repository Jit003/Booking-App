import 'package:bhadranee_employee/api/api_services.dart';
import 'package:bhadranee_employee/api/model/vehicle_list_model.dart';
import 'package:get/get.dart';
import 'package:bhadranee_employee/api/model/vehicle_list_category_model.dart';

class VehicleController extends GetxController {

  var isLoading = false.obs;
  var isLoadingforCategory = false.obs;
  var vehicleList = <Data>[].obs;
  var selectedCategory = ''.obs;
  var vehicleListforCat = <Categories>[].obs;
  var selectedCalendarType = ''.obs;


  @override
  void onInit(){
    fetchVehicles();
    fetchVehiclesByCategory('Tata Setup');
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

  /// Fetch vehicles by category (e.g. 'Barat on wheels')
  void fetchVehiclesByCategory(String category) async {
    try {
      isLoadingforCategory(true);
      selectedCategory.value = category;
      selectedCalendarType.value = category;

      final response = await ApiService.fetchVehiclesCategories(category: category);
      if (response.categories != null) {
        vehicleListforCat.assignAll(response.categories!);
        print("Fetched data ${response.categories!.length} vehicles for category: $category");
      } else {
        vehicleList.clear();
      }
    } catch (e) {
      print("Error fetching category vehicles: $e");
      vehicleList.clear();
    } finally {
      isLoadingforCategory(false);
    }
  }


}
