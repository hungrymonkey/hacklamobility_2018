import 'package:flutter/material.dart';


import './map_settings.dart';
import './map_types.dart';
import './map_home.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  
  MapConfiguration _configuration = MapConfiguration(
    car: false,
    scooter: false,
    transit: false,
    walking: true,
  );
  @override
  void initState() {
    super.initState();
  }
  void configurationUpdater(MapConfiguration value){
    setState(() {
      _configuration = value;
    });
  }
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Map Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        '/':          (BuildContext context) => MapHome(_configuration, configurationUpdater),
        '/settings':  (BuildContext context) => MapSettings(_configuration, configurationUpdater)
      },
    );
  }
}

void main() => runApp(MyApp());
