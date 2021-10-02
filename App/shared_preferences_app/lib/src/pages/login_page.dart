import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_app/model/user.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {

  static String routeName = 'login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController controladorUserName = TextEditingController();
  late TextEditingController controladorPassword = TextEditingController();

  @override
  void dispose() {
    controladorPassword.dispose();
    controladorUserName.dispose();
    super.dispose();
  }

  Widget _title() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: const Text('Login',
        style: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.w500,
            color: Colors.black),
      ),
    );
  }
  Widget _inputUserName() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        cursorColor: Colors.amber,
        controller: controladorUserName,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide:
              BorderSide(color: Colors.amber, width: 2.0)),
          icon: Icon(
            Icons.email,
            color: Colors.amber,
          ),
          labelText: 'Username',
          labelStyle: TextStyle(color: Colors.black),
        ),
        validator: (value) {
          if(value != null && value.isEmpty) {
            return 'Input username';
          }
        },

      ),
    );
  }
  Widget _inputPassword() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        cursorColor: Colors.amber,
        controller: controladorPassword,
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide:
              BorderSide(color: Colors.amber, width: 2.0)),
          icon: Icon(
            Icons.lock,
            color: Colors.amber,
          ),
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.black),
        ),
        validator: (value) {
          if(value != null && value.isEmpty) {
            return 'Input password';
          }
        }
      ),
    );
  }
  Widget _button() {
    return ElevatedButton(
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Go to Home',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.amberAccent),
        foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.black),
      ),
      onPressed: _onPressedButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _title(),
              _inputUserName(),
              _inputPassword(),
              _button()
            ],
          ),
        ),
      ),
    );
  }



  Future<http.Response> _login(String userName, String password) {
    var url = Uri.parse("http://192.168.1.14:5000/Users");
    return http.post(url, body: jsonEncode({
        "userName": userName,
        "password": password
      }),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      }
    );
  }
  _onPressedButton() async {
    if(_formKey.currentState?.validate() ?? false) {

      var response = await _login(controladorUserName.text, controladorPassword.text);

      if(response.statusCode == 400) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
              SnackBar(
                content: const Text('Credenciales incorrectas'),
                backgroundColor: Colors.red[400],
                behavior: SnackBarBehavior.floating,
                // margin: EdgeInsets.symmetric(vertical: 50, horizontal: 40),
              )
          );
      } else if(response.statusCode == 200) {

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        var user = User.fromJson(jsonDecode(response.body));
        sharedPreferences.setString("user", response.body);
        Navigator.pushReplacementNamed(context, HomePage.routeName, arguments: user);
      }
    }
  }

}
