import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:konsuldoc/core/constants/hive_constants.dart';
import 'package:konsuldoc/core/constants/supabase_constants.dart';
import 'package:konsuldoc/core/theme/theme.dart';
import 'package:konsuldoc/presentations/providers/notification_service_provider.dart';
import 'package:konsuldoc/presentations/providers/router_provider.dart';
import 'package:konsuldoc/presentations/providers/theme_state_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'id_ID';
  await initializeDateFormatting('id_ID');

  await Supabase.initialize(
    url: SupabaseConstants.url,
    anonKey: SupabaseConstants.anonKey,
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await Hive.openBox(HiveConstants.box);

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    ref.read(notificationServiceProvider.notifier).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const theme = MaterialTheme();

    return MaterialApp.router(
      title: 'KonsulDoc',
      themeMode: ref.watch(themeStateProvider),
      theme: theme.light(),
      darkTheme: theme.dark(),
      builder: BotToastInit(),
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(routerProvider).config(
            navigatorObservers: () => [
              BotToastNavigatorObserver(),
            ],
          ),
    );
  }
}
