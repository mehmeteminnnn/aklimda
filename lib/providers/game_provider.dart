import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';
import '../models/player.dart';
import '../models/card_item.dart';
import '../widgets/game_over_dialog.dart';
import '../main.dart';

class GameProvider extends ChangeNotifier {
  static const List<String> fruits = [
    '🍎',
    '🍌',
    '🍇',
    '🍊',
    '🍓',
    '🍐',
    '🍉',
    '🥝',
    '🥭',
    '🍍',
    '🍒',
    '🥥',
    '🫐',
    '🍑',
    '🍋',
    '🍈',
    '🍏',
    '🍅',
    '🥑',
    '🥦',
    '🍆',
    '🥕',
    '🌽',
    '🥬',
  ];

  List<Player> _players = [];
  List<CardItem> _cards = [];
  int _currentPlayerIndex = 0;
  CardItem? _firstSelectedCard;
  bool _canFlipCard = true;
  Function(Player)? _onPlayerChanged;
  List<CardItem> _flippedCards = [];
  int _matchedPairs = 0;
  int gridColumns = 4;
  int gridRows = 4;

  List<Player> get players => _players;
  List<CardItem> get cards => _cards;
  Player get currentPlayer => _players.isNotEmpty
      ? _players[_currentPlayerIndex]
      : Player(name: 'Oyuncu', timeLimit: 30); // Varsayılan oyuncu
  bool get canFlipCard => _canFlipCard;

  void initializeGame(int cardCount, int timeLimit) {
    // Grid boyutlarını ayarla
    int rows, columns;
    switch (cardCount) {
      case 16:
        rows = 4;
        columns = 4;
        break;
      case 24:
        rows = 4;
        columns = 6;
        break;
      case 36:
        rows = 6;
        columns = 6;
        break;
      default:
        rows = 4;
        columns = 4;
    }

    // Kartları oluştur
    final List<String> selectedFruits = List.from(fruits);
    selectedFruits.shuffle();
    selectedFruits.length = cardCount ~/ 2;

    _cards = [...selectedFruits, ...selectedFruits]
        .asMap()
        .entries
        .map((entry) => CardItem(
              id: entry.key,
              fruit: entry.value,
            ))
        .toList();
    _cards.shuffle();

    // Grid'i ayarla
    gridColumns = columns;
    gridRows = rows;

    _flippedCards.clear();
    _matchedPairs = 0;

    notifyListeners();
  }

  void flipCard(CardItem card) {
    if (!_canFlipCard) return;

    final index = _cards.indexOf(card);
    if (index == -1 || _cards[index].isMatched || _cards[index].isFlipped)
      return;

    _cards[index].isFlipped = true;
    notifyListeners();

    if (_firstSelectedCard == null) {
      _firstSelectedCard = _cards[index];
    } else {
      _canFlipCard = false;
      _checkMatch(_cards[index]);
    }
  }

  void _checkMatch(CardItem secondCard) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (_firstSelectedCard!.fruit == secondCard.fruit) {
        _firstSelectedCard!.isMatched = true;
        secondCard.isMatched = true;
        currentPlayer.updateScore(1);
        currentPlayer.resetTime();
        _matchedPairs++;

        if (_checkGameEnd()) {
          _showGameOverDialog();
        }
      } else {
        _firstSelectedCard!.isFlipped = false;
        secondCard.isFlipped = false;
        nextPlayer();
      }

      _firstSelectedCard = null;
      _canFlipCard = true;
      notifyListeners();
    });
  }

  void _showGameOverDialog() {
    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) => GameOverDialog(
          winner: getWinner(),
          players: players,
        ),
      );
    });
  }

  void nextPlayer() {
    _currentPlayerIndex = (_currentPlayerIndex + 1) % _players.length;
    // Yeni oyuncunun süresini sıfırla
    currentPlayer.resetTime();
    notifyListeners();

    if (_onPlayerChanged != null) {
      _onPlayerChanged!(_players[_currentPlayerIndex]);
    }
  }

  bool isGameOver() {
    return _cards.every((card) => card.isMatched);
  }

  Player getWinner() {
    return _players.reduce((a, b) => a.score > b.score ? a : b);
  }

  void initializePlayers(List<Player> players) {
    if (players.isEmpty) return; // Boş liste kontrolü
    _players = players;
    _currentPlayerIndex = 0;
    notifyListeners();
  }

  void updatePlayerTime(int seconds) {
    currentPlayer.updateTime(seconds);
    notifyListeners();
  }

  void setPlayerChangeCallback(Function(Player) callback) {
    _onPlayerChanged = callback;
  }

  bool _checkGameEnd() {
    return _matchedPairs == _cards.length ~/ 2;
  }
}
