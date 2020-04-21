//colors
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

const kRedAccentCostum = 0xffFE3C52;
const kRedDark = 0xffE82B41;

//navBar
CurvedNavigationBar buildCurvedNavigationBar() {
  return CurvedNavigationBar(
      items: [
        Icon(Icons.list, size: 30),
        Icon(Icons.add, size: 30),
        Icon(Icons.compare_arrows, size: 30),
      ],
      backgroundColor: Color(kRedAccentCostum),
      height: 50,
      onTap: (value) => print(value),
      animationDuration: Duration(
        milliseconds: 300,
      ));
}
