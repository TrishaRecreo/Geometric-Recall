import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/game_constants.dart';
import '../models/game_state.dart';

class GameCard extends StatelessWidget {
  final int index;
  final VoidCallback onTap;

  const GameCard({super.key, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        final isRevealed = gameState.revealedCards[index] || gameState.selectedCards.contains(index);
        final card = gameState.gameCards[index];

        return GestureDetector(
          onTap: onTap,
          child: FlipCard(
            isFlipped: isRevealed,
            front: const CardFace(child: Icon(Icons.question_mark, size: 40, color: Colors.white)),
            back: CardFace(child: Icon(card.key, size: 40, color: card.value)),
          ),
        );
      },
    );
  }
}

class FlipCard extends StatelessWidget {
  final bool isFlipped;
  final Widget front;
  final Widget back;

  const FlipCard({super.key, required this.isFlipped, required this.front, required this.back});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: GameConstants.flipDuration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
        return AnimatedBuilder(
          animation: rotateAnim,
          child: child,
          builder: (context, child) {
            final isUnder = (ValueKey(isFlipped) != child?.key);
            var tilt = ((rotateAnim.value - pi / 2).abs()) * 0.003;
            tilt *= isUnder ? -1.0 : 1.0;
            return Transform(transform: Matrix4.rotationY(rotateAnim.value)..setEntry(3, 0, tilt), alignment: Alignment.center, child: child);
          },
        );
      },
      layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
      child: isFlipped ? KeyedSubtree(key: const ValueKey(true), child: back) : KeyedSubtree(key: const ValueKey(false), child: front),
    );
  }
}

class CardFace extends StatelessWidget {
  final Widget child;

  const CardFace({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Center(child: child),
    );
  }
}
