import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_app/model/user.dart';
import 'package:shared_preferences_app/src/pages/login_page.dart';

class HomePage extends StatefulWidget {
  static String routeName = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Widget _data(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Text(value, style: const TextStyle(fontSize: 20),)
        ],
      ),
    );
  }



  void _onPressedButton() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("user");
    Navigator.pushReplacementNamed(context, LoginPage.routeName);
  }

  Widget _logoutButton() {
    return IconButton(onPressed: _onPressedButton, icon: const Icon(Icons.logout,));
  }

  @override
  Widget build(BuildContext context) {

    User user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          _logoutButton()
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _data("Username", user.userName),
            _data("State", user.state),
            _data("Color", user.color),
            _data("Access", user.access),
          ],
        ),
      ),
    );
  }
}
