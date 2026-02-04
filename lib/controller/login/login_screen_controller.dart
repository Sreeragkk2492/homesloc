import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:homesloc/apis/login/login_api.dart';

class LoginScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isAuthFailed = false.obs;

  RxString message = "".obs;

  // Registration Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final registrationNumberController = TextEditingController();

  // Registration State
  RxBool isRegisterLoading = false.obs;
  RxString registerMessage = "".obs;
  RxBool isRegisterSuccess = false.obs;

  // Default values for registration
  String userType = "Regular";
  String profileImageUrl = ""; // Handle image selection separately if needed

  Future<void> login() async {
    isLoading.value = true;
    isAuthFailed.value = false;
    message.value = "";

    // print("Login Button Pressed");
    // print("Username from Controller: '${usernameController.text}'");
    // print("Password from Controller: '${passwordController.text}'");

    try {
      await loginApi(
        username: usernameController.text,
        password: passwordController.text,
      );
    } catch (e) {
      isAuthFailed.value = true;
      message.value = e.toString().replaceAll("Exception: ", "");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    isRegisterLoading.value = true;
    registerMessage.value = "";
    isRegisterSuccess.value = false;

    try {
      await registerUser(
        username: nameController.text, // Using name as username
        password: passwordController.text,
        name: nameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        userType: userType,
        registrationNumber: registrationNumberController.text,
        profileImageUrl: profileImageUrl,
      );

      registerMessage.value = "Registration Successful";
      isRegisterSuccess.value = true;

      // Optional: Clear controllers on success
      clearRegistrationControllers();
    } catch (e) {
      registerMessage.value = e.toString().replaceAll("Exception: ", "");
      isRegisterSuccess.value = false;
    } finally {
      isRegisterLoading.value = false;
    }
  }

  void clearRegistrationControllers() {
    usernameController.clear();
    passwordController.clear();
    nameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    registrationNumberController.clear();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    registrationNumberController.dispose();
    super.onClose();
  }
}
