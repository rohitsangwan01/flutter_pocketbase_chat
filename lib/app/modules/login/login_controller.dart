import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:pocketbase_chat/app/services/pocketbase_service.dart';

import '../../routes/app_pages.dart';

class LoginController extends GetxController {
  Future<String?> onLogin(LoginData loginData) async {
    try {
      String email = loginData.name;
      String password = loginData.password;
      await PocketbaseService.to.login(email, password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> onSignup(SignupData signUpData) async {
    try {
      String? email = signUpData.name;
      String? password = signUpData.password;
      String? name = signUpData.additionalSignupData?["name"];
      if (email == null || password == null || name == null) {
        throw Exception("Invalid data");
      }
      await PocketbaseService.to.signUp(name, email, password);
      await PocketbaseService.to.login(email, password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  void onLoginComplete() {
    Get.offAllNamed(Routes.DASHBOARD);
  }
}
