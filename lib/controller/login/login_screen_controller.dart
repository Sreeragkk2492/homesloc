import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:homesloc/apis/login/login_api.dart';
import 'package:homesloc/screens/auth/otp_varification.dart';
import 'package:homesloc/screens/auth/sign_up.dart';

class LoginScreenController extends GetxController {
  // Note: Import OtpVarification at top or use full path if needed,
  // but better to add import in file header.
  // For now I will assume imports are handled or I will add it.

  RxBool isLoading = false.obs;
  RxBool isAuthFailed = false.obs;

  RxString message = "".obs;

  // Registration Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final registrationNumberController = TextEditingController();
  final signupFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();

  // Registration State
  RxBool isRegisterLoading = false.obs;
  RxString registerMessage = "".obs;
  RxBool isRegisterSuccess = false.obs;
  RxBool isTermsAccepted = false.obs;

  // OTP State
  RxBool isOtpLoading = false.obs;
  RxBool isEmailVerified = false.obs;

  // Default values for registration
  String userType = "Regular";
  String profileImageUrl = ""; // Handle image selection separately if needed

  // Additional new fields defaults
  List<Map<String, dynamic>> services = [];
  num commission = 0;
  String verificationToken = "string"; // Placeholder as requested

  // Country Code State
  RxString countryCode = "+91".obs;
  final List<String> countryCodes = ["+91", "+1", "+44", "+971", "+880", "+62"];

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

  Future<void> sendOtp() async {
    if (emailController.text.isEmpty) {
      Get.snackbar("Error", "Please enter email first");
      return;
    }
    isOtpLoading.value = true;
    try {
      String token = await sendVerificationEmail(email: emailController.text);
      verificationToken = token;
      // Navigate to OTP screen
      Get.to(() => const OtpVarification());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isOtpLoading.value = false;
    }
  }

  Future<void> verifyOtp(String otp) async {
    isOtpLoading.value = true;
    try {
      // Assuming verifyEmailOtp also returns the final token needed for registration
      String token =
          await verifyEmailOtp(verificationToken: verificationToken, otp: otp);

      // Update the token with the one returned from verification if needed
      // If the API returns the same token or a new confirmed one, we use it.
      if (token.isNotEmpty) {
        verificationToken = token;
      }

      isEmailVerified.value = true;
      Get.snackbar("Success", "Email Verified Successfully");
      Get.offAll(() => SignUp()); // Navigate to Sign Up
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isOtpLoading.value = false;
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
        services: services,
        commission: commission,
        verificationToken: verificationToken,
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
    confirmPasswordController.clear();
    nameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    registrationNumberController.clear();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    registrationNumberController.dispose();
    super.onClose();
  }
}
