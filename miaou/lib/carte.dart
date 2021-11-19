import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:miaou/profilUser.dart';
import 'model/Utilisateur.dart';

class Carte extends StatefulWidget{
  const Carte({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CarteState();
  }
}

class CarteState extends State<Carte>{
  final LatLng _initialcameraposition = const LatLng(42, 42);
  late GoogleMapController _controller;
  final Location _location = Location();
  final Set<Marker> markers = new Set();
    
  @override
    void initState() {

      super.initState();

      var collection = FirebaseFirestore.instance.collection('utilisateur');
      collection.snapshots().listen((querySnapshot) async {

        for (var doc in querySnapshot.docs) {
            Map<String, dynamic> data = doc.data();
            var long = data['long'];
            var lat = data['lat'];
            var name = data['pseudo'];
          setState(() {
              markers.add(Marker( //add first marker
                markerId: MarkerId(name),
                position: LatLng(lat, long), //position of marker
                infoWindow: InfoWindow( //popup info 
                  title: name,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => profilUser(receive_data: data,),));
                  }
                ),
                icon: BitmapDescriptor.defaultMarker, //Icon for Marker 
              ));
          });
        }
      });
    }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(l.latitude!.toDouble(), l.longitude!.toDouble()),
          zoom: 13),
      ),
    );
  _controller.setMapStyle('[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"administrative.neighborhood","stylers":[{"visibility":"off"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text","stylers":[{"visibility":"off"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.business","stylers":[{"visibility":"off"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit","stylers":[{"visibility":"off"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text","stylers":[{"visibility":"off"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]');   
    });
  }

    Widget mapbody() {
      return GoogleMap(
        initialCameraPosition: CameraPosition(target: _initialcameraposition),
        onMapCreated: _onMapCreated,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: markers, 
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
            mapbody()
        ]
      ),
    );
  }
}
