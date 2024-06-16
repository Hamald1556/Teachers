import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 175, 139, 84),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : () => _sendResetEmail(context),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text('Send Reset Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }

 void _sendResetEmail(BuildContext context) async {
  String email = _emailController.text.trim();
  if (!isValidEmail(email)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please enter a valid email address.'),
        duration: Duration(seconds: 3),
      ),
    );
    return;
  }

  setState(() {
    _isLoading = true;
  });

  var url = Uri.parse('http://192.168.192.175/special_education/app/forgot_password.php');
  try {
    var response = await http.post(url, body: {
      'email': email,
    });

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      if (responseBody != null && responseBody['result'] != null && responseBody['result'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reset email sent to $email'),
            duration: Duration(seconds: 3),
          ),
        );
      } else if (responseBody != null && responseBody['message'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody['message']),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send reset email. Please try again later.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send reset email. Please try again later.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  } catch (e) {
    print('Error sending reset email: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to send reset email. Please try again later.'),
        duration: Duration(seconds: 3),
      ),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


  bool isValidEmail(String email) {
    // Simple email validation
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
