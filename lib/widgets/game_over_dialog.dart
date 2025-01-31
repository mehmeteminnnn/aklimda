import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../models/player.dart';
import 'dart:math';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GameOverDialog extends StatefulWidget {
  final Player? winner;
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
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5))..play();
    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-2913289160482051/1848945930',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          debugPrint('Reklam yüklenemedi: $error');
        },
      ),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
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
                widget.winner == null
                    ? 'Berabere! Şansınızı tekrar deneyin!'
                    : 'Kazanan: ${widget.winner!.name}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: widget.winner == null ? Colors.orange : Colors.green,
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
                if (_interstitialAd != null) {
                  _interstitialAd?.show().then((_) {
                    Navigator.of(context).pushReplacementNamed('/setup');
                  });
                } else {
                  Navigator.of(context).pushReplacementNamed('/setup');
                }
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
