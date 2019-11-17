import 'package:flutter/material.dart';
import 'dart:math';

class FondoApp extends StatelessWidget {

  final gradiente = Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: FractionalOffset(0.0, 0.6),
        end: FractionalOffset(0.0, 1.0),
        colors: [
          Color.fromRGBO(52, 54, 101, 1.0),
          Color.fromRGBO(35, 37, 57, 1.0)
        ]
      )
    ),
  );

  final rosa = Transform.rotate(
    angle: -pi/5.0,
    child: Container(
      width: 340,
      height: 340,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80.0),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(236, 98, 188, 1.0),
            Color.fromRGBO(241, 142, 172, 1.0)
          ]
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: -100,
          child: rosa,
        ),
        Container(
          padding: EdgeInsets.only(top: 110.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_outline, color:Colors.white, size: 80.0),
              SizedBox(height: 5.0, width: double.infinity ),
            ],
          ),
        )
      ],
    );
  }
}