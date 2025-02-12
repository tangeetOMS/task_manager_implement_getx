import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_implement_getx/data/models/task_list_model.dart';
import 'package:task_manager_implement_getx/ui/controllers/task_controllers/progress_task_controller.dart';
import 'package:task_manager_implement_getx/ui/screen/add_task_screen/add_new_task_screen.dart';
import '../../../data/models/task_count_by_status_model.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utils/urls.dart';
import '../../widgets/centered_circular_progress_indicator.dart';
import '../../widgets/screen_background.dart';
import '../../widgets/snack_bar_message.dart';
import '../../widgets/task_item_widget.dart';
import '../../widgets/tm_app_bar.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  TaskCountByStatusModel? taskCountByStatusModel;
  final ProgressTaskController _progressTaskController = Get.find<ProgressTaskController>();

  @override
  void initState() {
    super.initState();
    _fetchAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
             // _buildTaskSummaryStatus(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GetBuilder<ProgressTaskController>(
                  builder: (controller) {
                    return Visibility(
                        visible: controller.getTaskListInProgress == false,
                        replacement: const CenteredCircularProgressIndicator(),
                        child: _buildTaskListView(controller.taskList),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AddNewTaskScreen.name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskListView(List<TaskListModel> taskList) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return TaskItems(
          taskModel: taskList[index],
          onDeleteTask: _deleteTask,
          onUpdateTaskStatus: _updateTaskStatus,
        );
      },
    );
  }

  Future<void> _fetchAllData() async {
    try {
      await _getProgressTaskList();
    } catch (e) {
      showSnackBarMessage(context, e.toString());
    }
  }

  Future<void> _deleteTask(String id) async {
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.deleteTaskUrl(id));
    if (response.isSuccess) {
      _fetchAllData();
      showSnackBarMessage(context, 'task delete successful');
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
  }

  Future<void> _updateTaskStatus(String taskId, String newStatus) async {
    final String url = Urls.updateTaskUrl(taskId, newStatus);
    final NetworkResponse response = await NetworkCaller.getRequest(url: url);
    if (response.isSuccess) {
      _fetchAllData();
      showSnackBarMessage(context, 'task status updated successfully');
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
  }


  Future<void> _getProgressTaskList() async {
   final bool isSuccess = await _progressTaskController.getProgressTaskList();
    if (!isSuccess) {
      showSnackBarMessage(context, _progressTaskController.errorMessage!);
    }
  }
}

