import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordPage extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200, // Adjust the height as needed
            padding: EdgeInsets.only(bottom: 20.0), // Increased bottom padding
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQU7qmMiS2-WDs9TiKTc3PS9fqhR45gldU4nQ&s',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20), // Added space here
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildInputField("New Password", Icons.lock, _passwordController, obscureText: true),
          ),
          SizedBox(height: 10), // Added space here
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildInputField("Confirm Password", Icons.lock, _confirmPasswordController, obscureText: true),
          ),
          SizedBox(height: 20), // Added space here
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildSubmitButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, IconData icon, TextEditingController controller, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 154, 145, 132), // Set button color
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () {
          _resetPassword(context);
        },
        child: Text(
          'Submit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  void _resetPassword(BuildContext context) async {
    // Get the new password from the input field
    String newPassword = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword != confirmPassword) {
      // Show error message if passwords do not match
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match. Please try again.'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    // Retrieve the user ID from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId == null) {
      // Show error message if user ID is not found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to retrieve user ID. Please sign in again.'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    // Send the new password to your PHP script using HTTP POST request
    var url = Uri.parse('http://192.168.192.175/special_education/app/reset_password.php');
    var response = await http.post(url, body: {
      'user_id': userId.toString(),
      'new_password': newPassword,
    });

    // Handle the response
    if (response.statusCode == 200) {
      // Check the response body to determine if password reset was successful
      if (response.body == 'Password reset successful') {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password reset successful.'),
            duration: Duration(seconds: 3),
          ),
        );
        // Navigate back to the sign-in page or another page
        Navigator.pop(context);
      } else {
        // Show error message if password reset was not successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to reset password. Please try again.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      // Failed to connect to server or other error, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to reset password. Please try again later.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
