import 'package:get/get.dart';
import 'package:task_manager_implement_getx/data/services/network_caller.dart';
import 'package:task_manager_implement_getx/data/utils/urls.dart';


class VerifyEmailOtpController extends GetxController{
  bool _getForgotPasswordVerifyOtpInProgress = false;
  bool get getForgotPasswordVerifyOtpInProgress => _getForgotPasswordVerifyOtpInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> forgotEmailPinVerification(String email,String otp) async {
    bool isSuccess = false;
    _getForgotPasswordVerifyOtpInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.forgotVerifyEmailOtpUrl(email,otp));
    if(response.responseData?['status']== 'success'){
      isSuccess = true;
      _errorMessage = null;
    }

    else{
      _errorMessage = response.errorMessage;
    }
    _getForgotPasswordVerifyOtpInProgress = false;
    update();
    return isSuccess;
  }
}