import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../models/player.dart';
import 'dart:math';

class GameOverDialog extends StatefulWidget {
  final Player winner;
  final List<Player> players;

  const GameOverDialog({
    Key? key,
    required this.winner,
    required this.players,
  }) : super(key: key);

  @override
  State<GameOverDialog> createState() => _GameOverDialogState();
}

class _GameOverDialogState extends State<GameOverDialog> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5))..play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          title: Text(
            '🎉 Oyun Bitti! 🎉',
            style: TextStyle(
              fontFamily: 'ComicNeue',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Kazanan: ${widget.winner.name}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              ...widget.players
                  .map((player) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              player.name,
                              style: TextStyle(
                                fontWeight: player == widget.winner
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            Text(
                              '${player.score} puan',
                              style: TextStyle(
                                color: player == widget.winner
                                    ? Colors.green
                                    : Colors.black,
                                fontWeight: player == widget.winner
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/setup');
              },
              child: const Text('Yeni Oyun'),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: MediaQuery.of(context).size.width / 2 - 20,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 2,
            maxBlastForce: 5,
            minBlastForce: 1,
            emissionFrequency: 0.03,
            numberOfParticles: 20,
            gravity: 0.2,
          ),
        ),
      ],
    );
  }
}
