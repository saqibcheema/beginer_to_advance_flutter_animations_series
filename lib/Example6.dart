import 'package:flutter/material.dart';
import 'dart:math'show pi,cos,sin;

class PolygonPainter extends CustomPainter{
  final sides;
  PolygonPainter({required this.sides});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
        ..color = Colors.blue
      ..strokeWidth = 3
      ..strokeCap= StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width/2, size.height/2);
    final radius = size.width/2;
    final angle = 2 * pi / sides;

    final path = Path();
    path.moveTo(center.dx + radius * cos(0), center.dy + radius * sin(0));
    final angles = List.generate(sides, (index) => angle * index);

    for(var angle in angles){
      path.lineTo(center.dx + radius*cos(angle),center.dy + radius * sin(angle));
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is PolygonPainter && oldDelegate.sides != sides;

}

class PolygonAnimation extends StatefulWidget {
  const PolygonAnimation({super.key});

  @override
  State<PolygonAnimation> createState() => _PolygonAnimationState();
}

class _PolygonAnimationState extends State<PolygonAnimation> with TickerProviderStateMixin{

  late AnimationController _sidesController;
  late Animation<int> _sidesAnimation;
  late AnimationController _sizeController;
  late Animation<double> _sizeAnimation;
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _sidesController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _sidesAnimation = IntTween(begin: 3, end: 10).animate(_sidesController);

    _sizeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _sizeAnimation = Tween<double>(begin: 50, end: 400).chain(CurveTween(curve: Curves.bounceInOut)).animate(_sizeController);

    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).chain(CurveTween(curve: Curves.easeInOut)).animate(_rotationController);
  }

  @override
  void dispose() {
    _sizeController.dispose();
    _sidesController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _rotationController.repeat(reverse: true);
    _sizeController.repeat(reverse: true);
    _sidesController.repeat(reverse: true);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _sidesController,
            _sizeController,
            _rotationController,
          ]),
          builder: (context,child){
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(_rotationAnimation.value)
                ..rotateY(_rotationAnimation.value)
                ..rotateZ(_rotationAnimation.value),
              child: CustomPaint(
                painter: PolygonPainter(sides: _sidesAnimation.value),
                child: SizedBox(
                  height: _sizeAnimation.value,
                  width: _sizeAnimation.value,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
