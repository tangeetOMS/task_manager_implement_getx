import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:task_manager_implement_getx/ui/controllers/task_controllers/add_new_task_controller.dart';
import 'package:task_manager_implement_getx/ui/controllers/task_controllers/cancelled_task_controller.dart';
import 'package:task_manager_implement_getx/ui/controllers/task_controllers/completed_task_controller.dart';
import 'package:task_manager_implement_getx/ui/controllers/task_controllers/main_bottom_nav_task_controller.dart';
import 'package:task_manager_implement_getx/ui/controllers/task_controllers/new_task_controller.dart';
import 'package:task_manager_implement_getx/ui/controllers/task_controllers/progress_task_controller.dart';
import 'package:task_manager_implement_getx/ui/controllers/forgot_controllers/reset_password_controller.dart';
import 'package:task_manager_implement_getx/ui/controllers/login_controllers/sign_in_controller.dart';
import 'package:task_manager_implement_getx/ui/controllers/login_controllers/sign_up_controller.dart';
import 'package:task_manager_implement_getx/ui/controllers/update_profile_controller.dart';
import 'package:task_manager_implement_getx/ui/controllers/forgot_controllers/verify_email_controller.dart';
import 'package:task_manager_implement_getx/ui/controllers/forgot_controllers/verify_email_otp_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>SignInController());
    Get.put(SignUpController());
    Get.put(ResetPasswordController());
    Get.put(NewTaskController());
    Get.put(ProgressTaskController());
    Get.put(CompletedTaskController());
    Get.put(CancelledTaskController());
    Get.put(VerifyEmailController());
    Get.put(VerifyEmailOtpController());
    Get.put(AddNewTaskController());
    Get.put(UpdateProfileController());
    Get.put(MainBottomNavTaskController());
  }
}