import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import '../models/player.dart';
import '../utils/theme.dart';
import 'illustrations/game_glyph.dart';

class GameOverDialog extends StatefulWidget {
  final Player? winner; final List<Player> players;
  const GameOverDialog({super.key, required this.winner, required this.players});
  @override State<GameOverDialog> createState() => _GameOverDialogState();
}
class _GameOverDialogState extends State<GameOverDialog> {
  late final ConfettiController _confetti;
  @override void initState(){super.initState();_confetti=ConfettiController(duration:const Duration(seconds:2))..play();}
  @override void dispose(){_confetti.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>Stack(children:[
    AlertDialog(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(28)),title:Column(children:[const GameGlyph(type:GameGlyphType.trophy,color:AppColors.earth,size:48),const SizedBox(height:8),Text('Bahçe tamamlandı!',style:Theme.of(context).textTheme.headlineMedium,textAlign:TextAlign.center)]),content:Column(mainAxisSize:MainAxisSize.min,children:[Text(widget.winner==null?'Bu tur beraberlikle bitti.': '${widget.winner!.name} kazandı!',style:Theme.of(context).textTheme.titleLarge?.copyWith(color:AppColors.moss),textAlign:TextAlign.center),const SizedBox(height:14),...widget.players.map((p)=>Padding(padding:const EdgeInsets.symmetric(vertical:5),child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text(p.name,style:TextStyle(fontWeight:p==widget.winner?FontWeight.w800:FontWeight.w500)),Text('${p.score} puan',style:TextStyle(color:p==widget.winner?AppColors.moss:AppColors.onSurface,fontWeight:FontWeight.w700))])))]),actions:[SizedBox(width:double.infinity,height:48,child:ElevatedButton(onPressed:()=>Navigator.of(context).pushReplacementNamed('/setup'),child:const Text('Yeni oyun')))],),
    Positioned(top:0,left:MediaQuery.of(context).size.width/2-20,child:ConfettiWidget(confettiController:_confetti,blastDirection:pi/2,numberOfParticles:20,gravity:.2,colors:const [AppColors.sun,AppColors.berry,AppColors.mint]))
  ]);
}
