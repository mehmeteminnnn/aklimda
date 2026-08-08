import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../providers/language_provider.dart';
import '../utils/card_assets.dart';
import '../utils/page_transitions.dart';
import '../utils/theme.dart';
import '../widgets/garden_background.dart';
import '../widgets/illustrations/card_face_illustration.dart';
import '../widgets/illustrations/game_glyph.dart';
import 'game_screen.dart';

class GameSetupScreen extends StatefulWidget { const GameSetupScreen({super.key}); @override State<GameSetupScreen> createState() => _GameSetupScreenState(); }
class _GameSetupScreenState extends State<GameSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  int _playerCount = 2, _timeLimit = 30, _totalCards = 16;
  late List<TextEditingController> _names;
  @override void initState() { super.initState(); _names = List.generate(2, (i) => TextEditingController(text: 'Oyuncu ${i + 1}')); }
  void _changePlayers(int value) { setState(() { _playerCount = value; if (_names.length < value) { _names.addAll(List.generate(value - _names.length, (i) => TextEditingController(text:'Oyuncu ${_names.length + i + 1}'))); } else { for(final c in _names.sublist(value)) { c.dispose(); } _names = _names.take(value).toList(); } }); }
  void _start() { if (!_formKey.currentState!.validate()) { return; } final players = _names.map((c) => c.text.trim()).toList(); Navigator.of(context).pushReplacement(AppPageTransitions.slideUp(GameScreen(playerNames: players, cardCount: _totalCards, timeLimit: _timeLimit))); }
  @override void dispose() { for(final c in _names) { c.dispose(); } super.dispose(); }
  @override Widget build(BuildContext context) {
    final language = context.watch<LanguageProvider>(); final set = context.watch<GameProvider>().selectedCardSet;
    return Scaffold(body: SafeArea(child: GardenBackground(child: Form(key:_formKey,child:ListView(padding:const EdgeInsets.fromLTRB(20,16,20,28),children:[
      Row(children:[const GameGlyph(type:GameGlyphType.sprout,color:AppColors.moss,size:32),const SizedBox(width:10),Expanded(child:Text(language.getText('game_settings'),style:Theme.of(context).textTheme.headlineMedium)),SizedBox(width:48,height:48,child:IconButton(onPressed:_showHelp,icon:const GameGlyph(type:GameGlyphType.info,color:AppColors.forest))) ]),
      const SizedBox(height:18), _Panel(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[_Label('Oyuncu sayısı', GameGlyphType.players),const SizedBox(height:12),_ChoiceRow(values:const [2,3,4,5,6,7,8],selected:_playerCount,label:(v)=>'$v',onSelected:_changePlayers)])),
      const SizedBox(height:12), _Panel(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[_Label('Hamle süresi', GameGlyphType.hourglass),const SizedBox(height:12),_ChoiceRow(values:const [15,30,45,60],selected:_timeLimit,label:(v)=>'$v sn',onSelected:(v)=>setState(()=>_timeLimit=v))])),
      const SizedBox(height:12),
      _Panel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Label('Kart seti', GameGlyphType.cards),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: GameProvider.cardSets.keys
                  .map((name) => ChoiceChip(
                        label: Text(name),
                        selected: set == name,
                        onSelected: (_) =>
                            context.read<GameProvider>().setCardSet(name),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 58,
              child: Row(
                children: GameProvider.cardSets[set]!
                    .take(5)
                    .map((id) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: CardFaceIllustration(
                                symbolId: id,
                                category: CardAssets.categoryForSet(set),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height:12), _Panel(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[_Label('Zorluk', GameGlyphType.cards),const SizedBox(height:12),_ChoiceRow(values:const [16,24,36],selected:_totalCards,label:(v)=>'$v kart',onSelected:(v)=>setState(()=>_totalCards=v))])),
      const SizedBox(height:16), Text('Oyuncular',style:Theme.of(context).textTheme.titleLarge),const SizedBox(height:8),...List.generate(_playerCount,(i)=>Padding(padding:const EdgeInsets.only(bottom:10),child:TextFormField(controller:_names[i],textCapitalization:TextCapitalization.words,decoration:InputDecoration(prefixIcon:const Padding(padding:EdgeInsets.all(10),child:GameGlyph(type:GameGlyphType.person,color:AppColors.moss,size:24)),labelText:'Oyuncu ${i+1}',filled:true,fillColor:Colors.white.withValues(alpha:.92),border:OutlineInputBorder(borderRadius:BorderRadius.circular(16),borderSide:BorderSide.none)),validator:(value)=>value==null||value.trim().isEmpty?'Bir isim girin':null))),
      const SizedBox(height:8),SizedBox(height:54,child:ElevatedButton(onPressed:_start,child:Row(mainAxisAlignment:MainAxisAlignment.center,children:[const GameGlyph(type:GameGlyphType.play,color:Colors.white,size:24),const SizedBox(width:10),Text(language.getText('start_game'))])))
    ])))));
  }
  void _showHelp() => showDialog(context:context,builder:(context)=>AlertDialog(title:Text('Nasıl oynanır?',style:Theme.of(context).textTheme.titleLarge),content:const Text('Sıranızdayken iki kart açın. Aynı illüstrasyonlara sahip kartlar eşleşir, puan kazanır ve sıranıza devam edersiniz. Hatalı eşleşmede sıra diğer oyuncuya geçer.'),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('Anladım'))]));
}
class _Panel extends StatelessWidget { final Widget child; const _Panel({required this.child}); @override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:Colors.white.withValues(alpha:.88),borderRadius:BorderRadius.circular(20),border:Border.all(color:Colors.white),boxShadow:[BoxShadow(color:AppColors.forest.withValues(alpha:.09),blurRadius:16,offset:const Offset(0,6))]),child:child); }
class _Label extends StatelessWidget { final String text; final GameGlyphType glyph; const _Label(this.text,this.glyph); @override Widget build(BuildContext context)=>Row(children:[GameGlyph(type:glyph,color:AppColors.moss,size:24),const SizedBox(width:8),Text(text,style:Theme.of(context).textTheme.titleMedium)]); }
class _ChoiceRow extends StatelessWidget { final List<int> values; final int selected; final String Function(int) label; final ValueChanged<int> onSelected; const _ChoiceRow({required this.values,required this.selected,required this.label,required this.onSelected}); @override Widget build(BuildContext context)=>Wrap(spacing:8,runSpacing:8,children:values.map((v)=>ChoiceChip(label:Text(label(v)),selected:v==selected,onSelected:(_)=>onSelected(v))).toList()); }
