class Player {
  final String name;
  final int timeLimit;
  int _remainingTime;
  int _score = 0;

  Player({
    required this.name,
    required this.timeLimit,
  }) : _remainingTime = timeLimit;

  int get remainingTime => _remainingTime;
  int get score => _score;
  bool get isActive => _remainingTime > 0;

  void updateTime(int seconds) {
    _remainingTime = (_remainingTime - seconds).clamp(0, timeLimit);
  }

  void updateScore(int points) {
    _score += points;
  }

  // Süreyi başlangıç değerine sıfırla
  void resetTime() {
    _remainingTime = timeLimit;
  }
}
