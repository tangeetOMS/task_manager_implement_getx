import 'package:get/get.dart';
import 'package:task_manager_implement_getx/data/services/network_caller.dart';
import 'package:task_manager_implement_getx/data/utils/urls.dart';

class VerifyEmailController extends GetxController {
  bool _getForgotPasswordVerifyEmailInProgress = false;
  bool get getForgotPasswordVerifyEmailInProgress => _getForgotPasswordVerifyEmailInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> forgotEmailPassword(String email) async {
    bool isSuccess = false;
    _getForgotPasswordVerifyEmailInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.forgotVerifyEmailUrl(email));
    if (response.isSuccess) {
      email;
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getForgotPasswordVerifyEmailInProgress = false;
    update();
    return isSuccess;
  }
}
