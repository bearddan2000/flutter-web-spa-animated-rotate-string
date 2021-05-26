import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  String text = 'Hello World';

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(
        seconds: 2,
      ),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );
    animationController.addStatusListener(animationStatusListener);
    animationController.forward();
  }


  void animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      animationController.forward();
    }
  }

  Widget _buildCircle(radius) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        color: Colors.red,
      ),
      child: Center(
        child: Text(
          text,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 24,
            color: Colors.black87,
          ),
        ),
      )
    );
  }

@override
  Widget build(BuildContext context) {
    final radius = 50.0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated Text"),
      ),
      body: AnimatedBuilder(
        child: Align(
          alignment: Alignment(0, -0.1),
          child: _buildCircle(radius),
        ),
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            child: child,
            angle: math.pi * 2 * animation.value,
            origin: Offset(0, radius),
          );
        },
      ),
    );
  }
}
