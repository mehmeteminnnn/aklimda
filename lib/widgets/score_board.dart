import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Skor Tablosu',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              ...gameProvider.players.map((player) {
                return Card(
                  color: player == gameProvider.currentPlayer
                      ? Colors.blue.shade100
                      : null,
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: player.isActive ? Colors.blue : Colors.grey,
                    ),
                    title: Text(
                      '${player.name}',
                      style: const TextStyle(
                        fontFamily: 'ComicNeue',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    trailing: Text(
                      '${player.score} puan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: player.isActive ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
