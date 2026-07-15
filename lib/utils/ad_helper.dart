import 'dart:io';
import 'package:flutter/foundation.dart';

class AdHelper {
  // App ID
  static String get appId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2913289160482051~1165755896';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2913289160482051~1165755896';
    }
    return '';
  }

  // Banner Ad Unit ID
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      // Android banner ad ID (keep existing)
      return 'ca-app-pub-2913289160482051/6240175560';
    } else if (Platform.isIOS) {
      // iOS banner ad ID
      return 'ca-app-pub-2913289160482051/8738636926';
    }
    return '';
  }

  // Interstitial Ad Unit ID
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      // Android interstitial ad ID (keep existing)
      return 'ca-app-pub-2913289160482051/1848945930';
    } else if (Platform.isIOS) {
      // iOS interstitial ad ID
      return 'ca-app-pub-2913289160482051/4913429214';
    }
    return '';
  }

  // Test Ad Unit IDs (for development)
  static String get testBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    return '';
  }

  static String get testInterstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    }
    return '';
  }
}
