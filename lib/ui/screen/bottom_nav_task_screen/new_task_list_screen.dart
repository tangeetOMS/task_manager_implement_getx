import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_implement_getx/data/models/task_list_model.dart';
import 'package:task_manager_implement_getx/ui/controllers/task_controllers/new_task_controller.dart';
import 'package:task_manager_implement_getx/ui/screen/add_task_screen/add_new_task_screen.dart';
import '../../../data/models/task_count_by_status_model.dart';
import '../../../data/models/task_count_model.dart';
import '../../widgets/centered_circular_progress_indicator.dart';
import '../../widgets/screen_background.dart';
import '../../widgets/snack_bar_message.dart';
import '../../widgets/task_item_widget.dart';
import '../../widgets/task_status_summary_counter_widget.dart';
import '../../widgets/tm_app_bar.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  TaskCountByStatusModel? taskCountByStatusModel;
  final NewTaskController _newTaskController = Get.find<NewTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _fetchAllData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTasksSummaryByStatus(_newTaskController.taskByStatusList),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GetBuilder<NewTaskController>(builder: (controller) {
                  return Visibility(
                    visible: controller.getNewTaskListInProgress == false,
                    replacement: const CenteredCircularProgressIndicator(),
                    child: _buildTaskListView(
                      controller.taskList,
                    ),
                  );
                }),
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

  Widget _buildTasksSummaryByStatus(List<TaskCountModel> taskByStatusList) {
    return GetBuilder<NewTaskController>(builder: (controller) {
      return Visibility(
        visible: controller.getTaskCountByStatusInProgress == false,
        replacement: const CenteredCircularProgressIndicator(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: taskByStatusList.length,
              itemBuilder: (context, index) {
                final TaskCountModel model = taskByStatusList[index];
                return TaskStatusSummaryCounterWidget(
                  title: model.sId ?? '',
                  count: model.sum.toString(),
                );
              },
            ),
          ),
        ),
      );
    });
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
      await _getTaskCountByStatus();
      await _getNewTaskList();
    } catch (e) {
      showSnackBarMessage(context, e.toString());
    }
  }

  Future<void> _deleteTask(String id) async {
    final bool isSuccess = await _newTaskController.deleteTask(id);
    if (isSuccess) {
      _fetchAllData();
      showSnackBarMessage(context, 'task delete successful');
    } else {
      showSnackBarMessage(context, _newTaskController.errorMessage!);
    }
  }

  Future<void> _updateTaskStatus(String taskId, String newStatus) async {
    final bool isSuccess =
        await _newTaskController.updateTaskStatus(taskId, newStatus);
    if (isSuccess) {
      _fetchAllData();
      showSnackBarMessage(context, 'task status updated successfully');
    } else {
      showSnackBarMessage(context, _newTaskController.errorMessage!);
    }
  }

  Future<void> _getTaskCountByStatus() async {
    final bool isSuccess = await _newTaskController.getTaskCountByStatus();
    if (!isSuccess) {
      showSnackBarMessage(context, _newTaskController.errorMessage!);
    }
  }

  Future<void> _getNewTaskList() async {
    final bool isSuccess = await _newTaskController.getNewTaskList();

    ///isSuccess == false
    if (!isSuccess) {
      showSnackBarMessage(context, _newTaskController.errorMessage!);
    }
  }
}
