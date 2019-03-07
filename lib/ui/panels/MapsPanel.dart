/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPanel extends StatefulWidget {
  final LatLng pos;
  final String title;

  MapsPanel({Key key, this.pos, this.title}) : super(key: key);

  @override
  MapsState createState() => new MapsState(pos, title);
}

class MapsState extends State<MapsPanel> {
  GoogleMapController mapController;
  LatLng _startPoint;
  String infoText;

  MapsState(this._startPoint, this.infoText) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/illinois_vertical.png',
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition:
            CameraPosition(target: this._startPoint, zoom: 11.0),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
    _addMarker(this._startPoint);
  }

  _addMarker(LatLng pos) {
    Future<Marker> initialMarker = mapController.addMarker(new MarkerOptions(
        position: pos, infoWindowText: new InfoWindowText(this.infoText, "")));
  }
}
