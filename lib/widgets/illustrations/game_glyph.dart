import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Small, original line illustrations used in controls instead of platform glyphs.
class GameGlyph extends StatelessWidget {
  final GameGlyphType type;
  final Color color;
  final double size;

  const GameGlyph({super.key, required this.type, required this.color, this.size = 28});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
        child: CustomPaint(painter: _GlyphPainter(type, color)),
      );
}

enum GameGlyphType { players, hourglass, cards, sprout, play, trophy, info, person }

class _GlyphPainter extends CustomPainter {
  final GameGlyphType type;
  final Color color;
  _GlyphPainter(this.type, this.color);

  @override
  void paint(Canvas canvas, Size s) {
    final p = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = s.width * .09..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round;
    final fill = Paint()..color = color..style = PaintingStyle.fill;
    final c = Offset(s.width / 2, s.height / 2);
    switch (type) {
      case GameGlyphType.players:
        canvas.drawCircle(Offset(s.width * .36, s.height * .34), s.width * .14, p);
        canvas.drawCircle(Offset(s.width * .67, s.height * .4), s.width * .11, p);
        canvas.drawArc(Rect.fromLTWH(s.width * .14, s.height * .46, s.width * .47, s.height * .38), math.pi, math.pi, false, p);
        canvas.drawArc(Rect.fromLTWH(s.width * .5, s.height * .52, s.width * .3, s.height * .25), math.pi, math.pi, false, p);
        break;
      case GameGlyphType.hourglass:
        canvas.drawLine(Offset(s.width*.25,s.height*.16), Offset(s.width*.75,s.height*.16), p);
        canvas.drawLine(Offset(s.width*.25,s.height*.84), Offset(s.width*.75,s.height*.84), p);
        canvas.drawLine(Offset(s.width*.33,s.height*.18), Offset(s.width*.67,s.height*.82), p);
        canvas.drawLine(Offset(s.width*.67,s.height*.18), Offset(s.width*.33,s.height*.82), p);
        canvas.drawCircle(c, s.width*.055, fill);
        break;
      case GameGlyphType.cards:
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(s.width*.17,s.height*.14,s.width*.5,s.height*.62), Radius.circular(s.width*.08)), p);
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(s.width*.33,s.height*.27,s.width*.5,s.height*.62), Radius.circular(s.width*.08)), p);
        break;
      case GameGlyphType.sprout:
        canvas.drawLine(Offset(c.dx,s.height*.84), Offset(c.dx,s.height*.4), p);
        canvas.drawOval(Rect.fromCenter(center: Offset(s.width*.36,s.height*.42), width:s.width*.42,height:s.height*.25), p);
        canvas.drawOval(Rect.fromCenter(center: Offset(s.width*.64,s.height*.28), width:s.width*.42,height:s.height*.25), p);
        break;
      case GameGlyphType.play:
        final path = Path()..moveTo(s.width*.32,s.height*.2)..lineTo(s.width*.79,s.height*.5)..lineTo(s.width*.32,s.height*.8)..close();
        canvas.drawPath(path, fill);
        break;
      case GameGlyphType.trophy:
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(s.width*.3,s.height*.15,s.width*.4,s.height*.38), Radius.circular(s.width*.08)), p);
        canvas.drawArc(Rect.fromLTWH(s.width*.1,s.height*.22,s.width*.25,s.height*.25), -math.pi/2, math.pi, false,p);
        canvas.drawArc(Rect.fromLTWH(s.width*.65,s.height*.22,s.width*.25,s.height*.25), math.pi/2, math.pi, false,p);
        canvas.drawLine(Offset(c.dx,s.height*.53),Offset(c.dx,s.height*.76),p);
        canvas.drawLine(Offset(s.width*.3,s.height*.78),Offset(s.width*.7,s.height*.78),p);
        break;
      case GameGlyphType.info:
        canvas.drawCircle(c, s.width*.36,p); canvas.drawCircle(Offset(c.dx,s.height*.34),s.width*.035,fill); canvas.drawLine(Offset(c.dx,s.height*.46),Offset(c.dx,s.height*.68),p);
        break;
      case GameGlyphType.person:
        canvas.drawCircle(Offset(c.dx,s.height*.32), s.width*.14,p); canvas.drawArc(Rect.fromLTWH(s.width*.2,s.height*.48,s.width*.6,s.height*.36),math.pi,math.pi,false,p);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _GlyphPainter old) => old.type != type || old.color != color;
}
