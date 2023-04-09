import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/loading_page.dart';
import 'package:todo/common/rounded_primary_button.dart';
import 'package:todo/constants/ui_constants.dart';
import 'package:todo/features/authentication/controller/auth_controller.dart';
import 'package:todo/features/authentication/view/login_view.dart';
import 'package:todo/features/authentication/widgets/auth_field.dart';
import 'package:todo/theme/theme.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpView());

  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appBar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
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
                      AuthField(
                        controller: nameController,
                        hintText: "Name",
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      AuthField(
                        controller: emailController,
                        hintText: "Email",
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      AuthField(
                        controller: passwordController,
                        hintText: "Password",
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      RoundedPrimaryButton(
                        text: "SignUp",
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
                          text: "Already have an Account? ",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Pallete.blackColor,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushAndRemoveUntil(context,
                                      LoginView.route(), (route) => false);
                                },
                              text: "Login",
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
