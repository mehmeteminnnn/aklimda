import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../providers/game_provider.dart';
import '../models/player.dart';
import 'game_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GameSetupScreen extends StatefulWidget {
  const GameSetupScreen({super.key});

  @override
  State<GameSetupScreen> createState() => _GameSetupScreenState();
}

class _GameSetupScreenState extends State<GameSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  int _playerCount = 2;
  int _timeLimit = 30;
  int _totalCards = 16;
  List<TextEditingController> _nameControllers = [];
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _updateControllers();
    _loadInterstitialAd();
  }

  void _updateControllers() {
    _nameControllers = List.generate(
      _playerCount,
      (index) => TextEditingController(),
    );
  }

  void _loadInterstitialAd() {
    debugPrint('Reklam yükleme başlatıldı...');

    InterstitialAd.load(
      adUnitId: 'ca-app-pub-2913289160482051/1848945930',
      request: const AdRequest(
        keywords: ['game', 'memory game'],
        nonPersonalizedAds: true,
      ),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('Reklam başarıyla yüklendi');
          _interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              debugPrint('Reklam tam ekran gösterildi');
            },
            onAdDismissedFullScreenContent: (ad) {
              debugPrint('Reklam kapatıldı');
              ad.dispose();
              _loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('Reklam gösterme hatası: ${error.message}');
              debugPrint('Hata kodu: ${error.code}');
              debugPrint('Domain: ${error.domain}');
              ad.dispose();
              _loadInterstitialAd();
            },
            onAdImpression: (_) {
              debugPrint('Reklam gösterim kaydedildi');
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Reklam yüklenemedi');
          debugPrint('Hata mesajı: ${error.message}');
          debugPrint('Hata kodu: ${error.code}');
          debugPrint('Domain: ${error.domain}');
          debugPrint('Response info: ${error.responseInfo}');

          Future.delayed(const Duration(seconds: 5), () {
            _loadInterstitialAd();
          });
        },
      ),
    );
  }

  void _startGame() {
    if (_formKey.currentState!.validate()) {
      List<String> playerNames = _nameControllers
          .map((controller) => controller.text.trim())
          .where((name) => name.isNotEmpty)
          .toList();

      if (playerNames.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('En az bir oyuncu gerekli')),
        );
        return;
      }

      void startGameScreen() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GameScreen(
              playerNames: playerNames,
              cardCount: _totalCards,
            ),
          ),
        );
      }

      if (_interstitialAd != null) {
        debugPrint('Reklam gösteriliyor...');
        _interstitialAd?.show().then((_) {
          debugPrint('Reklam gösterildi, oyun başlatılıyor');
          startGameScreen();
        }).catchError((error) {
          debugPrint('Reklam gösterilemedi: $error');
          startGameScreen();
        });
      } else {
        debugPrint('Reklam yüklü değil, direkt oyun başlatılıyor');
        startGameScreen();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.8),
              Theme.of(context).primaryColorLight,
            ],
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Oyun Ayarları',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'ComicNeue',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildSettingRow(
                          'Oyuncu Sayısı',
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: _playerCount > 2
                                    ? () => setState(() {
                                          _playerCount--;
                                          _updateControllers();
                                        })
                                    : null,
                                icon: const Icon(Icons.remove_circle_outline),
                                color: Theme.of(context).primaryColor,
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '$_playerCount',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'ComicNeue',
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: _playerCount < 8
                                    ? () => setState(() {
                                          _playerCount++;
                                          _updateControllers();
                                        })
                                    : null,
                                icon: const Icon(Icons.add_circle_outline),
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        _buildSettingRow(
                          'Süre',
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _timeLimit == -1
                                    ? 'Sınırsız'
                                    : '$_timeLimit saniye',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'ComicNeue',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Slider(
                                  value: _timeLimit == -1
                                      ? 35
                                      : _timeLimit.toDouble(),
                                  min: 10,
                                  max: 35,
                                  divisions: 6,
                                  label: _timeLimit == -1 ? '∞' : '$_timeLimit',
                                  onChanged: (value) {
                                    setState(() {
                                      _timeLimit =
                                          value == 35 ? -1 : value.round();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        _buildSettingRow(
                          'Kart Seti',
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: context
                                    .watch<GameProvider>()
                                    .selectedCardSet,
                                items: GameProvider.cardSets.keys
                                    .map((set) => DropdownMenuItem(
                                          value: set,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  GameProvider
                                                      .cardSets[set]!.first,
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  set,
                                                  style: const TextStyle(
                                                    fontFamily: 'ComicNeue',
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    context
                                        .read<GameProvider>()
                                        .setCardSet(value);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        const Divider(height: 1),
                        _buildSettingRow(
                          'Toplam Kart',
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [16, 24, 36].map((count) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: InkWell(
                                  onTap: () =>
                                      setState(() => _totalCards = count),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: _totalCards == count
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: _totalCards == count ? 2 : 1,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$count',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Comic Sans MS',
                                            fontWeight: FontWeight.bold,
                                            color: _totalCards == count
                                                ? Colors.white
                                                : Theme.of(context)
                                                    .primaryColor,
                                          ),
                                        ),
                                        Text(
                                          count == 24
                                              ? '6x4'
                                              : '${sqrt(count).toInt()}x${(count / sqrt(count)).toInt()}',
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontFamily: 'Comic Sans MS',
                                            color: _totalCards == count
                                                ? Colors.white
                                                : Theme.of(context)
                                                    .primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ...List.generate(_playerCount, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: TextFormField(
                      controller: _nameControllers[index],
                      decoration: InputDecoration(
                        labelText: '${index + 1}. Oyuncu',
                        labelStyle: const TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColor,
                            size: 24,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Quicksand',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen bir isim girin';
                        }
                        return null;
                      },
                    ),
                  );
                }),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    backgroundColor: Colors.green.shade400,
                    elevation: 5,
                    shadowColor: Colors.green.withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Oyunu Başlat',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'ComicNeue',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.play_circle_outline,
                        size: 24,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingRow(String label, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'ComicNeue',
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: child,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    for (var controller in _nameControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
