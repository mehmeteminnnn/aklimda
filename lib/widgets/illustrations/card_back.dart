import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../utils/theme.dart';

/// Özel kart arkası — bahçe/yaprak deseni
class CardBackIllustration extends StatelessWidget {
  const CardBackIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CardBackPainter(),
      size: Size.infinite,
    );
  }
}

class _CardBackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final r = size.shortestSide;

    // Gradient arka plan
    final bgRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.cardBackDark, AppColors.cardBackLight, AppColors.moss],
      ).createShader(bgRect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(bgRect, Radius.circular(r * 0.08)),
      bgPaint,
    );

    // Dekoratif yaprak desenleri
    final leafPaint = Paint()..color = Colors.white.withValues(alpha: 0.08);
    for (var i = 0; i < 6; i++) {
      final angle = i * math.pi / 3;
      final lx = size.width / 2 + math.cos(angle) * size.width * 0.25;
      final ly = size.height / 2 + math.sin(angle) * size.height * 0.25;
      _drawLeaf(canvas, Offset(lx, ly), r * 0.15, angle + math.pi / 2, leafPaint);
    }

    // Merkez logo — stilize "A"
    final centerPaint = Paint()..color = Colors.white.withValues(alpha: 0.15);
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      r * 0.22,
      centerPaint,
    );

    final letterPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.04
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final lr = r * 0.12;
    canvas.drawLine(Offset(cx, cy + lr), Offset(cx - lr * 0.8, cy - lr), letterPaint);
    canvas.drawLine(Offset(cx, cy + lr), Offset(cx + lr * 0.8, cy - lr), letterPaint);
    canvas.drawLine(Offset(cx - lr * 0.4, cy - lr * 0.1), Offset(cx + lr * 0.4, cy - lr * 0.1), letterPaint);

    // Köşe süslemeleri
    final cornerPaint = Paint()
      ..color = AppColors.mint.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.015;
    final inset = r * 0.06;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(inset, inset, size.width - inset * 2, size.height - inset * 2),
        Radius.circular(r * 0.06),
      ),
      cornerPaint,
    );
  }

  void _drawLeaf(Canvas canvas, Offset center, double size, double angle, Paint paint) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    final path = Path()
      ..moveTo(0, -size)
      ..quadraticBezierTo(size * 0.8, 0, 0, size)
      ..quadraticBezierTo(-size * 0.8, 0, 0, -size)
      ..close();
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
