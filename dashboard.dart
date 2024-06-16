import 'package:flutter/material.dart';
import 'lessons.dart';
import 'resources.dart';
import 'techniques.dart';
import 'tutorials.dart'; // Import the resources.dart file

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 250, // Adjust the height as needed
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: [
                  _buildGridItem('Resources', Icons.library_books, Colors.blue, context), // Pass context here
                  _buildGridItem('Tutorials', Icons.school, Colors.green, context), // Pass context here
                  _buildGridItem('Lessons', Icons.book, Colors.orange, context), // Pass context here
                  _buildGridItem('Techniques', Icons.build, Colors.red, context), // Pass context here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(String title, IconData iconData, Color color, BuildContext context) {
  return Card(
    elevation: 5.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: InkWell(
      onTap: () {
        // Handle tap
        if (title == 'Resources') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResourcesPage()), // Navigate to ResourcesPage
          );
        } else if (title == 'Tutorials') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TutorialsPage()), // Navigate to TutorialsPage
          );
        }
        else if (title == 'Lessons') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LessonsPage()), // Navigate to TutorialsPage
          );
        } 
        else if (title == 'Techniques') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TechniquesPage()), // Navigate to TutorialsPage
          );
        }
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 50.0,
              color: color,
            ),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}
