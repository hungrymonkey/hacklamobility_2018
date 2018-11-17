import 'package:flutter/material.dart';

import 'map_types.dart';
import 'map_settings.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class MapHome extends StatefulWidget {
  const MapHome( this.configuration, this.updater);

  final MapConfiguration configuration;
  final ValueChanged<MapConfiguration> updater;
  @override
  MapHomeState createState() => MapHomeState();
}

class MapHomeState extends State<MapHome> {

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

  void configurationUpdater(MapConfiguration value){
    sendUpdates(value);
  }
  void sendUpdates(MapConfiguration value) {
    if (widget.updater != null)
      widget.updater(value);
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(child: Center(child: Text('Transportation Options'))),
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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: _handleShowSettings,
          ),
        ],
      ),
    );
  }
  void _handleShowSettings() {
    Navigator.popAndPushNamed(context, '/settings');
  }

  LatLng _currentLocation;

  Marker _myPosition;
  StreamSubscription<Map<String, double>> _locationSubscription;
  GoogleMapController controller;
  Location _location = new Location();
  @override
    void initState() {
      super.initState();
      _currentLocation = LatLng(34.0553, -118.2498);
      _locationSubscription =
        _location.onLocationChanged().listen((Map<String,double> result) {
          var coord = LatLng(result['latitude'], result['longitude']);
          print("**** cord $coord ****");
          _updateSelectedMarker(_myPosition, MarkerOptions(
            position: coord
          ));
          setState(() {
            _currentLocation = coord;
          });
      });
    }
  void here() {
    controller.moveCamera(CameraUpdate.newLatLng(_currentLocation));
  }
  void _updateSelectedMarker(Marker marker, MarkerOptions changes) {
    marker != null ? controller.updateMarker(marker, changes) : null;
  }
  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
    controller.addMarker(
        MarkerOptions(
          flat: true,
          position: _currentLocation,
          visible: true
        )).then( (Marker m) {
          _myPosition = m;
        }
    );
    //controller.onMarkerTapped.add(_onMarkerTapped);
  }
  void dispose() {
    super.dispose();
    controller.dispose();
    _locationSubscription.cancel();
  }
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar( title: Text('MyMap') ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          options: GoogleMapOptions(cameraPosition: CameraPosition(
          target: GoogleMapOptions.defaultOptions.cameraPosition.target, zoom: 11.0)
          ),    
        ),
        drawer: _buildDrawer(context),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.my_location),
          onPressed: here,
        ),
      );
    }
}