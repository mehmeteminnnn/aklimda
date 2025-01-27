class Translations {
  static const Map<String, Map<String, String>> _translations = {
    'tr': {
      // Genel
      'language': 'Dil',
      'select_language': 'Dil Seçimi',
      'ok': 'Tamam',
      'cancel': 'İptal',
      'back': 'Geri',

      // Oyun Ayarları
      'game_settings': 'Oyun Ayarları',
      'player_count': 'Oyuncu Sayısı',
      'time_limit': 'Süre',
      'seconds': 'saniye',
      'card_set': 'Kart Seti',
      'total_cards': 'Toplam Kart',
      'player': 'Oyuncu',
      'start_game': 'Oyunu Başlat',
      'enter_name': 'Lütfen bir isim girin',
      'at_least_one_player_required': 'En az bir oyuncu gerekli',

      // Kart Setleri
      'fruits': 'Meyveler',
      'animals': 'Hayvanlar',
      'faces': 'Yüz İfadeleri',
      'sports': 'Spor',
      'nature': 'Doğa',

      // Nasıl Oynanır
      'how_to_play': 'Nasıl Oynanır?',
      'objective': 'Amaç:',
      'objective_text': 'Oyunun amacı, aynı emojiden oluşan kart çiftlerini bulup eşleştirerek mümkün olduğunca fazla puan kazanmaktır.',
      'game_rules': 'Oyun Kuralları:',
      'rules_text': '• Oyuncular sırayla kart seçer.\n• Her oyuncu, bir hamlede iki kart açar. Eğer açılan kartlar eşleşirse:\n  - 1 puan kazanılır.\n  - Aynı oyuncu bir hamle daha yapabilir.\n• Eşleşme olmazsa, sıra diğer oyuncuya geçer.\n• Tüm kartlar eşleştirildiğinde oyun sona erer.',
      'scoring': 'Puanlama ve Kazanan:',
      'scoring_text': '• En fazla puanı toplayan oyuncu oyunu kazanır.\n• Eşitlik durumunda, beraberlik ilan edilir.',
      'note': 'Not:',
      'note_text': 'Kartları dikkatlice ezberleyerek doğru eşleşmeleri yapmaya çalışın ve rakiplerinizden daha fazla puan kazanın!',
      'understood': 'Anladım',

      // Oyun Ekranı
      'memory_game': 'Hafıza Oyunu',
      'winner': 'Kazanan: ',
      'tie_game': 'Berabere! Şansınızı tekrar deneyin!',
      'game_over': 'Oyun Bitti!',
      'points': 'puan',
      'new_game': 'Yeni Oyun',
    },
    'en': {
      // General
      'language': 'Language',
      'select_language': 'Select Language',
      'ok': 'OK',
      'cancel': 'Cancel',
      'back': 'Back',

      // Game Settings
      'game_settings': 'Game Settings',
      'player_count': 'Player Count',
      'time_limit': 'Time Limit',
      'seconds': 'seconds',
      'card_set': 'Card Set',
      'total_cards': 'Total Cards',
      'player': 'Player',
      'start_game': 'Start Game',
      'enter_name': 'Please enter a name',
      'at_least_one_player_required': 'At least one player is required',

      // Card Sets
      'fruits': 'Fruits',
      'animals': 'Animals',
      'faces': 'Face Expressions',
      'sports': 'Sports',
      'nature': 'Nature',

      // How to Play
      'how_to_play': 'How to Play?',
      'objective': 'Objective:',
      'objective_text': 'The goal of the game is to find and match pairs of cards with the same emoji to score as many points as possible.',
      'game_rules': 'Game Rules:',
      'rules_text': '• Players take turns selecting cards.\n• Each player flips two cards per turn. If the cards match:\n  - Score 1 point.\n  - The same player gets another turn.\n• If they don\'t match, the turn passes to the next player.\n• The game ends when all cards are matched.',
      'scoring': 'Scoring and Winner:',
      'scoring_text': '• The player with the most points wins the game.\n• In case of a tie, the game ends in a draw.',
      'note': 'Note:',
      'note_text': 'Try to memorize the cards carefully to make correct matches and score more points than your opponents!',
      'understood': 'Got it',

      // Game Screen
      'memory_game': 'Memory Game',
      'winner': 'Winner: ',
      'tie_game': 'It\'s a tie! Try your luck again!',
      'game_over': 'Game Over!',
      'points': 'points',
      'new_game': 'New Game',
    },
  };

  static String get(String key, String languageCode) {
    return _translations[languageCode]?[key] ?? key;
  }
}
