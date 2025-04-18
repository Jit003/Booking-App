import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class TokenHelper {
  static Future<String?> getToken() async {
    final storage = GetStorage();
    final customToken = storage.read('customToken');
    if (customToken != null && customToken.toString().isNotEmpty) {
      print("✅ Using Custom Token: $customToken");
      return customToken;
    }

    // If not logged in via custom backend, fallback to Firebase
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? idToken = await user.getIdToken(true);
      print("⚠️ Using Firebase Token: $idToken");
      return idToken;
    }

    return null;
  }
}
