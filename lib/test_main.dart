import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konsuldoc/constants/constants.dart';
import 'package:konsuldoc/presentations/pages/onboarding_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.supabaseKey,
  );

  runApp(const ProviderScope(child: TestMainApp()));
}

class TestMainApp extends ConsumerWidget {
  const TestMainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      title: 'KonsulDoc',
      home: OnBoardingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
