import 'package:flutter/material.dart';
import 'package:language_app/widgets/signup_widget.dart';
import 'package:language_app/widgets/login_widget.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.symmetric(horizontal: 24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                spreadRadius: 5.0,
                offset: Offset(0, 5),
              )
            ],
          ),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: isLogin ? LoginWidget(onToggle: toggleForm) : SignupWidget(onToggle: toggleForm),
          ),
        ),
      ),
    );
  }
}
