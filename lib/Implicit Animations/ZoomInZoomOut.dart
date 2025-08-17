import 'package:flutter/material.dart';

class ZoomInZoomOut extends StatefulWidget {
  const ZoomInZoomOut({super.key});

  @override
  State<ZoomInZoomOut> createState() => _ZoomInZoomOutState();
}

class _ZoomInZoomOutState extends State<ZoomInZoomOut> {
  var _isZoomed = false;
  var actionButton = 'Zoom In';
  var defaultWidth = 100.0;
  var _curve = Curves.bounceOut;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 370),
                curve: _curve,
                width: defaultWidth,
                child: Image.asset('assets/Images/flower.png'),
              ),
            ],
          ),
          TextButton(
              onPressed: (){
                setState(() {
                  _isZoomed = !_isZoomed;
                  _isZoomed == true ? actionButton = 'Zoom Out' : actionButton = 'Zoom In';

                _isZoomed == true ? defaultWidth=MediaQuery.of(context).size.width : defaultWidth=100.0;
                _isZoomed == true ? _curve = Curves.bounceInOut : _curve = Curves.bounceOut;
                });
              },
              child: Text(actionButton)),
        ],
      ),
    );
  }
}
