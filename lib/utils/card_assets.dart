/// Kart setleri — emoji yerine özel illüstrasyon kimlikleri
class CardAssets {
  static const Map<String, List<String>> cardSets = {
    'Meyveler': [
      'apple', 'banana', 'grape', 'orange', 'strawberry', 'pear',
      'watermelon', 'kiwi', 'mango', 'pineapple', 'cherry', 'coconut',
      'blueberry', 'peach', 'lemon', 'melon', 'avocado', 'tomato',
      'plum', 'pomegranate', 'fig', 'apricot', 'papaya', 'lime',
    ],
    'Hayvanlar': [
      'dog', 'cat', 'rabbit', 'fox', 'bear', 'panda',
      'tiger', 'lion', 'cow', 'pig', 'frog', 'monkey',
      'owl', 'butterfly', 'turtle', 'horse', 'sheep', 'duck',
      'elephant', 'giraffe',
    ],
    'Yüz İfadeleri': [
      'happy', 'laugh', 'wink', 'love', 'cool', 'surprised',
      'thinking', 'sleepy', 'party', 'sad', 'angry', 'shy',
      'silly', 'star_eyes', 'hug', 'cheer', 'blush', 'grin',
      'wow', 'yawn',
    ],
    'Spor': [
      'football', 'basketball', 'tennis', 'baseball', 'volleyball',
      'golf', 'bowling', 'swimming', 'cycling', 'skiing',
      'surfing', 'boxing', 'archery', 'skating', 'yoga',
      'running', 'climbing', 'fencing', 'hockey', 'badminton',
    ],
    'Doğa': [
      'flower_rose', 'flower_sun', 'flower_tulip', 'tree_oak', 'tree_palm',
      'leaf', 'mushroom', 'rainbow', 'star', 'moon',
      'cloud', 'mountain', 'wave', 'snowflake', 'cactus',
      'butterfly_nature', 'bee', 'ladybug', 'raindrop', 'sunrise',
    ],
  };

  static String categoryForSet(String setName) {
    switch (setName) {
      case 'Meyveler':
        return 'fruits';
      case 'Hayvanlar':
        return 'animals';
      case 'Yüz İfadeleri':
        return 'faces';
      case 'Spor':
        return 'sports';
      case 'Doğa':
        return 'nature';
      default:
        return 'fruits';
    }
  }
}
