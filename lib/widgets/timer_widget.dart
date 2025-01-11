import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final gameProvider = context.read<GameProvider>();
      gameProvider.updatePlayerTime(1);

      if (!gameProvider.currentPlayer.isActive) {
        gameProvider.nextPlayer();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPlayer = context.watch<GameProvider>().currentPlayer;
    final remainingTime = currentPlayer.remainingTime;
    final isLowTime = remainingTime < 10;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: remainingTime.toDouble()),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) {
        return Text(
          '${value.toInt()} saniye',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isLowTime ? Colors.red : Colors.black,
          ),
        );
      },
    );
  }
}
