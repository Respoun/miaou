
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
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background_cat.png'), fit: BoxFit.cover),
      ),
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
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
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
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
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
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Pseudo"
            ),

          ),
          //adresse
          SizedBox(height: 20,),
          CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xff4c505b),
            child: IconButton(
                color: Colors.white,
                onPressed: () async {
                  Position position = await _getGeoLocationPosition();

                  Map<String,dynamic> map ={
                    "nom":nom,
                    "prenom":prenom,
                    "pseudo":pseudo,
                    "lat":position.latitude,
                    "long":position.longitude,
                    "uid":identifiant
                  };

                  firestoreHelper().addUser(map, identifiant);
                  firestoreHelper().addInfoUserFireAuth(await firestoreHelper().getUtilisateur(identifiant));

                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context){
                        return Carte();
                      }
                  ));

                },
                icon: Icon(
                  Icons.arrow_forward,
                )),
          )
        ],
      ),
    );
  }
}