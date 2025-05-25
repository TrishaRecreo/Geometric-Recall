import 'package:flutter/material.dart';

enum GameDifficulty { easy, medium, hard }

class GameConstants {
  static const Map<GameDifficulty, int> gridSizes = {GameDifficulty.easy: 2, GameDifficulty.medium: 4, GameDifficulty.hard: 6};

  static const List<IconData> shapeIcons = [
    Icons.circle,
    Icons.square,
    Icons.change_history, // triangle
    Icons.star,
    Icons.hexagon,
    Icons.favorite,
    Icons.pentagon,
    Icons.diamond,
    Icons.waves, // curved shape
    Icons.rectangle,
    Icons.blur_circular, // circle variant
    Icons.architecture, // geometric shape
  ];

  static const List<Color> shapeColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.amber,
    Colors.indigo,
    Colors.cyan,
    Colors.brown,
    Colors.lime,
  ];

  static const Duration flipDuration = Duration(milliseconds: 300);
  static const Duration matchCheckDelay = Duration(seconds: 1);
}
