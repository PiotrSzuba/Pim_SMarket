import 'package:flutter/material.dart';
import 'package:pim_smarket/data/data.dart';
import 'package:pim_smarket/views/main_page.dart';
import 'package:pim_smarket/theme.dart';
import 'package:pim_smarket/views/views.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserContext>(
      create: (context) => UserContext(),
      child: Consumer<UserContext>(
        builder: (context, value, child) => MaterialApp(
          title: CustomTheme.appName,
          theme: ThemeData(
              primaryColor: CustomTheme.pinkMaterial,
              primarySwatch: CustomTheme.pinkMaterial,
              scaffoldBackgroundColor: Colors.black87),
          home: const MainPage(),
        ),
      ),
    );
  }
}
