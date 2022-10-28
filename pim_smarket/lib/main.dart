import 'package:flutter/material.dart';
import './theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slave market',
      theme: ThemeData(
          primaryColor: CustomTheme.pinkMaterial,
          primarySwatch: CustomTheme.pinkMaterial,
          scaffoldBackgroundColor: Colors.black87),
      home: const MyHomePage(title: 'Slave market'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _BottomNavigator();
}

class _BottomNavigator extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: CustomTheme.pinkColor);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home page',
      style: optionStyle,
    ),
    Text(
      'Search page',
      style: optionStyle,
    ),
    Text(
      'Add page',
      style: optionStyle,
    ),
    Text(
      'Profile page',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: CustomTheme.blackText),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: CustomTheme.pinkMaterial),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: CustomTheme.pinkMaterial,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'New',
            backgroundColor: CustomTheme.pinkMaterial,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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
