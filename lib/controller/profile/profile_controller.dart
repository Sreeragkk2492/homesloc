import 'package:get/get.dart';
import 'package:homesloc/apis/profile/profile_service.dart';
import 'package:homesloc/models/profile/user_profile_model.dart';

class ProfileController extends GetxController {
  final ProfileService _profileService = ProfileService();

  final isLoading = false.obs;
  final Rx<UserProfileModel?> userProfile = Rx<UserProfileModel?>(null);
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch profile automatically when the controller is spun up
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final profile = await _profileService.getUserProfile();
      if (profile != null) {
        userProfile.value = profile;
      } else {
        errorMessage.value = 'Failed to load user profile';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred while fetching profile: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshProfile() async {
    await fetchUserProfile();
  }

  Future<bool> updateProfile(Map<String, dynamic> updateData) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final success = await _profileService.updateUserProfile(updateData);
      if (success) {
        // Refresh local memory silently to reflect the new data immediately
        await fetchUserProfile();
        return true;
      } else {
        errorMessage.value = 'Failed to update user profile';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred while updating profile: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
