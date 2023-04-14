import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/loading_page.dart';
import 'package:todo/common/rounded_primary_button.dart';
import 'package:todo/constants/ui_constants.dart';
import 'package:todo/features/authentication/controller/auth_controller.dart';
import 'package:todo/features/authentication/view/signup_view.dart';
import 'package:todo/common/custom_text_input_field.dart';
import 'package:todo/theme/theme.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});
  static route() => MaterialPageRoute(builder: (context) => const LoginView());

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appBar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onSignUp() {
    ref.read(authControllerProvider.notifier).login(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return isLoading
        ? const LoadingPage()
        : Scaffold(
            appBar: appBar,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Column(
                    children: [
                      CustomTextInputField(
                        controller: emailController,
                        hintText: "Email",
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomTextInputField(
                        controller: passwordController,
                        hintText: "Password",
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      RoundedPrimaryButton(
                        text: "Login",
                        backgroundColor: Pallete.buttonBackgroundColor,
                        textColor: Pallete.buttonTextColor,
                        onTap: () => {
                          _onSignUp(),
                        },
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Don't have an Account? ",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Pallete.blackColor,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushAndRemoveUntil(context,
                                      SignUpView.route(), (route) => false);
                                },
                              text: "Signup",
                              style: const TextStyle(
                                color: Pallete.blueColor,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
