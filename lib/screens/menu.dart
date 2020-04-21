import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent.shade400,
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RotatedBox(
                quarterTurns: -1,
                child: RotateAnimatedTextKit(
                    isRepeatingAnimation: true,
                    onTap: () {
                      print("Tap Event");
                    },
                    text: ["Get Your Things Done", "Tack Your Day", "LineUp"],
                    textStyle: TextStyle(
                        fontSize: 60.0,
                        fontFamily: "Horizon",
                        color: Colors.white),
                    textAlign: TextAlign.start,
                    alignment:
                        AlignmentDirectional.topStart // or Alignment.topLeft
                    ),
              ),
            ]),
      ),
    );
  }
}
