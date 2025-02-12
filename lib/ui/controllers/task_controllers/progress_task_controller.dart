import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_manager_implement_getx/data/models/task_list_by_status_model.dart';
import 'package:task_manager_implement_getx/data/models/task_list_model.dart';
import 'package:task_manager_implement_getx/data/services/network_caller.dart';
import 'package:task_manager_implement_getx/data/utils/urls.dart';

class ProgressTaskController extends GetxController{
    bool _getTaskListInProgress = false;
    bool get getTaskListInProgress => _getTaskListInProgress;

    String? _errorMessage;
    String? get errorMessage => _errorMessage;

    TaskListByStatusModel? _taskListByStatusModel;
    List<TaskListModel> get taskList => _taskListByStatusModel?.taskList ?? [];


  Future<bool> getProgressTaskList() async {
    bool isSuccess = false;
    _getTaskListInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskListByStatusUrl('Progress'));
    if (response.isSuccess) {
      _taskListByStatusModel =
          TaskListByStatusModel.fromJson(response.responseData!);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getTaskListInProgress = false;
    update();
    return isSuccess;
  }

}