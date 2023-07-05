import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';



class Map extends StatefulWidget {
  final String? name;
  final double? latitude;
  final double? longitude;
  const Map({Key? key ,required this.name, required this.latitude, required this.longitude}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {

    CameraPosition initialPosition = CameraPosition(target: LatLng(widget.latitude?? 0.0 , widget.longitude??0.0), zoom: 15.0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#093A3E'),
        title: Text(widget.name ?? ''),
      ),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}
