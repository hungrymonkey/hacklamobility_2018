import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'map_types.dart';
import 'page.dart';


class MapUI extends Page {
 const MapUI() : super(const Icon(Icons.place), 'Place marker');
  @override
  Widget build(BuildContext context) {
    return const MapUIBody();
  }
}
class MapUIBody extends StatefulWidget {
  const MapUIBody();

  @override
  State<StatefulWidget> createState() => MapUIBodyState();
}

class MapUIBodyState extends State<MapUIBody> {
  Map<String, double> _startLocation;
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
  void dispose() {
    super.dispose();
    controller.dispose();
    _locationSubscription.cancel();
  }
  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
    controller.addMarker(
        MarkerOptions(
          position: _currentLocation,
          visible: true
        )).then( (Marker m) {
          _myPosition = m;
        }
    );
    //controller.onMarkerTapped.add(_onMarkerTapped);
  }

  void here() {
    controller.moveCamera(CameraUpdate.newLatLng(_currentLocation));
  }
  void _updateSelectedMarker(Marker marker, MarkerOptions changes) {
    marker != null ? controller.updateMarker(marker, changes) : null;
  }
  
  
  Widget build(BuildContext context){
    var loc = _currentLocation;

    return Center(
       child: Column(children: <Widget>[
          SizedBox(
            height: 400,
            child: GoogleMap(
              
              onMapCreated: _onMapCreated,
              options: GoogleMapOptions(cameraPosition: CameraPosition(
                target: GoogleMapOptions.defaultOptions.cameraPosition.target, zoom: 11.0)
              ),
              
            ),
          ),
          IconButton(
            icon: Icon( Icons.my_location ),
            onPressed: here,

          ),
       ],
      )
       
    );
  }
}