import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Özel 2D vektör kart yüzü illüstrasyonları — emoji/stock ikon yok
class CardFaceIllustration extends StatelessWidget {
  final String symbolId;
  final String category;

  const CardFaceIllustration({
    super.key,
    required this.symbolId,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CardFacePainter(symbolId: symbolId, category: category),
      size: Size.infinite,
    );
  }
}

class _CardFacePainter extends CustomPainter {
  final String symbolId;
  final String category;

  _CardFacePainter({required this.symbolId, required this.category});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = math.min(size.width, size.height) * 0.38;

    switch (category) {
      case 'fruits':
        _paintFruit(canvas, cx, cy, r);
      case 'animals':
        _paintAnimal(canvas, cx, cy, r);
      case 'faces':
        _paintFace(canvas, cx, cy, r);
      case 'sports':
        _paintSport(canvas, cx, cy, r);
      case 'nature':
        _paintNature(canvas, cx, cy, r);
      default:
        _paintFruit(canvas, cx, cy, r);
    }
  }

  void _paintFruit(Canvas canvas, double cx, double cy, double r) {
    switch (symbolId) {
      case 'apple':
        _drawApple(canvas, cx, cy, r, const Color(0xFFE63946), const Color(0xFF2D6A4F));
      case 'banana':
        _drawBanana(canvas, cx, cy, r);
      case 'grape':
        _drawGrapes(canvas, cx, cy, r);
      case 'orange':
        _drawCircle(canvas, cx, cy, r, const Color(0xFFF77F00), const Color(0xFFFCBF49));
      case 'strawberry':
        _drawStrawberry(canvas, cx, cy, r);
      case 'pear':
        _drawPear(canvas, cx, cy, r);
      case 'watermelon':
        _drawWatermelon(canvas, cx, cy, r);
      case 'kiwi':
        _drawKiwi(canvas, cx, cy, r);
      case 'mango':
        _drawMango(canvas, cx, cy, r);
      case 'pineapple':
        _drawPineapple(canvas, cx, cy, r);
      case 'cherry':
        _drawCherries(canvas, cx, cy, r);
      case 'coconut':
        _drawCoconut(canvas, cx, cy, r);
      case 'blueberry':
        _drawCircle(canvas, cx, cy, r * 0.85, const Color(0xFF3A0CA3), const Color(0xFF7209B7));
      case 'peach':
        _drawCircle(canvas, cx, cy, r, const Color(0xFFFFB4A2), const Color(0xFFE5989B));
      case 'lemon':
        _drawLemon(canvas, cx, cy, r);
      case 'melon':
        _drawMelon(canvas, cx, cy, r);
      case 'avocado':
        _drawAvocado(canvas, cx, cy, r);
      case 'tomato':
        _drawCircle(canvas, cx, cy, r, const Color(0xFFD00000), const Color(0xFFE85D04));
      case 'plum':
        _drawCircle(canvas, cx, cy, r, const Color(0xFF7B2CBF), const Color(0xFF9D4EDD));
      case 'pomegranate':
        _drawPomegranate(canvas, cx, cy, r);
      case 'fig':
        _drawFig(canvas, cx, cy, r);
      case 'apricot':
        _drawCircle(canvas, cx, cy, r, const Color(0xFFFF9F1C), const Color(0xFFFFBF69));
      case 'papaya':
        _drawPapaya(canvas, cx, cy, r);
      case 'lime':
        _drawCircle(canvas, cx, cy, r, const Color(0xFF70E000), const Color(0xFF38B000));
      default:
        _drawApple(canvas, cx, cy, r, const Color(0xFFE63946), const Color(0xFF2D6A4F));
    }
  }

  void _paintAnimal(Canvas canvas, double cx, double cy, double r) {
    final colors = _animalColors(symbolId);
    // Basit ama özgün hayvan silueti: gövde + kulaklar + gözler
    final bodyPaint = Paint()..color = colors.$1;
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, cy + r * 0.1), width: r * 1.6, height: r * 1.3),
      bodyPaint,
    );
    // Kulaklar
    final earPaint = Paint()..color = colors.$2;
    canvas.drawCircle(Offset(cx - r * 0.55, cy - r * 0.35), r * 0.35, earPaint);
    canvas.drawCircle(Offset(cx + r * 0.55, cy - r * 0.35), r * 0.35, earPaint);
    // Gözler
    _drawEyes(canvas, cx, cy - r * 0.05, r * 0.12);
    // Burun
    canvas.drawCircle(Offset(cx, cy + r * 0.15), r * 0.1, Paint()..color = colors.$3);
  }

  (Color, Color, Color) _animalColors(String id) {
    const map = {
      'dog': (Color(0xFFD4A574), Color(0xFFC4956A), Color(0xFF6B4226)),
      'cat': (Color(0xFFADB5BD), Color(0xFF868E96), Color(0xFFFF6B6B)),
      'rabbit': (Color(0xFFF8F9FA), Color(0xFFE9ECEF), Color(0xFFFFB4A2)),
      'fox': (Color(0xFFE85D04), Color(0xFFF48C06), Color(0xFF1B4332)),
      'bear': (Color(0xFF6B4226), Color(0xFF8B5E3C), Color(0xFF1B4332)),
      'panda': (Color(0xFFF8F9FA), Color(0xFF212529), Color(0xFF212529)),
      'tiger': (Color(0xFFF77F00), Color(0xFFFCBF49), Color(0xFF1B4332)),
      'lion': (Color(0xFFFFB703), Color(0xFFFB8500), Color(0xFF6B4226)),
      'cow': (Color(0xFFF8F9FA), Color(0xFF212529), Color(0xFFFFB4A2)),
      'pig': (Color(0xFFFFB4A2), Color(0xFFE5989B), Color(0xFFFF6B6B)),
      'frog': (Color(0xFF52B788), Color(0xFF40916C), Color(0xFF1B4332)),
      'monkey': (Color(0xFFBC6C25), Color(0xFFDDA15E), Color(0xFF6B4226)),
      'owl': (Color(0xFF8B5E3C), Color(0xFFD4A574), Color(0xFFFFD166)),
      'butterfly': (Color(0xFF9D4EDD), Color(0xFFC77DFF), Color(0xFF1B4332)),
      'turtle': (Color(0xFF40916C), Color(0xFF2D6A4F), Color(0xFF52B788)),
      'horse': (Color(0xFF6B4226), Color(0xFF8B5E3C), Color(0xFF1B4332)),
      'sheep': (Color(0xFFF8F9FA), Color(0xFFE9ECEF), Color(0xFF1B4332)),
      'duck': (Color(0xFFFFD166), Color(0xFFF77F00), Color(0xFFE85D04)),
      'elephant': (Color(0xFFADB5BD), Color(0xFF868E96), Color(0xFF495057)),
      'giraffe': (Color(0xFFFFB703), Color(0xFFFB8500), Color(0xFF6B4226)),
    };
    return map[id] ?? (const Color(0xFFD4A574), const Color(0xFFC4956A), const Color(0xFF6B4226));
  }

  void _paintFace(Canvas canvas, double cx, double cy, double r) {
    // Yuvarlak yüz
    canvas.drawCircle(Offset(cx, cy), r, Paint()..color = const Color(0xFFFFD166));
    _drawEyes(canvas, cx, cy - r * 0.15, r * 0.14);
    // Ağız — sembole göre
    final mouthPaint = Paint()
      ..color = const Color(0xFF6B4226)
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.08
      ..strokeCap = StrokeCap.round;
    switch (symbolId) {
      case 'laugh' || 'party' || 'grin' || 'cheer':
        canvas.drawArc(
          Rect.fromCenter(center: Offset(cx, cy + r * 0.2), width: r * 0.9, height: r * 0.6),
          0.1, math.pi - 0.2, false, mouthPaint,
        );
      case 'sad' || 'yawn':
        canvas.drawArc(
          Rect.fromCenter(center: Offset(cx, cy + r * 0.45), width: r * 0.7, height: r * 0.4),
          math.pi + 0.2, math.pi - 0.4, false, mouthPaint,
        );
      case 'surprised' || 'wow':
        canvas.drawOval(
          Rect.fromCenter(center: Offset(cx, cy + r * 0.25), width: r * 0.3, height: r * 0.35),
          Paint()..color = const Color(0xFF6B4226),
        );
      default:
        canvas.drawArc(
          Rect.fromCenter(center: Offset(cx, cy + r * 0.15), width: r * 0.7, height: r * 0.4),
          0.2, math.pi - 0.4, false, mouthPaint,
        );
    }
    // Yanaklar
    if (['love', 'blush', 'star_eyes', 'hug'].contains(symbolId)) {
      canvas.drawCircle(Offset(cx - r * 0.45, cy + r * 0.05), r * 0.15,
          Paint()..color = const Color(0xFFFF6B6B).withValues(alpha: 0.5));
      canvas.drawCircle(Offset(cx + r * 0.45, cy + r * 0.05), r * 0.15,
          Paint()..color = const Color(0xFFFF6B6B).withValues(alpha: 0.5));
    }
    // Güneş gözlüğü
    if (symbolId == 'cool') {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(cx, cy - r * 0.1), width: r * 1.2, height: r * 0.35),
          Radius.circular(r * 0.1),
        ),
        Paint()..color = const Color(0xFF1B4332),
      );
    }
  }

  void _paintSport(Canvas canvas, double cx, double cy, double r) {
    switch (symbolId) {
      case 'football':
        _drawBall(canvas, cx, cy, r, const Color(0xFF1B4332), const Color(0xFFF8F9FA), 5);
      case 'basketball':
        _drawBall(canvas, cx, cy, r, const Color(0xFFE85D04), const Color(0xFF1B4332), 2);
      case 'tennis':
        _drawBall(canvas, cx, cy, r, const Color(0xFF70E000), const Color(0xFFF8F9FA), 1);
      case 'baseball':
        _drawBall(canvas, cx, cy, r, const Color(0xFFF8F9FA), const Color(0xFFD00000), 2);
      case 'volleyball':
        _drawBall(canvas, cx, cy, r, const Color(0xFFF8F9FA), const Color(0xFF0077B6), 3);
      default:
        // Genel spor ikonu — madalya
        canvas.drawCircle(Offset(cx, cy), r, Paint()..color = const Color(0xFFFFD166));
        canvas.drawCircle(Offset(cx, cy), r * 0.7, Paint()..color = const Color(0xFFF77F00));
        final starPaint = Paint()..color = const Color(0xFFF8F9FA);
        for (var i = 0; i < 5; i++) {
          final angle = -math.pi / 2 + i * 2 * math.pi / 5;
          canvas.drawCircle(
            Offset(cx + math.cos(angle) * r * 0.35, cy + math.sin(angle) * r * 0.35),
            r * 0.1, starPaint,
          );
        }
    }
  }

  void _paintNature(Canvas canvas, double cx, double cy, double r) {
    switch (symbolId) {
      case 'rainbow':
        const colors = [Color(0xFFE63946), Color(0xFFF77F00), Color(0xFFFFD166),
          Color(0xFF52B788), Color(0xFF0077B6), Color(0xFF9D4EDD)];
        for (var i = 0; i < colors.length; i++) {
          final arcPaint = Paint()
            ..color = colors[i]
            ..style = PaintingStyle.stroke
            ..strokeWidth = r * 0.18;
          canvas.drawArc(
            Rect.fromCenter(center: Offset(cx, cy + r * 0.3), width: r * 2.2 - i * r * 0.18, height: r * 2.2 - i * r * 0.18),
            math.pi, math.pi, false, arcPaint,
          );
        }
      case 'star':
        _drawStar(canvas, cx, cy, r, const Color(0xFFFFD166));
      case 'moon':
        canvas.drawCircle(Offset(cx, cy), r, Paint()..color = const Color(0xFFFFD166));
        canvas.drawCircle(Offset(cx + r * 0.35, cy - r * 0.15), r * 0.85,
            Paint()..color = const Color(0xFFCAF0F8));
      case 'cloud':
        _drawCloud(canvas, cx, cy, r);
      case 'mountain':
        final mPaint = Paint()..color = const Color(0xFF40916C);
        final path = Path()
          ..moveTo(cx - r * 1.2, cy + r * 0.6)
          ..lineTo(cx - r * 0.2, cy - r * 0.7)
          ..lineTo(cx + r * 0.5, cy + r * 0.1)
          ..lineTo(cx + r * 1.2, cy - r * 0.5)
          ..lineTo(cx + r * 1.2, cy + r * 0.6)
          ..close();
        canvas.drawPath(path, mPaint);
      case 'wave':
        final wPaint = Paint()
          ..color = const Color(0xFF0077B6)
          ..style = PaintingStyle.stroke
          ..strokeWidth = r * 0.2
          ..strokeCap = StrokeCap.round;
        for (var i = 0; i < 3; i++) {
          canvas.drawArc(
            Rect.fromCenter(center: Offset(cx, cy + i * r * 0.15), width: r * 1.8, height: r * 0.5),
            0, math.pi, false, wPaint,
          );
        }
      default:
        // Çiçek
        _drawFlower(canvas, cx, cy, r, _flowerColor(symbolId));
    }
  }

  Color _flowerColor(String id) {
    const map = {
      'flower_rose': Color(0xFFE63946),
      'flower_sun': Color(0xFFFFD166),
      'flower_tulip': Color(0xFFFF6B6B),
      'leaf': Color(0xFF52B788),
      'mushroom': Color(0xFFE63946),
      'cactus': Color(0xFF40916C),
      'snowflake': Color(0xFF90E0EF),
      'sunrise': Color(0xFFF77F00),
      'raindrop': Color(0xFF0077B6),
      'bee': Color(0xFFFFD166),
      'ladybug': Color(0xFFD00000),
      'butterfly_nature': Color(0xFF9D4EDD),
      'tree_oak': Color(0xFF40916C),
      'tree_palm': Color(0xFF52B788),
    };
    return map[id] ?? const Color(0xFFE63946);
  }

  // --- Yardımcı çizim metodları ---

  void _drawApple(Canvas c, double cx, double cy, double r, Color main, Color leaf) {
    c.drawCircle(Offset(cx, cy + r * 0.05), r, Paint()..color = main);
    c.drawOval(Rect.fromCenter(center: Offset(cx + r * 0.15, cy - r * 0.85), width: r * 0.5, height: r * 0.3),
        Paint()..color = leaf);
    c.drawLine(Offset(cx, cy - r * 0.7), Offset(cx, cy - r * 1.0),
        Paint()..color = const Color(0xFF6B4226)..strokeWidth = r * 0.06..strokeCap = StrokeCap.round);
  }

  void _drawBanana(Canvas c, double cx, double cy, double r) {
    final path = Path()
      ..moveTo(cx - r * 0.3, cy + r * 0.8)
      ..quadraticBezierTo(cx - r * 1.2, cy, cx - r * 0.2, cy - r * 0.9)
      ..quadraticBezierTo(cx + r * 0.3, cy - r * 0.3, cx + r * 0.4, cy + r * 0.5)
      ..close();
    c.drawPath(path, Paint()..color = const Color(0xFFFFD166));
    c.drawPath(path, Paint()
      ..color = const Color(0xFFF77F00).withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.05);
  }

  void _drawGrapes(Canvas c, double cx, double cy, double r) {
    const grapeColor = Color(0xFF7B2CBF);
    final positions = [
      Offset(cx, cy - r * 0.3),
      Offset(cx - r * 0.35, cy - r * 0.05),
      Offset(cx + r * 0.35, cy - r * 0.05),
      Offset(cx - r * 0.2, cy + r * 0.35),
      Offset(cx + r * 0.2, cy + r * 0.35),
      Offset(cx, cy + r * 0.55),
    ];
    for (final p in positions) {
      c.drawCircle(p, r * 0.28, Paint()..color = grapeColor);
    }
    c.drawOval(Rect.fromCenter(center: Offset(cx + r * 0.1, cy - r * 0.75), width: r * 0.35, height: r * 0.2),
        Paint()..color = const Color(0xFF40916C));
  }

  void _drawStrawberry(Canvas c, double cx, double cy, double r) {
    final path = Path()
      ..moveTo(cx, cy - r * 0.7)
      ..quadraticBezierTo(cx + r, cy + r * 0.3, cx, cy + r * 0.9)
      ..quadraticBezierTo(cx - r, cy + r * 0.3, cx, cy - r * 0.7)
      ..close();
    c.drawPath(path, Paint()..color = const Color(0xFFE63946));
    for (var i = 0; i < 6; i++) {
      final angle = i * math.pi / 3;
      c.drawCircle(
        Offset(cx + math.cos(angle) * r * 0.3, cy + math.sin(angle) * r * 0.2 + r * 0.1),
        r * 0.05, Paint()..color = const Color(0xFFFFD166),
      );
    }
  }

  void _drawPear(Canvas c, double cx, double cy, double r) {
    c.drawOval(Rect.fromCenter(center: Offset(cx, cy + r * 0.15), width: r * 1.3, height: r * 1.5),
        Paint()..color = const Color(0xFF70E000));
    c.drawCircle(Offset(cx, cy - r * 0.55), r * 0.45, Paint()..color = const Color(0xFF52B788));
  }

  void _drawWatermelon(Canvas c, double cx, double cy, double r) {
    c.drawArc(Rect.fromCenter(center: Offset(cx, cy), width: r * 2, height: r * 2), math.pi, math.pi, false,
        Paint()..color = const Color(0xFF52B788));
    c.drawArc(Rect.fromCenter(center: Offset(cx, cy), width: r * 1.5, height: r * 1.5), math.pi, math.pi, false,
        Paint()..color = const Color(0xFFE63946));
    for (var i = 0; i < 4; i++) {
      c.drawCircle(Offset(cx - r * 0.5 + i * r * 0.33, cy - r * 0.15), r * 0.06,
          Paint()..color = const Color(0xFF1B4332));
    }
  }

  void _drawKiwi(Canvas c, double cx, double cy, double r) {
    c.drawCircle(Offset(cx, cy), r, Paint()..color = const Color(0xFF8B5E3C));
    c.drawCircle(Offset(cx, cy), r * 0.75, Paint()..color = const Color(0xFF70E000));
    c.drawCircle(Offset(cx, cy), r * 0.2, Paint()..color = const Color(0xFFFFD166));
    for (var i = 0; i < 8; i++) {
      final angle = i * math.pi / 4;
      c.drawLine(
        Offset(cx + math.cos(angle) * r * 0.25, cy + math.sin(angle) * r * 0.25),
        Offset(cx + math.cos(angle) * r * 0.65, cy + math.sin(angle) * r * 0.65),
        Paint()..color = const Color(0xFF1B4332)..strokeWidth = r * 0.04,
      );
    }
  }

  void _drawMango(Canvas c, double cx, double cy, double r) {
    final path = Path()
      ..moveTo(cx + r * 0.5, cy - r * 0.6)
      ..quadraticBezierTo(cx + r, cy + r * 0.3, cx, cy + r * 0.9)
      ..quadraticBezierTo(cx - r * 0.8, cy + r * 0.2, cx - r * 0.3, cy - r * 0.5)
      ..close();
    c.drawPath(path, Paint()..color = const Color(0xFFF77F00));
    c.drawOval(Rect.fromCenter(center: Offset(cx + r * 0.3, cy - r * 0.65), width: r * 0.3, height: r * 0.15),
        Paint()..color = const Color(0xFF40916C));
  }

  void _drawPineapple(Canvas c, double cx, double cy, double r) {
    c.drawOval(Rect.fromCenter(center: Offset(cx, cy + r * 0.15), width: r * 1.1, height: r * 1.4),
        Paint()..color = const Color(0xFFFFD166));
    for (var row = 0; row < 3; row++) {
      for (var col = 0; col < 3; col++) {
        c.drawLine(
          Offset(cx - r * 0.3 + col * r * 0.3, cy - r * 0.2 + row * r * 0.25),
          Offset(cx - r * 0.15 + col * r * 0.3, cy + row * r * 0.25),
          Paint()..color = const Color(0xFFF77F00)..strokeWidth = r * 0.04,
        );
      }
    }
    // Yapraklar
    for (var i = -2; i <= 2; i++) {
      c.drawLine(
        Offset(cx + i * r * 0.15, cy - r * 0.55),
        Offset(cx + i * r * 0.25, cy - r * 1.1),
        Paint()..color = const Color(0xFF40916C)..strokeWidth = r * 0.07..strokeCap = StrokeCap.round,
      );
    }
  }

  void _drawCherries(Canvas c, double cx, double cy, double r) {
    c.drawCircle(Offset(cx - r * 0.3, cy + r * 0.2), r * 0.45, Paint()..color = const Color(0xFFD00000));
    c.drawCircle(Offset(cx + r * 0.3, cy + r * 0.3), r * 0.45, Paint()..color = const Color(0xFFE63946));
    c.drawLine(Offset(cx - r * 0.3, cy - r * 0.2), Offset(cx, cy - r * 0.8),
        Paint()..color = const Color(0xFF40916C)..strokeWidth = r * 0.06);
    c.drawLine(Offset(cx + r * 0.3, cy - r * 0.1), Offset(cx, cy - r * 0.8),
        Paint()..color = const Color(0xFF40916C)..strokeWidth = r * 0.06);
  }

  void _drawCoconut(Canvas c, double cx, double cy, double r) {
    c.drawCircle(Offset(cx, cy), r, Paint()..color = const Color(0xFF6B4226));
    c.drawCircle(Offset(cx, cy), r * 0.85, Paint()..color = const Color(0xFF8B5E3C));
    c.drawCircle(Offset(cx - r * 0.15, cy - r * 0.1), r * 0.12, Paint()..color = const Color(0xFF3D2B1F));
    c.drawCircle(Offset(cx + r * 0.15, cy - r * 0.05), r * 0.1, Paint()..color = const Color(0xFF3D2B1F));
    c.drawCircle(Offset(cx, cy + r * 0.15), r * 0.11, Paint()..color = const Color(0xFF3D2B1F));
  }

  void _drawLemon(Canvas c, double cx, double cy, double r) {
    c.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: r * 1.5, height: r * 1.1),
        Paint()..color = const Color(0xFFFFD166));
    c.drawLine(Offset(cx - r * 0.5, cy), Offset(cx + r * 0.5, cy),
        Paint()..color = const Color(0xFF70E000).withValues(alpha: 0.4)..strokeWidth = r * 0.04);
  }

  void _drawMelon(Canvas c, double cx, double cy, double r) {
    c.drawCircle(Offset(cx, cy), r, Paint()..color = const Color(0xFF52B788));
    for (var i = 0; i < 6; i++) {
      final angle = i * math.pi / 3;
      c.drawLine(
        Offset(cx, cy),
        Offset(cx + math.cos(angle) * r * 0.9, cy + math.sin(angle) * r * 0.9),
        Paint()..color = const Color(0xFF2D6A4F).withValues(alpha: 0.3)..strokeWidth = r * 0.06,
      );
    }
  }

  void _drawAvocado(Canvas c, double cx, double cy, double r) {
    final path = Path()
      ..moveTo(cx, cy - r * 0.9)
      ..quadraticBezierTo(cx + r, cy, cx, cy + r * 0.9)
      ..quadraticBezierTo(cx - r, cy, cx, cy - r * 0.9)
      ..close();
    c.drawPath(path, Paint()..color = const Color(0xFF40916C));
    c.drawCircle(Offset(cx, cy + r * 0.15), r * 0.35, Paint()..color = const Color(0xFF8B5E3C));
    c.drawCircle(Offset(cx, cy + r * 0.15), r * 0.2, Paint()..color = const Color(0xFF6B4226));
  }

  void _drawPomegranate(Canvas c, double cx, double cy, double r) {
    c.drawCircle(Offset(cx, cy), r, Paint()..color = const Color(0xFF9D0208));
    for (var i = 0; i < 5; i++) {
      final angle = -math.pi / 2 + i * 2 * math.pi / 5;
      c.drawCircle(
        Offset(cx + math.cos(angle) * r * 0.55, cy + math.sin(angle) * r * 0.55),
        r * 0.12, Paint()..color = const Color(0xFFE63946),
      );
    }
    c.drawCircle(Offset(cx, cy - r * 0.75), r * 0.12, Paint()..color = const Color(0xFF40916C));
  }

  void _drawFig(Canvas c, double cx, double cy, double r) {
    c.drawCircle(Offset(cx, cy + r * 0.1), r * 0.85, Paint()..color = const Color(0xFF7B2CBF));
    c.drawOval(Rect.fromCenter(center: Offset(cx, cy - r * 0.55), width: r * 0.3, height: r * 0.2),
        Paint()..color = const Color(0xFF40916C));
  }

  void _drawPapaya(Canvas c, double cx, double cy, double r) {
    c.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: r * 1.1, height: r * 1.5),
        Paint()..color = const Color(0xFFFF9F1C));
    c.drawOval(Rect.fromCenter(center: Offset(cx, cy + r * 0.1), width: r * 0.6, height: r * 0.8),
        Paint()..color = const Color(0xFFE63946).withValues(alpha: 0.6));
  }

  void _drawCircle(Canvas c, double cx, double cy, double r, Color main, Color highlight) {
    c.drawCircle(Offset(cx, cy), r, Paint()..color = main);
    c.drawCircle(Offset(cx - r * 0.25, cy - r * 0.25), r * 0.25,
        Paint()..color = highlight.withValues(alpha: 0.4));
  }

  void _drawEyes(Canvas c, double cx, double cy, double eyeR) {
    c.drawCircle(Offset(cx - eyeR * 1.8, cy), eyeR, Paint()..color = const Color(0xFF1B4332));
    c.drawCircle(Offset(cx + eyeR * 1.8, cy), eyeR, Paint()..color = const Color(0xFF1B4332));
    c.drawCircle(Offset(cx - eyeR * 1.8 + eyeR * 0.3, cy - eyeR * 0.3), eyeR * 0.35,
        Paint()..color = Colors.white);
    c.drawCircle(Offset(cx + eyeR * 1.8 + eyeR * 0.3, cy - eyeR * 0.3), eyeR * 0.35,
        Paint()..color = Colors.white);
  }

  void _drawBall(Canvas c, double cx, double cy, double r, Color main, Color line, int lines) {
    c.drawCircle(Offset(cx, cy), r, Paint()..color = main);
    final linePaint = Paint()
      ..color = line
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.06;
    for (var i = 0; i < lines; i++) {
      final angle = i * math.pi / lines;
      c.drawArc(
        Rect.fromCenter(center: Offset(cx, cy), width: r * 1.6, height: r * 1.6),
        angle, math.pi * 0.6, false, linePaint,
      );
    }
  }

  void _drawStar(Canvas c, double cx, double cy, double r, Color color) {
    final path = Path();
    for (var i = 0; i < 5; i++) {
      final outerAngle = -math.pi / 2 + i * 2 * math.pi / 5;
      final innerAngle = outerAngle + math.pi / 5;
      if (i == 0) {
        path.moveTo(cx + math.cos(outerAngle) * r, cy + math.sin(outerAngle) * r);
      } else {
        path.lineTo(cx + math.cos(outerAngle) * r, cy + math.sin(outerAngle) * r);
      }
      path.lineTo(cx + math.cos(innerAngle) * r * 0.45, cy + math.sin(innerAngle) * r * 0.45);
    }
    path.close();
    c.drawPath(path, Paint()..color = color);
  }

  void _drawCloud(Canvas c, double cx, double cy, double r) {
    final paint = Paint()..color = Colors.white;
    c.drawCircle(Offset(cx - r * 0.4, cy), r * 0.55, paint);
    c.drawCircle(Offset(cx + r * 0.35, cy - r * 0.1), r * 0.5, paint);
    c.drawCircle(Offset(cx, cy - r * 0.25), r * 0.6, paint);
    c.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, cy + r * 0.15), width: r * 1.8, height: r * 0.6),
        Radius.circular(r * 0.3),
      ),
      paint,
    );
  }

  void _drawFlower(Canvas c, double cx, double cy, double r, Color color) {
    for (var i = 0; i < 6; i++) {
      final angle = i * math.pi / 3;
      c.drawCircle(
        Offset(cx + math.cos(angle) * r * 0.45, cy + math.sin(angle) * r * 0.45),
        r * 0.35, Paint()..color = color,
      );
    }
    c.drawCircle(Offset(cx, cy), r * 0.25, Paint()..color = const Color(0xFFFFD166));
    c.drawLine(Offset(cx, cy + r * 0.5), Offset(cx, cy + r * 0.9),
        Paint()..color = const Color(0xFF40916C)..strokeWidth = r * 0.08..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(covariant _CardFacePainter oldDelegate) =>
      oldDelegate.symbolId != symbolId || oldDelegate.category != category;
}
