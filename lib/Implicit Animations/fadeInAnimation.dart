import 'package:flutter/material.dart';

const owlUrl =
    'https://raw.githubusercontent.com/flutter/website/main/src/content/assets/images/docs/owl.jpg';


class FadeInAnimation extends StatelessWidget {
  const FadeInAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: FadeInDemo(),
        ),
    );
  }
}

class FadeInDemo extends StatefulWidget {
  const FadeInDemo({super.key});

  @override
  State<FadeInDemo> createState() => _FadeInDemoState();
}

class _FadeInDemoState extends State<FadeInDemo> {
  var _opacity = 0.0;
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Image.network(owlUrl),
      TextButton(
        child: const Text(
          'Show Details',
          style: TextStyle(color: Colors.blueAccent),
        ),
        onPressed: () => {
          setState(() {
            _opacity = 1.0;

        })
        },
      ),
      AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(seconds: 2),
        child: const Column(
          children: [
            Text('Type: Owl'),
            Text('Age: 39'),
            Text('Employment: None'),
          ],
        ),
      )
    ]);
  }
}
