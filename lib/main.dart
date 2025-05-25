import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/game_state.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => GameState(), child: const GeometricRecallApp()));
}

class GeometricRecallApp extends StatelessWidget {
  const GeometricRecallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geometric Recall',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light),
        useMaterial3: true,
        cardTheme: CardTheme(elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        buttonTheme: ButtonThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
        useMaterial3: true,
        cardTheme: CardTheme(elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        buttonTheme: ButtonThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
      home: const HomeScreen(),
    );
  }
}
