class CardItem {
  final int id;
  final String fruit;
  bool isFlipped;
  bool isMatched;

  CardItem({
    required this.id,
    required this.fruit,
    this.isFlipped = false,
    this.isMatched = false,
  });
}
