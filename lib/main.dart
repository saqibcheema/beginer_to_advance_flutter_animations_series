import 'package:flutter/material.dart';
import 'CustomCircularProgress.dart';
import 'Example1.dart';
import 'Example2.dart';
import 'Example3.dart';
import 'Example4.dart';
import 'Example5.dart';
import 'Example6.dart';
import 'Implicit Animations/ShapeShifting.dart';
import 'Implicit Animations/ZoomInZoomOut.dart';
import 'Implicit Animations/fadeInAnimation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: CustomCircularProgress(),
    );
  }
}

