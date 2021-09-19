import 'package:flutter/material.dart';

class Mypixel extends StatelessWidget {
  final innerColor;
  final outerColor;
  final child;

Mypixel({this.innerColor, this.outerColor, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
              padding: EdgeInsets.all(4),
            color: outerColor, 
            child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: innerColor, 
            child: Center(child: child,),
          ),
        )
          ),
        ));
  }
}
