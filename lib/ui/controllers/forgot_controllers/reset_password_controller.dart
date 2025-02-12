import 'package:get/get.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utils/urls.dart';

class ResetPasswordController extends GetxController {
  bool _resetPasswordInProgress = false;
  bool get resetPasswordInProgress => _resetPasswordInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    bool isSuccess = false;
    _resetPasswordInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": newPassword,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(url: Urls.resetPasswordUrl, body: requestBody);

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _resetPasswordInProgress = false;
    update();
    return isSuccess;
  }
}
