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


  void sendUpdates(MapConfiguration value) {
    if (widget.updater != null)
      widget.updater(value);
  }
  
  Widget buildSettingsPane(BuildContext context) {
    final List<Widget> rows = <Widget>[
      ListTile(
          leading: const Icon(Icons.directions_car),
          title: const Text('Select Car'),
          onTap: () { _handleCarChange(!widget.configuration.car); },
          trailing: Switch(
            value: widget.configuration.car,
            onChanged: _handleCarChange,
          ),
      ),
      ListTile(
          leading: const Icon(Icons.directions_bike),
          title: const Text('Select Scooter'),
          onTap: () { _handleScooterChange(!widget.configuration.scooter); },
          trailing: Switch(
            value: widget.configuration.scooter,
            onChanged: _handleScooterChange,
          ),
      ),
      ListTile(
          leading: const Icon(Icons.directions_transit),
          title: const Text('Select Transit'),
          onTap: () { _handleTransitChange(!widget.configuration.transit); },
          trailing: Switch(
            value: widget.configuration.transit,
            onChanged: _handleTransitChange,
          ),
      ),
      ListTile(
          leading: const Icon(Icons.directions_walk),
          title: const Text('Select Walking'),
          onTap: () { _handleWalkingChange(!widget.configuration.walking); },
          trailing: Switch(
            value: widget.configuration.walking,
            onChanged: _handleWalkingChange,
          ),
      ),
    ];
  }
  @override
  Widget build(BuildContext context){
    return buildSettingsPane(context);
  }
}