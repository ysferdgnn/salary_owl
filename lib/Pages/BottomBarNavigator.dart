import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:salary_owl/Pages/mainPage.dart';

import 'addDetailPage.dart';

class BottomBarNavigator extends StatefulWidget {
  @override
  _BottomBarNavigatorState createState() => _BottomBarNavigatorState();
}

class _BottomBarNavigatorState extends State<BottomBarNavigator> {

  int _pagestate=0;
  var NaviPages=[MainPage(),AddDetailPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NaviPages[_pagestate],

        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.flip,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.add, title: 'Discovery'),
          ],
          onTap: (int i) {
              setState(() {
                _pagestate=i;
              });

             }

        )
    );
  }
}

