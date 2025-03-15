import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic> data = {};

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('http://flask-backend:5000/get_global_power_data'),
    );

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Global Electricity Map")),
        body:
            data.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView(
                  children:
                      data.keys.map((key) {
                        return ListTile(
                          title: Text(
                            '${data[key]["country"]}: ${data[key]["power"]}%',
                          ),
                        );
                      }).toList(),
                ),
      ),
    );
  }
}
