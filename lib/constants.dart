//colors
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

const kRedAccentCostum = 0xffFE3C52;
const kRedDark = 0xffE82B41;

//navBar
CurvedNavigationBar buildCurvedNavigationBar(Function onPressed) {
  return CurvedNavigationBar(
      items: [
        Icon(Icons.list, size: 30),
        Icon(Icons.add, size: 30),
        Icon(Icons.compare_arrows, size: 30),
      ],
      backgroundColor: Color(kRedAccentCostum),
      height: 50,
      onTap: onPressed,
      animationDuration: Duration(
        milliseconds: 600,
      ));
}

//Textfield decoration
InputDecoration buildInputDecoration() {
  return InputDecoration(
    hintText: 'add ToDo Here',
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.red.shade900,
      ),
    ),
    prefixIcon: Icon(Icons.check),
    filled: true,
    fillColor: Colors.redAccent,
  );
}
