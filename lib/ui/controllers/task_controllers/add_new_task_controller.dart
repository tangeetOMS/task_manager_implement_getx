import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_manager_implement_getx/data/services/network_caller.dart';
import 'package:task_manager_implement_getx/data/utils/urls.dart';

class AddNewTaskController extends GetxController{
    bool _addNewTaskInProgress = false;
    bool get addNewTaskInProgress => _addNewTaskInProgress;

    String? _errorMessage;
    String? get errorMessage => _errorMessage;

  Future<bool> createNewTask(String title,String description) async {
    bool isSuccess = false;
    _addNewTaskInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTaskUrl, body: requestBody);
    if(response.isSuccess){
      isSuccess = true;
      _errorMessage = null;
    }
    else{
     _errorMessage = response.errorMessage;
    }
    _addNewTaskInProgress = false;
    update();
    return isSuccess;
  }
}