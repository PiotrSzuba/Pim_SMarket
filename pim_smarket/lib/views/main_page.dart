import 'package:flutter/material.dart';
import 'package:pim_smarket/theme.dart';
import "views.dart";

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _BottomNavigator();
}

class _BottomNavigator extends State<MainPage> {
  static const List<String> _options = <String>[
    "Home",
    "Search",
    "Add",
    "Profile"
  ];
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(title: _options[0]),
    SearchPage(title: _options[1]),
    AddPage(title: _options[2]),
    ProfilePage(title: _options[3]),
  ];

  int _selectedIndex = 0;
  String _title = _options[0];

  void _onItemTapped(int index) {
    setState(() {
      _title = _options[index];
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title, style: CustomTheme.blackText),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: _options[0],
              backgroundColor: CustomTheme.pinkMaterial),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: _options[1],
            backgroundColor: CustomTheme.pinkMaterial,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            label: _options[2],
            backgroundColor: CustomTheme.pinkMaterial,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: _options[3],
            backgroundColor: CustomTheme.pinkMaterial,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
