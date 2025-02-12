import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_implement_getx/ui/controllers/forgot_controllers/reset_password_controller.dart';
import 'package:task_manager_implement_getx/ui/screen/login_screen/sign_in_screen.dart';
import '../../utils/app_colors.dart';
import '../../widgets/centered_circular_progress_indicator.dart';
import '../../widgets/screen_background.dart';
import '../../widgets/snack_bar_message.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, this.email, this.otp});
  static const name = '/forgot_password/reset_password';
  final String? email;
  final String? otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEController=TextEditingController();
  final TextEditingController _confirmPasswordTEController=TextEditingController();
  final GlobalKey <FormState> _formKey=GlobalKey<FormState>();
  final ResetPasswordController _resetPasswordController = Get.find<ResetPasswordController>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 90,
                  ),
                  Text(
                    'Set Password',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Minimum length of password should be more than 8 letters.',
                    style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),

                  ),
                  const SizedBox(
                    height: 26,
                  ),
                    TextFormField(
                      controller: _newPasswordTEController,
                      decoration: const InputDecoration(
                        hintText: 'New Password',
                      ),
                      validator: (String? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Enter your new password';
                        }
                        return null;
                      },
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    decoration: const InputDecoration(
                      hintText: 'Confirm New Password',
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your confirm password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GetBuilder<ResetPasswordController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.resetPasswordInProgress == false,
                        replacement: const CenteredCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: () {
                            _onTapResetButton();
                          },
                          child: const Text('Confirm'),
                        ),
                      );
                    }
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: _buildSignInSection(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapResetButton(){
    if(_formKey.currentState!.validate()){
      _resetPassword();
    }
  }

  Future<void> _resetPassword()async{
    if(_newPasswordTEController.text == _confirmPasswordTEController.text){
      final bool isSuccess = await _resetPasswordController.resetPassword(
        email: widget.email.toString(),
        otp: widget.otp.toString(),
        newPassword: _confirmPasswordTEController.text,
      );
      if(isSuccess){
        Get.offAllNamed(SignInScreen.name);
        showSnackBarMessage(context, 'New password added !');
      }
      else{
        showSnackBarMessage(context, 'invalid password ! Try again');
      }
    }else{
      showSnackBarMessage(context, " don't match this password");
    }
  }
  
  Widget _buildSignInSection() {
    return RichText(
      text: TextSpan(
        text: "Have an account?",
        style: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(
              color: AppColors.themeColors,
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {
              Get.offNamedUntil(SignInScreen.name, (route) => false);
            },
          )
        ],
      ),
    );
  }
  @override
  void dispose() {
    _newPasswordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
