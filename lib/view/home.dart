import 'package:flutter/material.dart';
import 'package:kagyo/view/todo.dart';

import 'calender.dart';
import 'import.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  final List<Widget> _screens = const [Todo(), Calendar(), Import()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'カレンダー'),
          BottomNavigationBarItem(
              icon: Icon(Icons.import_export), label: 'インポート'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}