import 'package:flutter/material.dart';
import 'dart:math' show pi;

class ClippedCircularAnimation extends StatefulWidget {
  const ClippedCircularAnimation({super.key});

  @override
  State<ClippedCircularAnimation> createState() =>
      _ClippedCircularAnimationState();
}

enum CircleSides { left, right }

extension ToPath on CircleSides {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;

    switch (this) {
      case CircleSides.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSides.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }

    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      clockwise: clockwise,
    );
    path.close();
    return path;
  }
}

extension on VoidCallback{
  Future<void> delayed(Duration duration){
    return Future.delayed(duration,this);
  }
}

class CircularClippers extends CustomClipper<Path> {
  final CircleSides sides;
  CircularClippers({required this.sides});

  @override
  Path getClip(Size size) => sides.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class _ClippedCircularAnimationState extends State<ClippedCircularAnimation>
    with TickerProviderStateMixin {
  late AnimationController _counterClockWiseRotationController;
  late Animation _counterClockWiseRotationAnimation;

  late AnimationController _flipController;
  late Animation _flipAnimation;

  @override
  void initState() {
    super.initState();
    _counterClockWiseRotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _counterClockWiseRotationAnimation =
        Tween<double>(begin: 0.0, end: -(pi / 2)).animate(
          CurvedAnimation(
            parent: _counterClockWiseRotationController,
            curve: Curves.bounceOut,
          ),
        );

    _flipController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1)
    );

    _flipAnimation = Tween(begin: 0.0, end: pi).animate(
        CurvedAnimation(parent: _flipController, curve: Curves.bounceOut)
    );

    _counterClockWiseRotationController.addStatusListener((status){
      if(status == AnimationStatus.completed){
        _flipAnimation = Tween(begin: _flipAnimation.value, end: _flipAnimation.value + pi).animate(
            CurvedAnimation(parent: _flipController, curve: Curves.bounceOut)
        );
        _flipController
          ..reset()
          ..forward();
      }
    });

    _flipController.addStatusListener((status){
      if(status == AnimationStatus.completed){
        _counterClockWiseRotationAnimation =
            Tween<double>(begin: _counterClockWiseRotationAnimation.value, end:_counterClockWiseRotationAnimation.value + -(pi / 2)).animate(
              CurvedAnimation(
                parent: _counterClockWiseRotationController,
                curve: Curves.bounceOut,
              ),
            );
        _counterClockWiseRotationController
          ..reset()
          ..forward();
      }
    });

  }

  
  
  @override
  void dispose() {
    _counterClockWiseRotationController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _counterClockWiseRotationController..forward();

    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _counterClockWiseRotationController,
          builder: (context, child){
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateZ(_counterClockWiseRotationAnimation.value),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _flipController,
                    builder: (context,child){
                      return Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()..rotateY(_flipAnimation.value),
                        child: ClipPath(
                          clipper: CircularClippers(sides: CircleSides.left),
                          child: Container(
                            height: 200,
                            width: 200,
                            color: Color(0xff0057b7),
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _flipController,
                    builder: (context,child){
                      return Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()..rotateY(_flipAnimation.value),
                        child: ClipPath(
                          clipper: CircularClippers(sides: CircleSides.right),
                          child: Container(
                            height: 200,
                            width: 200,
                            color: Color(0xffffd700),
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),
            );
          }

        ),
      ),
    );
  }
}
