import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_manager_implement_getx/data/models/task_list_by_status_model.dart';
import 'package:task_manager_implement_getx/data/models/task_list_model.dart';
import 'package:task_manager_implement_getx/data/services/network_caller.dart';
import 'package:task_manager_implement_getx/data/utils/urls.dart';

class CompletedTaskController extends GetxController{
  bool _getCompletedTaskListInProgress = false;
  bool get getCompletedTaskListInProgress => _getCompletedTaskListInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  TaskListByStatusModel? _taskListByStatusModel;
  List<TaskListModel> get taskList => _taskListByStatusModel?.taskList ?? [];

  Future<bool> getCompletedTaskList() async {
    bool isSuccess = false;
    _getCompletedTaskListInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskListByStatusUrl('Completed'));
    if (response.isSuccess) {
      _taskListByStatusModel =
          TaskListByStatusModel.fromJson(response.responseData!);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getCompletedTaskListInProgress = false;
    update();
    return isSuccess;
  }
}