import 'dart:async';
import 'dart:math';
import 'package:appteste/path.dart';
import 'package:appteste/pixel.dart';
import 'package:appteste/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 17;
  int player = numberInRow * 15 + 1;
  
// Lista de números para criação da barreira
             
  List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    13,
    22,
    23,
    25,
    33,
    44,
    55,
    66,
    77,
    78,
    79,
    80,
    81,
    70,
    59,
    57,
    46,
    35,
    24,
    26,
    37,
    38,
    39,
    28,
    30,
    41,
    52,
    63,
    61,
    72,
    83,
    84,
    85,
    86,
    87,
    88,
    76,
    65,
    54,
    43,
    32,
    21,
    99,
    100,
    101,
    102,
    103,
    114,
    125,
    110,
    121,
    132,
    143,
    154,
    165,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    108,
    107,
    106,
    105,
    116,
    127,
    129,
    140,
    151,
    162,
    158,
    147,
    148,
    149,
    160,
    123,
    134,
    145,
    156
  ];

  List<int> food = [];

  String direction = "right";
  bool preGame = true;
  bool mouthClosed = false;

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
  void nextPhase() async{
      await som.setAsset('lib/sons/getitem.ogg');
      som.play();
     Navigator.of(context).pushReplacementNamed('phaseTwo');
  }

  void home() async{    
      await som.setAsset('lib/sons/loseitem.ogg');
      som.play();
    Navigator.of(context).pushReplacementNamed('/');
  }


  // Botão StartGame
  void startGame() async{
    preGame = false;

    if (player != 98) {
      await som.setAsset('lib/sons/music.ogg');
      som.play();        
    }  
    Timer.periodic(Duration(milliseconds: 250), (timer) {
    

      if (player == 98) {
        setState(() {
          player = numberInRow;
        AlertDialog alert = AlertDialog(
          title: Text("Você passou para próxima fase"),
          content: Text("Você Aceita?"),
          actions: [
        GestureDetector(
          onTap: nextPhase,
          child: Text(
          "Next",
          style: TextStyle(color: Colors.white, fontSize: 40),
            )),
          ],
          elevation: 24.0,
          backgroundColor: Colors.blue,
        );
            showDialog(           
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
            );   
        });
      }
               
      // Movimentação do Player/usuário
      if(player != 12){
      switch (direction) {
        case "right":
          moveRight();          
          HapticFeedback.mediumImpact();
          break;
        
        case "up":
          moveUp();
          HapticFeedback.mediumImpact();
          break;

        case "left":
          moveLeft();
          HapticFeedback.mediumImpact();
          break;

        case "down":
          moveDown();
          HapticFeedback.mediumImpact();
          break;
      }
    }
    });
  }

  void restart() {
     Navigator.of(context).pushReplacementNamed('phase');
  }
 
  void moveLeft() {
    // Função de verificar a barreira!
    if (!barriers.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  void moveRight() {
    // Função de verificar a barreira!
    if (!barriers.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  void moveUp() {
    // Função de verificar a barreira!
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  void moveDown() {
    // Função de verificar a barreira!
    if (!barriers.contains(player + numberInRow)) {
      setState(() {        
        player += numberInRow;
      });
    }
  }


// ambientação do app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            // Condição de direção
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  direction = "down";
                } else if (details.delta.dy < 0) {
                  direction = "up";
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  direction = "right";
                } else if (details.delta.dx < 0) {
                  direction = "left";
                }
              },
              child: Container(
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquares,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: numberInRow),
                    itemBuilder: (BuildContext context, int index) {
                      // Condição de verificação de Jogador/Usuário
                      // Condição de verificação de direção Jogador/Usuário
                    if (mouthClosed) {
                      return Padding(padding: EdgeInsets.all(4),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.circle
                        ),
                        ),);
                    }
                     else if (player == index) {

                       switch (direction) {
                         case "left":
                         return Transform.rotate(angle: pi,child: MyPlayer(),);
                           break;
                            
                           case "right":
                           return MyPlayer();
                           break;

                           case "up":
                           return Transform.rotate(angle: 3*pi/2,child: MyPlayer(),);
                           break;

                           case "down":
                           return Transform.rotate(angle: pi/2,child: MyPlayer(),);
                           break;
                       }

                        return MyPlayer();
                      } else if (barriers.contains(index)) {
                        return Mypixel(
                          innerColor: Colors.blue[800],
                          outerColor: Colors.blue[900],
                           //child: Text(index.toString())
                        );
                      } else {
                        return MyPath(
                          innerColor: Colors.black,
                          outerColor: Colors.black,
                           child: Text(index.toString())
                        );
                      }
                    }),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: startGame,                  
                      child: Text(
                        "Play",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                  GestureDetector(
                      onTap: home,
                      child: Text(
                        "Home",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                  GestureDetector(
                      onTap: restart,
                      child: Text(
                        "Restart",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
