import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import 'memory_card.dart';
import 'dart:math';

class GameGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();
    final cardCount = gameProvider.cards.length;
    final columns = gameProvider.gridColumns;
    final spacing = cardCount <= 16
        ? 12.0
        : cardCount <= 24
            ? 10.0
            : 8.0;

    return Padding(
      padding: EdgeInsets.all(spacing),
      child: AspectRatio(
        aspectRatio: columns / gameProvider.gridRows,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            childAspectRatio: 1,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemCount: cardCount,
          itemBuilder: (context, index) {
            return MemoryCard(
              card: gameProvider.cards[index],
            );
          },
        ),
      ),
    );
  }
}
