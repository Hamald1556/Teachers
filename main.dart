import 'package:flutter/material.dart';
import 'signup_page.dart'; // Import the SignUpPage class
import 'signin_page.dart';
import 'dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(), // Use a separate widget for the main page
      routes: {
        '/signin': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
        '/dashboard': (context) => DashboardPage(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 175, 139, 84),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Container(
              width: 300,
              height: 200,
              color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Teachers E-Learning",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildButton("Sign In", Icons.navigate_next, context),
                  SizedBox(height: 5),
                  _buildButton("Sign Up", Icons.navigate_next, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        if (text == "Sign Up") {
          Navigator.pushNamed(context, '/signup');
        } else if (text == "Sign In") {
          Navigator.pushNamed(context, '/signin');
        } else {
          // Handle other buttons
        }
      },
      icon: Icon(icon),
      label: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

