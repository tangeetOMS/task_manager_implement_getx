import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_manager_implement_getx/data/models/task_count_by_status_model.dart';
import 'package:task_manager_implement_getx/data/models/task_count_model.dart';
import 'package:task_manager_implement_getx/data/models/task_list_by_status_model.dart';
import 'package:task_manager_implement_getx/data/models/task_list_model.dart';
import 'package:task_manager_implement_getx/data/services/network_caller.dart';
import 'package:task_manager_implement_getx/data/utils/urls.dart';

class NewTaskController extends GetxController{
  bool _getNewTaskListInProgress = false;
  bool get getNewTaskListInProgress => _getNewTaskListInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  TaskListByStatusModel? _taskListByStatusModel;
  List<TaskListModel> get taskList => _taskListByStatusModel?.taskList ?? [];

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _getNewTaskListInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskListByStatusUrl('New'));
    if (response.isSuccess) {
      _taskListByStatusModel = TaskListByStatusModel.fromJson(response.responseData!);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getNewTaskListInProgress = false;
    update();
    return isSuccess;
  }

  bool _getTaskCountByStatusInProgress = false;
  bool get getTaskCountByStatusInProgress => _getTaskCountByStatusInProgress;

  TaskCountByStatusModel? _taskCountByStatusModel;
  List<TaskCountModel> get taskByStatusList=> _taskCountByStatusModel?.taskByStatusList?? [];

  Future<bool> getTaskCountByStatus() async {
    bool isSuccess = false;
    _getTaskCountByStatusInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskCountByStatusUrl);
    if (response.isSuccess) {
      _taskCountByStatusModel =
          TaskCountByStatusModel.fromJson(response.responseData!);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getTaskCountByStatusInProgress = false;
    update();
    return isSuccess;
  }


  Future<bool> deleteTask(String id) async {
    bool isSuccess = false;
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.deleteTaskUrl(id));
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    return isSuccess;
  }


  Future<bool> updateTaskStatus(String taskId, String newStatus) async {
    bool isSuccess = false;
    final String url = Urls.updateTaskUrl(taskId, newStatus);
    final NetworkResponse response = await NetworkCaller.getRequest(url: url);
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    return isSuccess;
  }
}

