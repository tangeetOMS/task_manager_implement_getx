import 'package:get/get_state_manager/get_state_manager.dart';

class MainBottomNavTaskController extends GetxController{
  int selectedIndex = 0;

  void setIndex(int index){
    selectedIndex = index;
    update();
  }
}