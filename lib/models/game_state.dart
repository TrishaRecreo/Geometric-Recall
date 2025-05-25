import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/game_constants.dart';

class GameState extends ChangeNotifier {
  GameDifficulty _difficulty = GameDifficulty.easy;
  int _moves = 0;
  int _matches = 0;
  int _elapsedSeconds = 0;
  bool _isPlaying = false;
  Timer? _timer;
  List<int> _selectedCards = [];
  List<bool> _revealedCards = [];
  List<MapEntry<IconData, Color>> _gameCards = [];

  GameDifficulty get difficulty => _difficulty;
  int get moves => _moves;
  int get matches => _matches;
  int get elapsedSeconds => _elapsedSeconds;
  bool get isPlaying => _isPlaying;
  List<int> get selectedCards => _selectedCards;
  List<bool> get revealedCards => _revealedCards;
  List<MapEntry<IconData, Color>> get gameCards => _gameCards;

  void setDifficulty(GameDifficulty difficulty) {
    _difficulty = difficulty;
    notifyListeners();
  }

  void startGame() {
    _moves = 0;
    _matches = 0;
    _elapsedSeconds = 0;
    _selectedCards = [];
    _isPlaying = true;
    _initializeCards();
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedSeconds++;
      notifyListeners();
    });
  }

  void _initializeCards() {
    final gridSize = GameConstants.gridSizes[_difficulty]!;
    final pairCount = (gridSize * gridSize) ~/ 2;

    List<MapEntry<IconData, Color>> pairs = [];
    for (int i = 0; i < pairCount; i++) {
      final icon = GameConstants.shapeIcons[i % GameConstants.shapeIcons.length];
      final color = GameConstants.shapeColors[i % GameConstants.shapeColors.length];
      pairs.add(MapEntry(icon, color));
      pairs.add(MapEntry(icon, color));
    }

    pairs.shuffle();
    _gameCards = pairs;
    _revealedCards = List.generate(pairs.length, (index) => false);
  }

  void selectCard(int index) {
    if (!_isPlaying || _revealedCards[index] || _selectedCards.contains(index)) {
      return;
    }

    _selectedCards.add(index);
    if (_selectedCards.length == 2) {
      _moves++;
      if (_isMatch(_selectedCards[0], _selectedCards[1])) {
        _revealedCards[_selectedCards[0]] = true;
        _revealedCards[_selectedCards[1]] = true;
        _matches++;
        _selectedCards = [];

        if (_matches == _gameCards.length ~/ 2) {
          _gameComplete();
        }
      } else {
        Future.delayed(GameConstants.matchCheckDelay, () {
          _selectedCards = [];
          notifyListeners();
        });
      }
    }
    notifyListeners();
  }

  bool _isMatch(int index1, int index2) {
    return _gameCards[index1].key == _gameCards[index2].key && _gameCards[index1].value == _gameCards[index2].value;
  }

  void _gameComplete() {
    _isPlaying = false;
    _timer?.cancel();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
