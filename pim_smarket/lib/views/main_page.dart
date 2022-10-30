import 'package:flutter/material.dart';
import 'package:pim_smarket/data/data.dart';
import 'package:pim_smarket/theme.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import "views.dart";

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _BottomNavigator();
}

class _BottomNavigator extends State<MainPage> {
  static const List<String> _options = <String>[
    CustomTheme.appName,
    "Search",
    "Add",
    "Profile"
  ];

  static const List<String> _optionsNoAdd = <String>[
    CustomTheme.appName,
    "Search",
    "Profile"
  ];

  int _selectedIndex = 2;
  String _title = CustomTheme.appName;

  final List<Widget> _widgetOptions = <Widget>[
    HomePage(title: _options[0]),
    SearchPage(title: _options[1]),
    AddPage(title: _options[2]),
    ProfilePage(title: _options[3]),
  ];

  final List<Widget> _widgetOptionsNoAdd = <Widget>[
    HomePage(title: _options[0]),
    SearchPage(title: _options[1]),
    ProfilePage(title: _options[3]),
  ];

  void _onItemTapped(int index, bool noAdd) {
    setState(() {
      _title = noAdd ? _optionsNoAdd[index] : _options[index];
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> allNavigation = [
      BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: "Home",
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
    ];

    List<BottomNavigationBarItem> navigationNoAdd = [
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
        icon: const Icon(Icons.person),
        label: _options[3],
        backgroundColor: CustomTheme.pinkMaterial,
      ),
    ];

    Widget resolveUserStatus(UserContext userContext) {
      if (userContext.isAnonymous()) {
        return const LoginPage(title: "Login");
      }
      return userContext.isCompany()
          ? _widgetOptions.elementAt(_selectedIndex)
          : _widgetOptionsNoAdd.elementAt(_selectedIndex);
    }

    return Consumer<UserContext>(
        builder: (context, userContext, child) => Scaffold(
              appBar: AppBar(
                title: Text(_title,
                    style: GoogleFonts.orbitron(
                        //gugi // orbitron // germania one
                        textStyle: CustomTheme.blackTitle)),
              ),
              body: Center(
                child: resolveUserStatus(userContext),
              ),
              bottomNavigationBar: userContext.isAnonymous()
                  ? null
                  : BottomNavigationBar(
                      items: !userContext.isCompany()
                          ? navigationNoAdd
                          : allNavigation,
                      currentIndex: _selectedIndex,
                      selectedItemColor: Colors.black,
                      unselectedItemColor: Colors.black,
                      backgroundColor: CustomTheme.pinkColor,
                      onTap: (idx) =>
                          _onItemTapped(idx, !userContext.isCompany()),
                    ),
            ));
  }
}
