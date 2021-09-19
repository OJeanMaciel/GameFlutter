import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Final extends StatefulWidget {
  @override
  _FinalState createState() => _FinalState();
}

class _FinalState extends State<Final> {
  late AudioPlayer som;
  @override
  void initState() {
    super.initState();
    som = AudioPlayer();
  }

  @override
  void dispose() {
    som.dispose();
    super.dispose();
  }

  // Rotas

  void home() async {
    await som.setAsset('lib/sons/loseitem.ogg');
    som.play();
    Navigator.of(context).pushNamed('/');
  }

// ambientação do app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("lib/imagens/labirinto.png"), fit: BoxFit.cover),
      ),
      child: Center (
        child: GestureDetector(
        onTap: home,       
        child: Text(
          "Home",
          style: TextStyle(color: Colors.white, fontSize: 40,),
        ))
        ),
    ));
  }
}
