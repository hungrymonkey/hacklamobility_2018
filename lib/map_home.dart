import 'package:flutter/material.dart';

import 'map_types.dart';
class MapHome extends StatefulWidget {
  const MapHome( this.configuration, this.updater);

  final MapConfiguration configuration;
  final ValueChanged<MapConfiguration> updater;
  @override
  MapHomeState createState() => MapHomeState();
}

class MapHomeState extends State<MapHome> {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Center(child: Text("Hello World"),);
    }
}