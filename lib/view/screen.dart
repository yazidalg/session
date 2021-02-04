import 'package:flutter/material.dart';
import 'package:session/view/data.dart';
import 'package:session/view/home.dart';
import 'package:session/view/profile.dart';

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int _currentInd = 0;
  final List<Widget> _children = [
    HomeScreen(),
    Profile(),
    DataScreen()
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
        title: Text("Application"),
      ),
      body: _children[_currentInd],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTapTab,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(title: Text("Home"), icon: Icon(Icons.home)),
          BottomNavigationBarItem(title: Text("Profile"), icon: Icon(Icons.person, color: Colors.blue,)),
          BottomNavigationBarItem(title: Text("Data"),icon: Icon(Icons.people))
        ],
      ),
    );
  }
}

