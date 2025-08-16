import 'package:flutter/material.dart';
import 'dart:math' show pi;

class RotatingContainerScreen extends StatefulWidget {
  const RotatingContainerScreen({super.key});

  @override
  State<RotatingContainerScreen> createState() => _RotatingContainerScreenState();
}

/*
    In this example i will rotate the container 360 degrees in any direction like x-axis, y-axs and z-axis
*/

class _RotatingContainerScreenState extends State<RotatingContainerScreen> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation _animation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
      duration: Duration(seconds: 3)
    )..repeat();

    _animation = Tween(begin: 0.0, end: 2 * pi).animate(_controller);
    _scaleAnimation = Tween(begin: 0.5, end: 1.5).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
    );
    _colorAnimation = ColorTween(begin: Colors.blue, end: Colors.red).animate(_controller);

    super.initState();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context,child){
            return Transform(
              transform: Matrix4.identity()
              /*
              here we can rotate the container in any direction change
              function and rotate according to you
              ..rotateZ(_animation.value)  for z-axis
              ..rotateX(_animation.value)  for x-axis
              ..rotateY(_animation.value)  for y-axis
              */
                ..rotateZ(_animation.value),
              alignment: Alignment.center,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color : Colors.black54,
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: Offset(0, 7)
                      )
                    ]
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
