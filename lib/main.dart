import 'package:big_ideal_app/instances/share_preferences_instance.dart';
import 'package:big_ideal_app/pages/ideal_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesInstance.initialize();
  const envFile =
      String.fromEnvironment('env', defaultValue: '.env.development');
  await dotenv.load(fileName: envFile);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'what color',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        primaryColor: Colors.tealAccent,
        textTheme: const TextTheme().copyWith(
          bodySmall: const TextStyle(color: Colors.tealAccent),
          bodyMedium: const TextStyle(color: Colors.tealAccent),
          bodyLarge: const TextStyle(color: Colors.tealAccent),
          labelSmall: const TextStyle(color: Colors.tealAccent),
          labelMedium: const TextStyle(color: Colors.tealAccent),
          labelLarge: const TextStyle(color: Colors.tealAccent),
          displaySmall: const TextStyle(color: Colors.tealAccent),
          displayMedium: const TextStyle(color: Colors.tealAccent),
          displayLarge: const TextStyle(color: Colors.tealAccent),
          titleMedium: const TextStyle(color: Colors.tealAccent),
        ),
      ),
      home: const IdealListPage(),
    );
  }
}
