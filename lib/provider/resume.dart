import 'package:flutter/material.dart';
import 'package:nuevo_projecto/colores.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Resume extends StatelessWidget {
  
  const Resume({super.key});

  @override
  Widget build(BuildContext context) {

    
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: '6s6K2A77D6s',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment:MainAxisAlignment.end, children: [
           Container(height: size.height*0.9,decoration: BoxDecoration(color: Colores.azulLogo,borderRadius: const BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),),
          child: Column(children: [Row(children: [SizedBox(width: size.width*.85,height: 30,),IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.close,color: Colors.white,size: 30,))],),SizedBox(height: 30,),SizedBox(width:size.width*.9,child: YoutubePlayer(controller: _controller,showVideoProgressIndicator: true,progressIndicatorColor: Colors.redAccent,)),],),),
        
        
       ], ),
      ),
    );
  }
}