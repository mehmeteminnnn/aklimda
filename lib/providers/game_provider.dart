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

  static const List<String> animals = [
    '🐶',
    '🐱',
    '🐭',
    '🐹',
    '🐰',
    '🦊',
    '🐻',
    '🐼',
    '🐨',
    '🐯',
    '🦁',
    '🐮',
    '🐷',
    '🐸',
    '🐵',
    '🦄',
    '🐔',
    '🦉',
    '🦋',
    '🐢',
  ];

  static const List<String> faces = [
    '😀',
    '😅',
    '😂',
    '🤣',
    '😊',
    '😇',
    '🙂',
    '😉',
    '😍',
    '🥰',
    '😘',
    '😋',
    '🤪',
    '😎',
    '🤓',
    '😤',
    '🥳',
    '😱',
    '🤔',
    '🤗',
  ];

  static const List<String> sports = [
    '⚽',
    '🏀',
    '🏈',
    '⚾',
    '🎾',
    '🏐',
    '🏉',
    '🎱',
    '🏓',
    '🏸',
    '🏒',
    '⛳',
    '🎳',
    '🏹',
    '🥊',
    '🏂',
    '🏄',
    '🚴',
    '⛹️',
    '🤸',
  ];

  static const List<String> nature = [
    '🌸',
    '🌹',
    '🌺',
    '🌻',
    '🌼',
    '🌷',
    '🌱',
    '🌲',
    '🌳',
    '🌴',
    '🌵',
    '🌿',
    '🍀',
    '🍁',
    '🍂',
    '🍃',
    '🌊',
    '🌈',
    '⭐',
    '🌙',
  ];

  static const Map<String, List<String>> cardSets = {
    'Meyveler': fruits,
    'Hayvanlar': animals,
    'Yüz İfadeleri': faces,
    'Spor': sports,
    'Doğa': nature,
  };

  String _selectedCardSet = 'Meyveler';
  String get selectedCardSet => _selectedCardSet;

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

    // Seçili kart setinden kartları al
    final List<String> selectedIcons = List.from(cardSets[_selectedCardSet]!);
    selectedIcons.shuffle();
    selectedIcons.length = cardCount ~/ 2;

    _cards = [...selectedIcons, ...selectedIcons]
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

  bool isTieGame() {
    if (_players.isEmpty) return false;
    final firstScore = _players.first.score;
    return _players.every((player) => player.score == firstScore);
  }

  Player? getWinner() {
    if (isTieGame()) {
      return null; // Berabere durumunda null döndür
    }
    return _players.reduce((a, b) => a.score > b.score ? a : b);
  }

  void initializePlayers(List<Player> players) {
    if (players.isEmpty) return;
    _players =
        players.take(players.length).toList(); // Sadece seçilen sayıda oyuncu
    _currentPlayerIndex = 0;
    notifyListeners();
  }

  void updatePlayerTime(int seconds) {
    if (currentPlayer.timeLimit == -1) return; // Süresiz mod için kontrol
    currentPlayer.updateTime(seconds);
    notifyListeners();
  }

  void setPlayerChangeCallback(Function(Player) callback) {
    _onPlayerChanged = callback;
  }

  bool _checkGameEnd() {
    return _matchedPairs == _cards.length ~/ 2;
  }

  void setCardSet(String cardSet) {
    _selectedCardSet = cardSet;
    notifyListeners();
  }
}
