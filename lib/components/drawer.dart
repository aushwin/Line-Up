import 'package:flutter/material.dart';
import 'package:line_up/screens/login_screen.dart';
import 'package:line_up/screens/main_screen.dart';
import 'package:line_up/screens/menu.dart';

var maxSlide = 225;
bool onChangeDrag;

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
  }

  @override
  Widget build(BuildContext context) {
    var myDrawer = Menu();
    var myChild = LoginScreen();
    return GestureDetector(
      onHorizontalDragStart: (details) {
        print("details = ${details.globalPosition.dx}");
        bool fromLeftDrag =
            animationController.isDismissed && details.globalPosition.dx < 100;
        bool fromRightDrag =
            animationController.isCompleted && details.globalPosition.dx < 400;
        onChangeDrag = fromLeftDrag || fromRightDrag;
      },
      onHorizontalDragUpdate: (details) {
        print("details.delta = ${details.primaryDelta}");
        if (onChangeDrag) {
          double delta = details.primaryDelta / 400;
          animationController.value += delta;
          if (details.primaryDelta > 0) {
            animationController.forward();
          } else
            animationController.reverse();
        }
      },
      child: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          var slide = maxSlide * animationController.value;
          var scale = 1 - (animationController.value * 0.3);
          return Scaffold(
            body: Stack(
              children: [
                myDrawer,
                Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    child: myChild),
              ],
            ),
          );
        },
      ),
    );
  }
}
