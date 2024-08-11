import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:language_app/screens/home_screen.dart';
import 'package:language_app/states/user_state.dart'; // Import the UserState class
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
   final VoidCallback onToggle;

  LoginWidget({required this.onToggle});

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    
      var response = await http.post(
        Uri.parse('http://146.70.158.243/login'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
         print('User logged in via server');
          final userData = jsonDecode(response.body);

          // Update user state
        Provider.of<UserState>(context, listen: false).login(userData['email'], email);

        // Navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        print('Login failed');
        // Show error message
      }
   
  }

  
  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey(1),
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Login',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        SizedBox(height: 16.0),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
          obscureText: true,
        ),
        SizedBox(height: 16.0),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text('Forgot Password?'),
          ),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: _login,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text('Login'),
        ),
        SizedBox(height: 16.0),
        TextButton(
          onPressed: widget.onToggle,
          child: Text('Don\'t have an account? Sign Up'),
        ),
      ],
    );
  }
}
