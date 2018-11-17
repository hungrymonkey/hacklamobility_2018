import 'package:flutter/material.dart';

import 'map_types.dart';
import 'map_drawer.dart';
class MapHome extends StatefulWidget {
  const MapHome( this.configuration, this.updater);

  final MapConfiguration configuration;
  final ValueChanged<MapConfiguration> updater;
  @override
  MapHomeState createState() => MapHomeState();
}

class MapHomeState extends State<MapHome> {

  void configurationUpdater(MapConfiguration value){
    sendUpdates(value);
  }
  void sendUpdates(MapConfiguration value) {
    if (widget.updater != null)
      widget.updater(value);
  }

  Widget _buildDrawer(BuildContext context) {
    return MapDrawer(widget.configuration, configurationUpdater);
  }
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar( title: Text('MyMap')),
        body: Center(child: Text("Hello World"),),
        drawer: _buildDrawer(context),
      );
    }
}