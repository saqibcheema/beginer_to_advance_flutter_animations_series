import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' show pi;

class DrawerThings{
  final String title;
  final IconData iconData;

  DrawerThings({required this.title,required this.iconData});
}

List<DrawerThings> drawerThings = [
  DrawerThings(title: 'Home', iconData: CupertinoIcons.home),
  DrawerThings(title: 'Favourites', iconData: CupertinoIcons.heart_circle_fill),
  DrawerThings(title: 'Log Out', iconData: CupertinoIcons.power)
];

class MyDrawer extends StatefulWidget {
  final child;
  final drawer;
  const MyDrawer({super.key, required this.drawer, required this.child});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  late AnimationController _xControllerForChild;
  late Animation _yRotationForChild;
  late AnimationController _xControllerForDrawer;
  late Animation _yRotationForDrawer;

  @override
  void initState() {
    super.initState();
    _xControllerForChild = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _yRotationForChild = Tween<double>(
      begin: 0,
      end: -pi / 2,
    ).animate(_xControllerForChild);
    _xControllerForDrawer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _yRotationForDrawer = Tween<double>(
      begin: pi / 2.7,
      end: 0,
    ).animate(_xControllerForDrawer);
  }

  @override
  void dispose() {
    _xControllerForChild.dispose();
    _xControllerForDrawer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxDrag = screenWidth * 0.8;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        _xControllerForChild.value += details.delta.dx / maxDrag;
        _xControllerForDrawer.value += details.delta.dx / maxDrag;
      },
      onHorizontalDragEnd: (details) {
        if (_xControllerForChild.value < 0.5) {
          _xControllerForChild.reverse();
          _xControllerForDrawer.reverse();
        } else {
          _xControllerForChild.forward();
          _xControllerForDrawer.forward();
        }
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _xControllerForChild,
          _xControllerForDrawer,
        ]),
        builder: (context, child) {
          return Stack(
            children: [
              Container(color: Colors.teal.shade50),
              Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(_xControllerForChild.value * maxDrag)
                  ..rotateY(_yRotationForChild.value),
                child: widget.child,
              ),
              Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(
                    -screenWidth + _xControllerForChild.value * maxDrag,
                  )
                  ..rotateY(_yRotationForDrawer.value),
                child: widget.drawer,
              ),
            ],
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      drawer: Material(
        child: Container(
          color:Colors.teal.shade400,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 100, top: 100),
            itemCount: drawerThings.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(drawerThings[index].title),
                leading: Icon(drawerThings[index].iconData),
              );
            },
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Drawer'),backgroundColor: Colors.teal.shade400,centerTitle: true,),
        body: Container(color: Colors.white),
      ),
    );
    ;
  }
}
