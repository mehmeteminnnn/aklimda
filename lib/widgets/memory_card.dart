import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../models/card_item.dart';
import '../providers/game_provider.dart';
import '../utils/theme.dart';
import 'illustrations/card_face_illustration.dart';
import 'illustrations/card_back.dart';

class MemoryCard extends StatefulWidget {
  final CardItem card;

  const MemoryCard({super.key, required this.card});

  @override
  State<MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard>
    with TickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutBack),
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    if (widget.card.isFlipped) {
      _flipController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(MemoryCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.card.isFlipped != oldWidget.card.isFlipped) {
      if (widget.card.isFlipped) {
        _flipController.forward();
      } else {
        _flipController.reverse();
      }
    }
    if (widget.card.isShaking && !oldWidget.card.isShaking) {
      _shakeController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _flipController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.card.isFlipped ? 'Açık kart' : 'Kapalı kart',
      child: Material(
      color: Colors.transparent,
      child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => context.read<GameProvider>().flipCard(widget.card),
      child: AnimatedBuilder(
        animation: Listenable.merge([_flipAnimation, _shakeAnimation]),
        builder: (context, child) {
          final shakeOffset = widget.card.isShaking
              ? sin(_shakeAnimation.value * pi * 6) * 8 * (1 - _shakeAnimation.value)
              : 0.0;

          final angle = _flipAnimation.value;
          final isFront = angle >= pi / 2;

          return Transform.translate(
            offset: Offset(shakeOffset, 0),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              child: isFront
                  ? _buildFront(context)
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(pi),
                      child: _buildBack(context),
                    ),
            ),
          );
        },
      ))),
    );
  }

  Widget _buildFront(BuildContext context) {
    return _CardContainer(
      elevation: widget.card.isMatched ? 2 : 8,
      borderColor: widget.card.isMatched
          ? AppColors.leaf.withValues(alpha: 0.8)
          : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: CardFaceIllustration(
          symbolId: widget.card.symbolId,
          category: widget.card.category,
        ),
      ),
    );
  }

  Widget _buildBack(BuildContext context) {
    return _CardContainer(
      elevation: 6,
      borderColor: Colors.transparent,
      child: const ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        child: CardBackIllustration(),
      ),
    );
  }
}

class _CardContainer extends StatelessWidget {
  final Widget child;
  final double elevation;
  final Color borderColor;

  const _CardContainer({
    required this.child,
    required this.elevation,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.forest.withValues(alpha: 0.15 + elevation * 0.02),
            blurRadius: elevation * 1.5,
            offset: Offset(0, elevation * 0.5),
          ),
        ],
        border: borderColor != Colors.transparent
            ? Border.all(color: borderColor, width: 2.5)
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: child,
        ),
      ),
    );
  }
}
