import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacex_launches/screens/home_screen.dart';
import 'package:spacex_launches/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceX Launches',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SpaceXLaunchesHomePage(),
    );
  }
}
