import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miaou/fonction/firestoreHelper.dart';
import 'model/Utilisateur.dart';


class profilUser extends StatefulWidget{
  late Map<String, dynamic> receive_data;
  profilUser({required this.receive_data});
   
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return profileUserState();
  }
}

class profileUserState extends State<profilUser>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyPage(),
    );
  }

Widget bodyPage(){
        return Center(
          child: Row(children: [
            Text('${widget.receive_data['pseudo']}\n${widget.receive_data['nom']}\n${widget.receive_data['prenom']}'),
              CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xff4c505b),
              child: IconButton(
                  color: Colors.white,
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                  )),
            )
          ],),
        );
      }
}



