import 'package:flutter/material.dart';
import 'package:session/data.dart';
import 'package:session/profile.dart';

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int _currentInd = 0;
  final List<Widget> _children = [
    DataScreen(),
    Profile(),
  ];
  _onTapTab(int index){
    setState(() {
      _currentInd = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ,
      ),
      body: _children[_currentInd],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTapTab,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(title: Text("Data"), icon: Icon(Icons.people)),
          BottomNavigationBarItem(title: Text("Profile"), icon: Icon(Icons.person))
        ],
      ),
    );
  }
}
