import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_implement_getx/ui/controllers/login_controllers/sign_in_controller.dart';
import 'package:task_manager_implement_getx/ui/screen/login_screen/sign_up_screen.dart';
import '../../utils/app_colors.dart';
import '../../widgets/centered_circular_progress_indicator.dart';
import '../../widgets/screen_background.dart';
import '../../widgets/snack_bar_message.dart';
import '../bottom_nav_task_screen/main_bottom_nav_screen.dart';
import '../forgot_password_screen/forgot_password_verify_email_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const name = 'sign_in_screen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignInController _signInController = Get.find<SignInController>();
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
                    'Get Started With',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your valid password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GetBuilder<SignInController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.signInProgress == false,
                        replacement: const CenteredCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: _onTapSignInButton,
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    }
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.toNamed(ForgotPasswordVerifyEmailScreen.name);
                          },
                          child: const Text('Forgot Password?'),
                        ),
                        _buildSignUpSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn() async {
    final bool isSuccess = await _signInController.signIn(
        _emailTEController.text.trim(), _passwordTEController.text);
    if (isSuccess) {
      Navigator.pushReplacementNamed(context, MainBottomNavScreen.name);
    } else {
      showSnackBarMessage(context, _signInController.errorMessage!);
    }
  }

  Widget _buildSignUpSection() {
    return RichText(
      text: TextSpan(
        text: "Don't have an account?",
        style: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(
            text: 'Sign up',
            style: const TextStyle(
              color: AppColors.themeColors,
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed(SignUpScreen.name);
              },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
