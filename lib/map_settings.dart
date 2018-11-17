import 'package:flutter/material.dart';

import 'map_types.dart';

class MapSettings extends StatefulWidget {
    const MapSettings(this.configuration, this.updater);
    final MapConfiguration configuration;
    final ValueChanged<MapConfiguration> updater;
    @override
    MapSettingsState createState() => MapSettingsState();
}
class MapSettingsState extends State<MapSettings> {

  void _handleCarChange(bool value) {
    sendUpdates(widget.configuration.copywith(car: value));
  }
  void _handleTransitChange(bool value) {
    sendUpdates(widget.configuration.copywith(transit: value));
  }
  void _handleScooterChange(bool value) {
    sendUpdates(widget.configuration.copywith(scooter: value));
  }

  void _handleWalkingChange(bool value) {
    sendUpdates(widget.configuration.copywith(walking: value));
  }

  Widget buildAppBar(BuildContext context) {
      return AppBar(
        title: const Text('Settings')
      );
  }
  void sendUpdates(MapConfiguration value) {
    if (widget.updater != null)
      widget.updater(value);
  }
  


  Widget buildSettingsPane(BuildContext context) {
    final List<Widget> rows = <Widget>[
      
    ];
    return ListView(children: rows);
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Application Settings"),),
      body: Center(child: Text("Settings")),
    );
  }
}