import 'package:flutter/material.dart';
import 'package:pim_smarket/views/main_page.dart';
import './theme.dart';
import './views/views.dart';

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
      home: const MainPage(),
    );
  }
}
