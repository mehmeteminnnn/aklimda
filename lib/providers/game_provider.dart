import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/player.dart';
import '../models/card_item.dart';
import '../widgets/game_over_dialog.dart';
import '../utils/card_assets.dart';
import '../main.dart';

enum GameEvent { match, mismatch, gameOver }

class GameProvider extends ChangeNotifier {
  String _selectedCardSet = 'Meyveler';
  String get selectedCardSet => _selectedCardSet;

  List<Player> _players = [];
  List<CardItem> _cards = [];
  int _currentPlayerIndex = 0;
  CardItem? _firstSelectedCard;
  bool _canFlipCard = true;
  Function(Player)? _onPlayerChanged;
  int _matchedPairs = 0;
  int gridColumns = 4;
  int gridRows = 4;

  // Olay dinleyicileri
  VoidCallback? onMatch;
  VoidCallback? onMismatch;

  List<Player> get players => _players;
  List<CardItem> get cards => _cards;
  Player get currentPlayer => _players.isNotEmpty
      ? _players[_currentPlayerIndex]
      : Player(name: 'Oyuncu', timeLimit: 30);
  bool get canFlipCard => _canFlipCard;

  static Map<String, List<String>> get cardSets => CardAssets.cardSets;

  void initializeGame(int cardCount, int timeLimit) {
    int rows, columns;
    switch (cardCount) {
      case 16:
        rows = 4;
        columns = 4;
      case 24:
        rows = 4;
        columns = 6;
      case 36:
        rows = 6;
        columns = 6;
      default:
        rows = 4;
        columns = 4;
    }

    final category = CardAssets.categoryForSet(_selectedCardSet);
    final List<String> selectedSymbols =
        List.from(cardSets[_selectedCardSet]!);
    selectedSymbols.shuffle();
    selectedSymbols.length = cardCount ~/ 2;

    _cards = [...selectedSymbols, ...selectedSymbols]
        .asMap()
        .entries
        .map((entry) => CardItem(
              id: entry.key,
              symbolId: entry.value,
              category: category,
            ))
        .toList();
    _cards.shuffle();

    gridColumns = columns;
    gridRows = rows;
    _matchedPairs = 0;

    notifyListeners();
  }

  void flipCard(CardItem card) {
    if (!_canFlipCard) return;

    final index = _cards.indexOf(card);
    if (index == -1 || _cards[index].isMatched || _cards[index].isFlipped) {
      return;
    }

    HapticFeedback.selectionClick();
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
    Future.delayed(const Duration(milliseconds: 800), () {
      if (_firstSelectedCard!.symbolId == secondCard.symbolId) {
        _firstSelectedCard!.isMatched = true;
        secondCard.isMatched = true;
        currentPlayer.updateScore(1);
        currentPlayer.resetTime();
        _matchedPairs++;

        HapticFeedback.mediumImpact();
        onMatch?.call();

        if (_checkGameEnd()) {
          _showGameOverDialog();
        }
      } else {
        _firstSelectedCard!.isShaking = true;
        secondCard.isShaking = true;
        notifyListeners();

        HapticFeedback.heavyImpact();
        onMismatch?.call();

        Future.delayed(const Duration(milliseconds: 500), () {
          _firstSelectedCard!.isFlipped = false;
          secondCard.isFlipped = false;
          _firstSelectedCard!.isShaking = false;
          secondCard.isShaking = false;
          nextPlayer();
          _firstSelectedCard = null;
          _canFlipCard = true;
          notifyListeners();
        });
        return;
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
    currentPlayer.resetTime();
    notifyListeners();

    _onPlayerChanged?.call(_players[_currentPlayerIndex]);
  }

  bool isGameOver() => _cards.every((card) => card.isMatched);

  bool isTieGame() {
    if (_players.isEmpty) return false;
    final firstScore = _players.first.score;
    return _players.every((player) => player.score == firstScore);
  }

  Player? getWinner() {
    if (isTieGame()) return null;
    return _players.reduce((a, b) => a.score > b.score ? a : b);
  }

  void initializePlayers(List<Player> players) {
    if (players.isEmpty) return;
    _players = players.take(players.length).toList();
    _currentPlayerIndex = 0;
    notifyListeners();
  }

  void updatePlayerTime(int seconds) {
    if (currentPlayer.timeLimit == -1) return;
    currentPlayer.updateTime(seconds);
    notifyListeners();
  }

  void setPlayerChangeCallback(Function(Player) callback) {
    _onPlayerChanged = callback;
  }

  bool _checkGameEnd() => _matchedPairs == _cards.length ~/ 2;

  void setCardSet(String cardSet) {
    _selectedCardSet = cardSet;
    notifyListeners();
  }
}
