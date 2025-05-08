import 'package:flutter/material.dart';
import 'views/game_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master Mind Game',
      theme: ThemeData.dark(),
      home: const GameView(),
    );
  }
}
