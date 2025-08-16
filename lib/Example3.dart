import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Example3 extends StatefulWidget {
  const Example3({super.key});

  @override
  State<Example3> createState() => _Example3State();
}

/*
    In this example i will rotate the container 360 degrees
    in all directions like x-axis, y-axs and z-axis
*/

class _Example3State extends State<Example3> with TickerProviderStateMixin {
  final heightAndWidth = 100.0;
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _tween;

  @override
  void initState() {
    super.initState();
    _xController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    )..repeat();
    _yController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 40),
    )..repeat();
    _zController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 50),
    )..repeat();

    _tween = Tween<double>(begin: 0.0, end: 2 * pi);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              AnimatedBuilder(
                animation: Listenable.merge([
                  _xController,
                  _yController,
                  _zController,
                ]),
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateX(_tween.evaluate(_xController))
                      ..rotateY(_tween.evaluate(_yController))
                      ..rotateZ(_tween.evaluate(_zController)),
                    child: Stack(
                      children: [
                        //Back side of the 3d Box
                        Transform(
                          alignment : Alignment.center,
                          transform: Matrix4.identity()..translate(Vector3(0,0,-heightAndWidth)),
                          child: Container(
                            width: heightAndWidth,
                            height: heightAndWidth,
                            color: Colors.teal,
                          ),
                        ),

                        //Left Side of the 3d Box
                        Transform(
                          alignment : Alignment.centerLeft,
                          transform: Matrix4.identity()..rotateY(pi/2),
                          child: Container(
                            width: heightAndWidth,
                            height: heightAndWidth,
                            color: Colors.blue,
                          ),
                        ),

                        //Right Side of the 3d Box
                        Transform(
                          alignment : Alignment.centerRight,
                          transform: Matrix4.identity()..rotateY(-pi/2),
                          child: Container(
                            width: heightAndWidth,
                            height: heightAndWidth,
                            color: Colors.yellow,
                          ),
                        ),

                        //Bottom Side of the 3d Box
                        Transform(
                          alignment : Alignment.bottomCenter,
                          transform: Matrix4.identity()..rotateX(pi/2),
                          child: Container(
                            width: heightAndWidth,
                            height: heightAndWidth,
                            color: Colors.brown,
                          ),
                        ),

                         //Front Side of the 3d Box
                         Container(
                            width: heightAndWidth,
                            height: heightAndWidth,
                            color: Colors.green,
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
