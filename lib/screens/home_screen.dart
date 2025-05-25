import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/game_constants.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.extension, size: 80, color: Colors.white).animate().scale(duration: const Duration(milliseconds: 600)),

                const SizedBox(height: 20),

                Text(
                  'Geometric Recall',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ).animate().fadeIn(duration: const Duration(milliseconds: 800)).slideY(begin: 0.2),

                const SizedBox(height: 60),

                _buildMenuButton(context, 'Start Game', Icons.play_arrow, () => _showDifficultyDialog(context)),

                const SizedBox(height: 16),

                _buildMenuButton(context, 'How to Play', Icons.help_outline, () => _showHowToPlay(context)),

                const SizedBox(height: 16),

                _buildMenuButton(context, 'Settings', Icons.settings, () => _showSettings(context)),

                const SizedBox(height: 16),

                _buildMenuButton(context, 'Exit', Icons.exit_to_app, () => Navigator.pop(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String text, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 200,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 18),
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 200 * text.length)).slideX();
  }

  void _showDifficultyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Select Difficulty'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDifficultyButton(context, 'Easy (2x2)', GameDifficulty.easy),
                const SizedBox(height: 8),
                _buildDifficultyButton(context, 'Medium (4x4)', GameDifficulty.medium),
                const SizedBox(height: 8),
                _buildDifficultyButton(context, 'Hard (6x6)', GameDifficulty.hard),
              ],
            ),
          ),
    );
  }

  Widget _buildDifficultyButton(BuildContext context, String text, GameDifficulty difficulty) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context); // Close dialog
          Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen(difficulty: difficulty)));
        },
        child: Text(text),
      ),
    );
  }

  void _showHowToPlay(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('How to Play'),
            content: const SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🎮 Game Rules:'),
                  SizedBox(height: 8),
                  Text('1. Tap any card to reveal its shape'),
                  Text('2. Try to find matching pairs of shapes'),
                  Text('3. Remember the locations of shapes you\'ve seen'),
                  Text('4. Match all pairs to win!'),
                  SizedBox(height: 16),
                  Text('🌟 Tips:'),
                  Text('- Focus on a few cards at a time'),
                  Text('- Take your time to memorize positions'),
                  Text('- Try to beat your best time!'),
                ],
              ),
            ),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Got it!'))],
          ),
    );
  }

  void _showSettings(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Settings'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  title: const Text('Sound Effects'),
                  value: true, // TODO: Implement sound settings
                  onChanged: (value) {
                    // TODO: Implement sound toggle
                  },
                ),
                SwitchListTile(
                  title: const Text('Background Music'),
                  value: false, // TODO: Implement music settings
                  onChanged: (value) {
                    // TODO: Implement music toggle
                  },
                ),
              ],
            ),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
          ),
    );
  }
}
