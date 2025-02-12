import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utils/urls.dart';

class SignUpController extends GetxController{

 bool _signUpInProgress = false;
  bool get signUpInProgress => _signUpInProgress;

 String? _errorMessage;
 String? get errorMessage => _errorMessage;

  Future<bool> registerUser(String email,String firstName,String lastName,String mobile,String password) async {
    bool isSuccess = false;
    _signUpInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": '',
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registrationUrl, body: requestBody);
    _signUpInProgress=false;
    update();
    if(response.isSuccess){
      isSuccess = true;
      _errorMessage = null;
    }
    else{
     _errorMessage = response.errorMessage;
    }
    return isSuccess;
  }
}