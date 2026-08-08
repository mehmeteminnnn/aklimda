import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/page_transitions.dart';
import '../utils/theme.dart';
import '../widgets/garden_background.dart';
import '../widgets/illustrations/game_glyph.dart';
import 'splash_screen.dart';

class TutorialScreen extends StatefulWidget { const TutorialScreen({super.key}); @override State<TutorialScreen> createState() => _TutorialScreenState(); }
class _TutorialScreenState extends State<TutorialScreen> {
  final _controller = PageController(); int _page = 0;
  static const _pages = [(GameGlyphType.players, 'Oyuncular', 'Sırayla iki kart açın ve en çok çifti bulan oyuncu olun.'), (GameGlyphType.hourglass, 'Süreyi yönet', 'Her hamle için kalan süreyi pill göstergesinden takip edin.'), (GameGlyphType.cards, 'Çiftleri bul', 'Kartlardaki özel bahçe illüstrasyonlarını eşleştirin.'), (GameGlyphType.sprout, 'Bahçeyi tamamla', 'Her doğru eşleşme bahçeyi biraz daha canlandırır.')];
  Future<void> _finish() async { final prefs = await SharedPreferences.getInstance(); await prefs.setBool('isFirstTime', false); if (mounted) Navigator.of(context).pushReplacement(AppPageTransitions.fade(const SplashScreen())); }
  @override void dispose() { _controller.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(body: SafeArea(child: GardenBackground(child: Stack(children: [
    PageView.builder(controller:_controller, itemCount:_pages.length, onPageChanged:(value)=>setState(()=>_page=value), itemBuilder:(context,index) { final item=_pages[index]; return Padding(padding: const EdgeInsets.all(30), child: Column(mainAxisAlignment: MainAxisAlignment.center, children:[
      Container(width:136,height:136,decoration:BoxDecoration(color:Colors.white.withValues(alpha:.78),shape:BoxShape.circle,boxShadow:[BoxShadow(color:AppColors.forest.withValues(alpha:.14),blurRadius:20,offset:const Offset(0,8))]),child:Center(child:GameGlyph(type:item.$1,color:AppColors.moss,size:74))),
      const SizedBox(height:36), Text(item.$2,style:Theme.of(context).textTheme.displayMedium,textAlign:TextAlign.center), const SizedBox(height:14), Text(item.$3,style:Theme.of(context).textTheme.bodyLarge?.copyWith(height:1.5),textAlign:TextAlign.center),
    ])); }),
    Positioned(left:24,right:24,bottom:24,child:Column(children:[Row(mainAxisAlignment:MainAxisAlignment.center,children:List.generate(_pages.length,(i)=>AnimatedContainer(duration:const Duration(milliseconds:200),margin:const EdgeInsets.all(4),width:i==_page?22:8,height:8,decoration:BoxDecoration(color:i==_page?AppColors.moss:AppColors.meadow,borderRadius:BorderRadius.circular(9))))),const SizedBox(height:16),SizedBox(width:double.infinity,height:52,child:ElevatedButton(onPressed:_page==_pages.length-1?_finish:()=>_controller.nextPage(duration:const Duration(milliseconds:350),curve:Curves.easeOutCubic),child:Text(_page==_pages.length-1?'Bahçeye Başla':'Devam Et')))]))
  ]))));
}
