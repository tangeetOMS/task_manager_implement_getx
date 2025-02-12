import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_manager_implement_getx/data/models/task_list_by_status_model.dart';
import 'package:task_manager_implement_getx/data/models/task_list_model.dart';
import 'package:task_manager_implement_getx/data/services/network_caller.dart';
import 'package:task_manager_implement_getx/data/utils/urls.dart';

class CancelledTaskController extends GetxController{
  bool _getCancelledTaskListInProgress = false;
  bool get getCancelledTaskListInProgress => _getCancelledTaskListInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  TaskListByStatusModel? _taskListByStatusModel;
  List<TaskListModel> get taskList => _taskListByStatusModel?.taskList ?? [];

  Future<bool> getCancelledTaskList() async {
    bool isSuccess = false;
    _getCancelledTaskListInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskListByStatusUrl('Cancelled'));
    if (response.isSuccess) {
      _taskListByStatusModel =
          TaskListByStatusModel.fromJson(response.responseData!);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getCancelledTaskListInProgress = false;
    update();
    return isSuccess;
  }

}