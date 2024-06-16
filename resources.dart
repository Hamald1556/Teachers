import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Resource {
  final String name;
  final String description;

  Resource({required this.name, required this.description});
}

class ResourcesPage extends StatefulWidget {
  @override
  _ResourcesPageState createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  List<Resource> resources = [];
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    fetchResources();
  }

  Future<void> fetchResources() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.192.175/special_education/app/retrieve_resources.php'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Resource> resourceList = data.map((item) => Resource(
          name: item['resource_name'],
          description: item['resource_description'],
        )).toList();
        setState(() {
          resources = resourceList;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load resources');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 250,
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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Text(
                  'Resources',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : isError
                    ? Center(child: Text('Failed to load resources'))
                    : ListView.builder(
                        itemCount: resources.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResourceDetailsPage(resource: resources[index]),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 154, 145, 132),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              padding: EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    resources[index].name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
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

class ResourceDetailsPage extends StatefulWidget {
  final Resource resource;

  ResourceDetailsPage({required this.resource});

  @override
  _ResourceDetailsPageState createState() => _ResourceDetailsPageState();
}

class _ResourceDetailsPageState extends State<ResourceDetailsPage> {
  final TextEditingController _feedbackController = TextEditingController();
  bool isLoading = false;
  bool isSuccess = false;

  Future<void> submitFeedback(String feedback) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse('http://192.168.192.175/special_education/app/submit_feedback.php'),
      body: {'feedback': feedback},
    );

    setState(() {
      isLoading = false;
      isSuccess = response.statusCode == 200 && jsonDecode(response.body)['status'] == 'success';
    });

    if (isSuccess) {
      _feedbackController.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Feedback submitted successfully')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to submit feedback')));
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
              height: 250,
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Text(
                    'Resources',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                widget.resource.description,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Feedback',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _feedbackController,
                    decoration: InputDecoration(
                      hintText: 'Enter your feedback',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: isLoading ? null : () => submitFeedback(_feedbackController.text),
                    child: isLoading ? CircularProgressIndicator() : Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 154, 145, 132),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ResourcesPage(),
  ));
}
