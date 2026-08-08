class CardItem {
  final int id;
  final String symbolId;
  final String category;
  bool isFlipped;
  bool isMatched;
  bool isShaking;

  CardItem({
    required this.id,
    required this.symbolId,
    required this.category,
    this.isFlipped = false,
    this.isMatched = false,
    this.isShaking = false,
  });

  /// Geriye dönük uyumluluk
  String get fruit => symbolId;
}
