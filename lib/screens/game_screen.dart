import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/player.dart';
import '../providers/game_provider.dart';
import '../utils/theme.dart';
import '../widgets/game_grid.dart';
import '../widgets/garden_background.dart';
import '../widgets/score_board.dart';

class GameScreen extends StatefulWidget {
  final List<String> playerNames;
  final int cardCount;
  final int timeLimit;
  const GameScreen({super.key, required this.playerNames, required this.cardCount, required this.timeLimit});
  @override State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final ConfettiController _confetti;
  @override void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(milliseconds: 1100));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final game = context.read<GameProvider>();
      game.onMatch = _confetti.play;
      game.initializePlayers(widget.playerNames.map((name) => Player(name: name, timeLimit: widget.timeLimit)).toList());
      game.initializeGame(widget.cardCount, widget.timeLimit);
    });
  }
  @override void dispose() {
    context.read<GameProvider>().onMatch = null;
    _confetti.dispose();
    super.dispose();
  }
  @override Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: GardenBackground(
        child: Stack(children: [
          Column(children: [
            Padding(padding: const EdgeInsets.fromLTRB(20, 12, 20, 6), child: Text('Hafıza Bahçesi', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.forest))),
            Expanded(child: Center(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: GameGrid()))),
            const SafeArea(top: false, child: ScoreBoard()),
          ]),
          Align(alignment: Alignment.topCenter, child: ConfettiWidget(confettiController: _confetti, blastDirectionality: BlastDirectionality.explosive, shouldLoop: false, colors: const [AppColors.sun, AppColors.berry, AppColors.mint, AppColors.sky], numberOfParticles: 24, gravity: .22)),
        ]),
      ),
    ),
  );
}
