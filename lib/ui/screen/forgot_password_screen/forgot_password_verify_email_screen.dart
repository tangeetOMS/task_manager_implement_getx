import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_implement_getx/ui/controllers/forgot_controllers/verify_email_controller.dart';
import 'package:task_manager_implement_getx/ui/screen/forgot_password_screen/forgot_password_verify_otp_screen.dart';
import '../../utils/app_colors.dart';
import '../../widgets/centered_circular_progress_indicator.dart';
import '../../widgets/screen_background.dart';
import '../../widgets/snack_bar_message.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({
    super.key,
  });

  static const name = 'forgot_password_verify_email';

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() =>
      _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState
    extends State<ForgotPasswordVerifyEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VerifyEmailController _verifyEmailController =
      Get.find<VerifyEmailController>();

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
                    'Your Email Address',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'A 6 digits of OTP will be sent to your email address',
                    style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
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
                        return 'Enter your email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GetBuilder<VerifyEmailController>(builder: (controller) {
                    return Visibility(
                      visible:
                          controller.getForgotPasswordVerifyEmailInProgress ==
                              false,
                      replacement: const CenteredCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () {
                          _onTapForgotEmailButton(context);
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    );
                  }),
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

  void _onTapForgotEmailButton(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _forgotEmailPassword(context);
    }
  }

  Future<void> _forgotEmailPassword(BuildContext context) async {
    final bool isSuccess = await _verifyEmailController
        .forgotEmailPassword(_emailTEController.text);
    if (isSuccess) {
      showSnackBarMessage(context, 'Check your email account');
      Get.to(
        () => ForgotPasswordVerifyOtpScreen(email: _emailTEController.text),
      );
    } else {
      showSnackBarMessage(context, _verifyEmailController.errorMessage!);
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
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.back();
              },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
