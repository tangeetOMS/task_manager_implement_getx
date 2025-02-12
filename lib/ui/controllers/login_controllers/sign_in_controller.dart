import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utils/urls.dart';
import '../auth_controller.dart';

class SignInController extends GetxController{

 bool _signInProgress = false;
 bool get signInProgress => _signInProgress;

 String? _errorMessage;
 String? get errorMessage => _errorMessage;


  Future<bool> signIn(String email, String password)async{
    bool isSuccess = false;
    _signInProgress =true;
    update();
    Map<String,dynamic> requestBody ={
      "email": email,
      "password": password,
    };
    final NetworkResponse response= await NetworkCaller.postRequest(url: Urls.loginUrl,body: requestBody);

    if(response.isSuccess){
      String token = response.responseData!['token'];
      UserModel userModel = UserModel.fromJson(response.responseData!['data']);
      await AuthController.saveUserData(token, userModel);
      isSuccess = true;
      _errorMessage = null;
    }
    else{
      if(response.statusCode == 401){
        _errorMessage = 'UserName/Password is incorrect';
      }
      else{
        _errorMessage = response.errorMessage;
      }
    }
    _signInProgress=false;
    update();
    return isSuccess;
  }
}