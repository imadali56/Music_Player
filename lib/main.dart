import 'package:flutter/material.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/screens/splash_screen.dart';
import 'package:music_player/theme/theme_provider.dart';
import 'package:provider/provider.dart';
// 1. Add these two imports
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // 2. Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // 3. Initialize Hive and open a box
  await Hive.initFlutter();
  await Hive.openBox('music_box');

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => PlayListProvider()),
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
    );
  }
}