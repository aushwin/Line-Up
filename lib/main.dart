import 'package:flutter/material.dart';

var maxSlide = 225.0;
void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  bool canBeDragged;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  @override
  Widget build(BuildContext context) {
    var myDrawer = Container(color: Colors.blue);
    var myChild = Container(color: Colors.yellow);
    return GestureDetector(
      onHorizontalDragStart: (details) {
        print("animation status ${animationController.status}");
        bool openLeft =
            animationController.isDismissed && details.globalPosition.dx < 100;
        bool closeRight =
            animationController.isCompleted && details.globalPosition.dx > 100;
        canBeDragged = openLeft || closeRight;
        print(details.globalPosition.dx);
      },
      onHorizontalDragUpdate: (details) {
        if (canBeDragged) {
          print("details.primary delta ${details.primaryDelta}");
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
          builder: (context, _) {
            double slide = maxSlide * animationController.value;
            double scale = 1 - (animationController.value * 0.3);
            return Scaffold(
              body: Stack(
                children: [
                  myDrawer,
                  Transform(
                    transform: Matrix4.identity()
                      ..scale(scale)
                      ..translate(slide),
                    alignment: Alignment.centerLeft,
                    child: myChild,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
