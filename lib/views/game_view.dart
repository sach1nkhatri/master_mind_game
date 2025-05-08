import 'dart:math';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  int correctCount = 0;
  int mistakeCount = 0;
  int num1 = 0;
  int num2 = 0;
  bool gameFinished = false;

  void generateNumbers() {
    Random random = Random();
    int a = random.nextInt(100);
    int b = random.nextInt(100);

    // Ensure the numbers aren't equal
    while (a == b) {
      b = random.nextInt(100);
    }

    setState(() {
      num1 = a;
      num2 = b;
    });
  }

  void handleChoice(int selected) {
    if (gameFinished) return;

    int correct = num1 > num2 ? num1 : num2;

    if (selected == correct) {
      correctCount++;
    } else {
      mistakeCount++;
    }

    if (correctCount >= 10) {
      setState(() {
        gameFinished = true;
      });
    } else {
      generateNumbers();
    }
  }

  void resetGame() {
    setState(() {
      correctCount = 0;
      mistakeCount = 0;
      gameFinished = false;
    });
    generateNumbers();
  }

  @override
  void initState() {
    super.initState();
    generateNumbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Master Mind Game")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!gameFinished) ...[
                Text("Choose the greater number", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => handleChoice(num1),
                      child: Text('$num1', style: const TextStyle(fontSize: 28)),
                    ),
                    ElevatedButton(
                      onPressed: () => handleChoice(num2),
                      child: Text('$num2', style: const TextStyle(fontSize: 28)),
                    ),
                  ],
                ),
              ] else ...[
                const Text("🎉 Game Over!"),
                Text("✅ Correct: $correctCount"),
                Text("❌ Mistakes: $mistakeCount"),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: resetGame,
                  child: const Text("Restart"),
                ),
              ],
              const SizedBox(height: 40),
              Text("Correct Guesses: $correctCount / 10"),
              Text("Mistakes: $mistakeCount"),
            ],
          ),
        ),
      ),
    );
  }
}
