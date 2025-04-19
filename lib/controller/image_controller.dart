import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageController extends GetxController {
  final box = GetStorage();
  RxString profileImagePath = ''.obs;

  @override
  void onInit() {
    profileImagePath.value = box.read('profile_image') ?? '';
    super.onInit();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery); // or camera

    if (picked != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = picked.name;
      final savedImage = await File(picked.path).copy('${appDir.path}/$fileName');

      profileImagePath.value = savedImage.path;
      box.write('profile_image', savedImage.path);
    }
  }
}
