import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.maybeSizeOf(context)!.height,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Hi, Selamat Datang!'),
              const SizedBox(height: 8),
              const Text('Kami harap Anda baik-baik saja.'),
              const SizedBox(height: 32),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail_outline),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
              ),
              const SizedBox(height: 39),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 76, 105, 1),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(229, 40),
                ),
                child: const Text('Masuk'),
              ),
              const Divider(indent: BorderSide.strokeAlignCenter),
              const SizedBox(height: 19),
              OutlinedButton(onPressed: () {}, child: const Text(''))
            ],
          ),
        ),
      ),
    ));
  }
}
