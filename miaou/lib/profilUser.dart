import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miaou/chatPage.dart';
import 'package:miaou/fonction/firestoreHelper.dart';
import 'model/Utilisateur.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class profilUser extends StatefulWidget{
  late Map<String, dynamic> receive_data;
  profilUser({required this.receive_data});
 
  @override
  State<StatefulWidget> createState() {
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
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/oui.jpg'), fit: BoxFit.cover),
          ),
          child: Column(

          children:<Widget>[
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      '${widget.receive_data['pseudo']} profil',
                      style: const TextStyle(
                        fontSize: 42.0,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(
                      height: 100,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/mohhhtropmimi.png'),
                      radius: 50.0,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.receive_data['pseudo'],
                      style: const TextStyle(
                        fontSize: 42.0,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      elevation: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 22.0),
                        child: Row(

                          children: <Widget>[
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  Text(
                                    widget.receive_data['nom'],
                                    style: const TextStyle(
                                      fontSize: 28.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.receive_data['prenom'],
                                    style: const TextStyle(
                                      fontSize: 28.0,
                                      color: Colors.black,
                                    ),
                                  ),
              CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFFf3d6d2),
              child: IconButton(
                  color: Colors.white,
                  onPressed: () async {
                    firestoreHelper()
                                  .firestoreChat
                                  .users()
                                  .forEach((element) {
                                element.forEach((userChat) async {
                                  if (userChat.id == widget.receive_data['uid']) {
                                    final room = await FirebaseChatCore.instance
                                        .createRoom(userChat);

                                    // Navigate to the Chat screen
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return ChatPage(
                                                room: room,
                                              );
                                                  }));
                                                  }
                                                });
                                              });
                                          },
                                  icon: Icon(
                                    Icons.send,
                                  )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
        }
}




