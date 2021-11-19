
import 'package:flutter/material.dart';
import 'package:miaou/fonction/firestoreHelper.dart';
import 'package:miaou/model/Utilisateur.dart';
import 'package:miaou/carte.dart';
import 'package:geolocator/geolocator.dart';

class informationUser extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return informationUserState();
  }
}

class informationUserState extends State<informationUser>{
  String nom='';
  String pseudo='';
  String prenom='';
  String identifiant='';
  late Utilisateur user;
  
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    identifiant = firestoreHelper().getIdentifiant();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: bodyPage(),
    );
  }

  Widget bodyPage(){
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(

        children: [
          //nom
          TextField(
            onChanged: (String value){
              setState(() {
                nom = value;
              });
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),

                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Nom"
            ),

          ),
          SizedBox(height: 20,),
          //prenom
          TextField(
            onChanged: (String value){
              setState(() {
                prenom = value;
              });
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),

                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Prenom"
            ),

          ),
          SizedBox(height: 20,),
          //pseudo
          TextField(
            onChanged: (String value){
              setState(() {
                pseudo = value;
              });
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),

                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Pseudo"
            ),

          ),
          //adresse
          SizedBox(height: 20,),
          ElevatedButton(
              onPressed: () async {
                Position position = await _getGeoLocationPosition();
                
                Map<String,dynamic> map ={
                  "nom":nom,
                  "prenom":prenom,
                  "pseudo":pseudo,
                  "lat":position.latitude,
                  "long":position.longitude
                };

                firestoreHelper().addUser(map, identifiant);

                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context){
                      return Carte();
                    }
                ));

              },
              child: Text('Enregistrer')
          ),
        ],
      ),
    );
  }
}