import 'package:flutter/material.dart';
import 'package:language_app/screens/home_screen.dart';
 import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:language_app/states/user_state.dart'; // Import the UserState class
import 'package:provider/provider.dart';

class SignupWidget extends StatefulWidget {
  final VoidCallback onToggle;

  SignupWidget({required this.onToggle});

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isloading = false;

  Future _signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    setState(() {
      _isloading = true;
    });

    try {
      print('Attempting to sign up with email: $email');
      var response = await http.post(
        Uri.parse('http://146.70.158.243/signup'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        Provider.of<UserState>(context, listen: false).login(email, email);
         print('User signed up and saved locally: $responseData');

        // Navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        print('Sign up failed: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign up failed. Please try again.')),
        );
      }
    } catch (e) {
      print('Error during sign up: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign up failed. Please try again.')),
      );
    }

    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Sign Up',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'email',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
          obscureText: true,
        ),
        SizedBox(height: 16),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _signUp,
           style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: _isloading
              ? const SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2.0,
                  ),
                )
              : Text('Sign Up'),
        ),
        SizedBox(height: 16),
        TextButton(
          onPressed: widget.onToggle,
          child: Text('Already have an account? Login'),
        ),
      ],
    );
  }
}
