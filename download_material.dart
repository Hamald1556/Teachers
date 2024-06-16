import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class DownloadMaterialPage extends StatefulWidget {
  @override
  _DownloadMaterialPageState createState() => _DownloadMaterialPageState();
}

class _DownloadMaterialPageState extends State<DownloadMaterialPage> {
  List<Map<String, dynamic>> files = [];

  @override
  void initState() {
    super.initState();
    fetchFiles();
  }

  Future<void> fetchFiles() async {
    var url = 'http://192.168.192.175/special_education/app/download_material.php'; // Replace with your server URL

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> jsonFiles = jsonDecode(response.body);
        setState(() {
          files = jsonFiles.cast<Map<String, dynamic>>();
        });
      } else {
        print('Failed to fetch files. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        // Handle error
        throw Exception('Failed to fetch files');
      }
    } catch (e) {
      print('Exception fetching files: $e');
      // Handle exception
    }
  }

  Future<void> launchDownload(String filePath) async {
    var baseUrl = 'http://192.168.192.175/special_education/app/download.php/';
    var url = '$baseUrl?file=$filePath';

    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Hide the AppBar
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200, // Adjust the height as needed
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
            child: files.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      String filePath = files[index]['path'];

                      return Card(
                        color: Color.fromARGB(255, 154, 145, 132), // Set button color
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          title: Text(
                            filePath.split('/').last, // Display filename
                            style: TextStyle(color: Colors.white), // Text color
                          ),
                          trailing: Icon(Icons.file_download, color: Colors.white), // Icon color
                          onTap: () {
                            launchDownload(filePath);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
