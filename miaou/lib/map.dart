import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';

class Map extends StatefulWidget{
  const Map({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return MapState();
  }
}


class MapState extends State<Map>{

  final LatLng _initialcameraposition = const LatLng(42, 42);
  late GoogleMapController _controller;
  //Completer <GoogleMapController> controllerMap = Completer();
  final Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(l.latitude!.toDouble(), l.longitude!.toDouble()),
          zoom: 10),
      ),
      );
      /*(controller) async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/map.json");
   controller.setMapStyle(data);
   controllerMap.complete(controller);
 };*/
    });
  }

    Widget mapbody() {
      return GoogleMap(
        initialCameraPosition: CameraPosition(target: _initialcameraposition),
        onMapCreated: _onMapCreated,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        shadowColor: Colors.blueAccent,
        title: const Text('Map'),
      ),
      body: mapbody(),
    );
  }
}

