import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import 'game_setup_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.read<GameProvider>();
    final winner = gameProvider.getWinner();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Oyun Bitti'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.emoji_events,
              size: 100,
              color: Colors.amber,
            ),
            const SizedBox(height: 20),
            Text(
              'Kazanan:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              winner?.name ?? 'Belirsiz',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              'Skor: ${winner?.score ?? 0}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameSetupScreen(),
                  ),
                );
              },
              child: const Text('Yeni Oyun'),
            ),
          ],
        ),
      ),
    );
  }
}
