import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_implement_getx/ui/controllers/task_controllers/main_bottom_nav_task_controller.dart';
import 'package:task_manager_implement_getx/ui/screen/bottom_nav_task_screen/progress_task_list_screen.dart';
import 'cancelled_task_list_screen.dart';
import 'completed_task_list_screen.dart';
import 'new_task_list_screen.dart';


class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});
  static const String name='/home';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final List<Widget> _screen= const[
    NewTaskListScreen(),
    ProgressTaskListScreen(),
    CompletedTaskListScreen(),
    CancelledTaskListScreen(),
  ];
  final MainBottomNavTaskController _mainBottomNavTaskController = Get.find<MainBottomNavTaskController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavTaskController>(
      builder: (controller) {
        return Scaffold(
          body: _screen[_mainBottomNavTaskController.selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: _mainBottomNavTaskController.selectedIndex,
            onDestinationSelected: (int index){
              _mainBottomNavTaskController.setIndex(index);
            },
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.new_label_outlined), label: 'New'),
              NavigationDestination(
                  icon: Icon(Icons.refresh), label: 'Progress'),
              NavigationDestination(
                  icon: Icon(Icons.done), label: 'Completed'),
              NavigationDestination(
                  icon: Icon(Icons.cancel_outlined), label: 'Cancelled'),
            ],
          ),
        );
      }
    );
  }
}
