import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../utils/page_transitions.dart';
import '../utils/theme.dart';
import '../widgets/garden_background.dart';
import '../widgets/illustrations/game_glyph.dart';
import 'game_setup_screen.dart';
class ResultScreen extends StatelessWidget { const ResultScreen({super.key}); @override Widget build(BuildContext context) { final winner=context.read<GameProvider>().getWinner(); return Scaffold(body:SafeArea(child:GardenBackground(child:Center(child:Padding(padding:const EdgeInsets.all(28),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Container(width:120,height:120,decoration:const BoxDecoration(color:Color(0xFFFFF4C4),shape:BoxShape.circle),child:const Center(child:GameGlyph(type:GameGlyphType.trophy,color:AppColors.earth,size:66))),const SizedBox(height:24),Text(winner==null?'Berabere!':'Kazanan',style:Theme.of(context).textTheme.headlineMedium),const SizedBox(height:8),Text(winner?.name??'Harika oyun',style:Theme.of(context).textTheme.displayMedium?.copyWith(color:AppColors.moss)),const SizedBox(height:8),Text('${winner?.score??0} puan',style:Theme.of(context).textTheme.titleLarge),const SizedBox(height:30),SizedBox(width:220,height:52,child:ElevatedButton(onPressed:()=>Navigator.of(context).pushReplacement(AppPageTransitions.fade(const GameSetupScreen())),child:const Text('Yeni oyun')))]))))); } }
