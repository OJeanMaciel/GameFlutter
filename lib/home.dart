import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {

//Rotas
 void home() async{
     Navigator.of(context).pushNamed('picture');
  }

  @override
  Widget build(BuildContext context){
   return Scaffold(
    backgroundColor: Colors.lightBlueAccent[100],
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Image.asset('lib/imagens/pacman.png'),
          const SizedBox(height: 24),
          Text (
            'Labirynth Wall!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => home(),            
            child: const Icon(Icons.camera_alt_outlined),
          ),           
          Spacer(),
      ],),
    ),
  );
}
}