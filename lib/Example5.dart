import 'package:flutter/material.dart';
import 'dart:math';

class TweenAnimatedColors extends StatefulWidget {
  const TweenAnimatedColors({super.key});

  @override
  State<TweenAnimatedColors> createState() => _TweenAnimatedColorsState();
}

Color getRandomColor() => Color(
  0xFF000000 + Random().nextInt(0x00FFFFFF)
);

class _TweenAnimatedColorsState extends State<TweenAnimatedColors> {
  var _color = getRandomColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipPath(
          clipper: CircularClipper(),
          child:  TweenAnimationBuilder(
            duration: const Duration(seconds: 1),
            tween: ColorTween(begin: getRandomColor(),end: _color),
            onEnd: () => setState(() {
              _color = getRandomColor();
            }),
            builder: (context, Color? color, child) => ColorFiltered(
                colorFilter: ColorFilter.mode(color!, BlendMode.srcATop),
                    child: Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
          ),
            )
          ),
        ),
      ),
    );
  }
}

class CircularClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) =>false;
}
