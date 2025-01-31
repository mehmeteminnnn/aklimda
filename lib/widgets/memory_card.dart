import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../models/card_item.dart';
import '../providers/game_provider.dart';

class MemoryCard extends StatelessWidget {
  final CardItem card;

  const MemoryCard({Key? key, required this.card}) : super(key: key);

  double _getEmojiSize(BuildContext context) {
    final cardCount = context.read<GameProvider>().cards.length;
    if (cardCount <= 16) return 48;
    if (cardCount <= 24) return 29;
    if (cardCount <= 36) return 28;
    return 24;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<GameProvider>().flipCard(card);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..setEntry(3, 2, 0.001),
        child: Card(
          elevation: card.isFlipped ? 8 : 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: card.isMatched
                  ? Colors.green.withOpacity(0.8)
                  : Colors.transparent,
              width: 3,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: card.isFlipped
                    ? [Colors.white, Colors.grey.shade100]
                    : [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
              ),
            ),
            child: Center(
              child: card.isFlipped
                  ? Text(
                      card.fruit,
                      style: TextStyle(fontSize: _getEmojiSize(context)),
                    )
                  : Icon(
                      Icons.question_mark_rounded,
                      size: 40,
                      color: Colors.white.withOpacity(0.9),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
