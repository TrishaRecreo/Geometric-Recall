import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/game_constants.dart';
import '../models/game_state.dart';
import '../widgets/game_card.dart';
import '../widgets/game_stats.dart';

class GameScreen extends StatefulWidget {
  final GameDifficulty difficulty;

  const GameScreen({super.key, required this.difficulty});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final gameState = context.read<GameState>();
      gameState.setDifficulty(widget.difficulty);
      gameState.startGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Exit Game?'),
                content: const Text('Are you sure you want to exit the current game?'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                  TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Exit')),
                ],
              ),
        );
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Geometric Recall'),
          actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: () => _showRestartDialog(context))],
        ),
        body: Consumer<GameState>(
          builder: (context, gameState, child) {
            if (!gameState.isPlaying && gameState.matches > 0) {
              // Show game completion dialog
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showGameCompleteDialog(context, gameState);
              });
            }

            return Column(
              children: [
                const GameStats(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final gridSize = GameConstants.gridSizes[gameState.difficulty]!;
                        final itemSize = (constraints.maxWidth / gridSize) - 8;

                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: gridSize,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1,
                          ),
                          itemCount: gridSize * gridSize,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: itemSize,
                              height: itemSize,
                              child: GameCard(index: index, onTap: () => gameState.selectCard(index)),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showRestartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Restart Game?'),
            content: const Text('Are you sure you want to restart the current game?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<GameState>().startGame();
                },
                child: const Text('Restart'),
              ),
            ],
          ),
    );
  }

  void _showGameCompleteDialog(BuildContext context, GameState gameState) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: const Text('🎉 Congratulations!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('You completed the game in:'),
                const SizedBox(height: 8),
                Text('${gameState.moves} moves', style: Theme.of(context).textTheme.headlineSmall),
                Text('${gameState.elapsedSeconds} seconds', style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Return to menu
                },
                child: const Text('Main Menu'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<GameState>().startGame();
                },
                child: const Text('Play Again'),
              ),
            ],
          ),
    );
  }
}
