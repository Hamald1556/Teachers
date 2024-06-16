import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 175, 139, 84),
        padding: EdgeInsets.all(20),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              color: Colors.grey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildInputField("Username", _usernameController),
                  SizedBox(height: 10),
                  _buildInputField("Email", _emailController),
                  SizedBox(height: 10),
                  _buildInputField("Password", _passwordController, obscureText: true),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _signUp(
                        _usernameController.text.trim(),
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 236, 229, 229),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Color.fromARGB(255, 180, 151, 151)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String labelText, TextEditingController controller, {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  void _signUp(String username, String email, String password) async {
    var url = Uri.parse('http://192.168.192.175/special_education/app/signup.php');
    var response = await http.post(url, body: {
      'username': username,
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      if (response.body == 'Email already in use') {
        _showNotification('Email already in use');
      } else if (response.body == 'New record created successfully') {
        _showNotification('Registration successful');
      } else {
        _showNotification('Something went wrong');
      }
    } else {
      _showNotification('Failed to connect to server');
    }
  }

  void _showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
