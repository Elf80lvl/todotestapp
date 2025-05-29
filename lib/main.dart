import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todotestapp/data/themes.dart';
import 'package:todotestapp/presentation/home_page.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Test App',
      theme: kLightTheme,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
