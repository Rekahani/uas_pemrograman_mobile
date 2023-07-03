import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> stations = [];

  Future<void> fetchStations() async {
    final response = await http.get(Uri.parse('https://booking.kai.id/api/stations2'));
    if (response.statusCode == 200) {
      setState(() {
        stations = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to fetch stations');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStations();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('KAI Stations'),
        ),
        body: ListView.builder(
          itemCount: stations.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                title: Text(
                  stations[index]['name'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(stations[index]['city']),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StationDetailPage(station: stations[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class StationDetailPage extends StatelessWidget {
  final Map<String, dynamic> station;

  StationDetailPage({required this.station});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(station['name']),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kode Stasiun: ${station['code']}'),
            SizedBox(height: 16.0),
            Text('Nama: ${station['name']}'),
            SizedBox(height: 16.0),
            Text('Kota: ${station['city']}'),
            SizedBox(height: 16.0),
            Text('Nama Kota: ${station['cityname']}'),
            SizedBox(height: 16.0),
            Text('Alamat: ${station['address']}'),
            SizedBox(height: 16.0)
          ],
        ),
      ),
    );
  }
}


