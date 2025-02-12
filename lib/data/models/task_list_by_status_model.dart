import 'task_list_model.dart';

/// number of model 2ta SOLID = ==> S -> Singletone
class TaskListByStatusModel { /// overall
  String? status;
  List<TaskListModel>? taskList;

  TaskListByStatusModel({this.status, this.taskList});

  TaskListByStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskListModel>[];
      json['data'].forEach((v) {
        taskList!.add(TaskListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.taskList != null) {
      data['data'] = this.taskList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

