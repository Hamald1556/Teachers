// techniques_page.dart

import 'package:flutter/material.dart';
import 'reset_password.dart';  // Import the reset_password.dart file
import 'user_profile.dart';   // Import the user_profile.dart file
import 'download_material.dart';  // Import the download_material.dart file

class TechniquesPage extends StatelessWidget {
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
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPasswordPage()),
                );
              },
              icon: Icon(Icons.lock_open),
              label: Text('Reset Password'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20.0), // Adjust button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Adjust button border radius
                ),
                primary: Color.fromARGB(255, 154, 145, 132), // Set button color
              ),
            ),
          ),
          SizedBox(height: 10), // Added space here
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilePage()),
                );
              },
              icon: Icon(Icons.person),
              label: Text('User Profile'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20.0), // Adjust button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Adjust button border radius
                ),
                primary: Color.fromARGB(255, 154, 145, 132), // Set button color
              ),
            ),
          ),
          SizedBox(height: 10), // Added space here
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DownloadMaterialPage()),
                );
              },
              icon: Icon(Icons.file_download),
              label: Text('Download Material'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20.0), // Adjust button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Adjust button border radius
                ),
                primary: Color.fromARGB(255, 154, 145, 132), // Set button color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
