import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_app/model/user.dart';
import 'package:shared_preferences_app/src/pages/home_page.dart';
import 'package:shared_preferences_app/src/pages/login_page.dart';


class IndexPage extends StatefulWidget {

  static String routeName = 'index_page';
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPage();

}

class _IndexPage extends State<IndexPage> {

  @override
  void initState() {
    SharedPreferences.getInstance().then((sharedPreferences) {
      var user = sharedPreferences.getString("user");
      if(user != null) {
        Navigator.pushReplacementNamed(
            context, HomePage.routeName,
            arguments: User.fromJson(jsonDecode(user))
        );
      } else {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.pending, size: 40,),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Text("cargando", style: TextStyle(fontSize: 18, color: Colors.black54),),
            )
          ],
        ),
      ),
    );
  }
}