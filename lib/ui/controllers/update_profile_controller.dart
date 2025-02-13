import 'dart:convert';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_manager_implement_getx/data/services/network_caller.dart';
import 'package:task_manager_implement_getx/data/utils/urls.dart';
import 'package:flutter/services.dart';

class UpdateProfileController extends GetxController{
    bool _getUpdateProfileInProgress = false;
    bool get getUpdateProfileInProgress => _getUpdateProfileInProgress;

    String? _errorMessage;
    String? get errorMessage => _errorMessage;

    Future<bool> updateProfile(
        String email,
        String firstName,
        String lastName,
        String mobile,
        Uint8List? pickedImage,
        String? password,
        ) async {
      bool isSuccess = false;
      _getUpdateProfileInProgress = true;
      update();
      Map<String, dynamic> requestBody = {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
      };

      if (pickedImage != null) {
        List<int> imageBytes = pickedImage;
        requestBody['photo'] = base64Encode(imageBytes);
      }

      if (password != null) {
        requestBody['password'] = password;
      }

      final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.updateProfileUrl,
        body: requestBody,
      );
      if (response.isSuccess) {
        isSuccess = true;
        _errorMessage = null;
      } else {
        _errorMessage = response.errorMessage;
      }
      _getUpdateProfileInProgress = false;
      update();
      return isSuccess;
    }
}
