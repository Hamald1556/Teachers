import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Map<String, dynamic>? userData;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    // Retrieve the user ID from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId == null) {
      // Show error message if user ID is not found
      setState(() {
        errorMessage = 'Failed to retrieve user ID. Please sign in again.';
      });
      return;
    }

    var url = Uri.parse('http://192.168.192.175/special_education/app/get_user_profile.php');
    var response = await http.post(url, body: {
      'user_id': userId.toString(),
    });

    if (response.statusCode == 200) {
      try {
        setState(() {
          userData = json.decode(response.body);
          if (userData != null && userData!.containsKey('error')) {
            errorMessage = userData!['error'];
            userData = null;
          }
        });
      } catch (e) {
        setState(() {
          errorMessage = 'Failed to parse user data. Please try again later.';
        });
      }
    } else {
      // Show error message if fetching user data failed
      setState(() {
        errorMessage = 'Failed to load user data. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 220, // Adjusted height and increased padding
              padding: EdgeInsets.only(bottom: 40.0), // Increased bottom padding
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
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              )
            else if (userData != null)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${userData!['username']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Email:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${userData!['email']}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              )
            else
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
