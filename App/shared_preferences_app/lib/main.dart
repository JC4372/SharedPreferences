import 'package:flutter/material.dart';
import 'package:shared_preferences_app/src/pages/home_page.dart';
import 'package:shared_preferences_app/src/pages/index_page.dart';
import 'package:shared_preferences_app/src/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Actividad Dos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: IndexPage.routeName,
      routes: {
        IndexPage.routeName: (context) => const IndexPage(),
        LoginPage.routeName : (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage()
      },
    );
  }
}