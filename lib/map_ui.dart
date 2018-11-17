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
  Map<String, double> _currentLocation;


  StreamSubscription<Map<String, double>> _locationSubscription;
  GoogleMapController controller;
  Location _location = new Location();
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _locationSubscription =
        _location.onLocationChanged().listen((Map<String,double> result) {
          setState(() {
            _currentLocation = result;
          });
      });
    }

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
    //controller.onMarkerTapped.add(_onMarkerTapped);
  }

  

  Widget build(BuildContext context){
    Map<String, double> loc = _currentLocation;
    return Center(
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        options: GoogleMapOptions(
          cameraPosition: CameraPosition(
              target: LatLng(loc['latitude'], loc['longitude']),
              zoom: 11.0,
          ),
        )
      ),
    );
  }
}