import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konsuldoc/core/router/auth_router.gr.dart';
import 'package:konsuldoc/core/theme/styles.dart';
import 'package:konsuldoc/presentations/controllers/auth_controller.dart';
import 'package:konsuldoc/presentations/widgets/custom_elevated_button.dart';
import 'package:konsuldoc/presentations/widgets/custom_text_field.dart';

@RoutePage()
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Buat Akun', style: welcomeTextStyle),
                const SizedBox(height: 8),
                const Text('Kami di sini untuk membantu Anda.',
                    style: messageTextStyle),
                const SizedBox(height: 32),
                CustomTextField(
                  controller: nameController,
                  icon: Icons.person_outline,
                  hintText: 'Nama',
                  fillColor: inputFieldFillColor,
                  hintStyle: inputFieldHintStyle,
                  borderSide: inputFieldBorderSide,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: emailController,
                  icon: Icons.mail_outline,
                  hintText: 'Email',
                  fillColor: inputFieldFillColor,
                  hintStyle: inputFieldHintStyle,
                  borderSide: inputFieldBorderSide,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: passwordController,
                  obscureText: true,
                  icon: Icons.lock_outline,
                  hintText: 'Password',
                  fillColor: inputFieldFillColor,
                  hintStyle: inputFieldHintStyle,
                  borderSide: inputFieldBorderSide,
                ),
                const SizedBox(height: 32),
                CustomElevatedButton(
                  onPressed: signUp,
                  text: 'Buat Akun',
                  width: double.infinity,
                  height: 40,
                ),
                const SizedBox(height: 32),
                
                
                
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'Sudah punya akun? '),
                      TextSpan(
                        text: 'Masuk',
                        style: linkTextStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.pushRoute(const SignInRoute());
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp() {
    ref.read(authControllerProvider).signUp(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
        );
  }
}
