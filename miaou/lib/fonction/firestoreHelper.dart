import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:miaou/model/Utilisateur.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;


class firestoreHelper{
  final authBase = FirebaseAuth.instance;
  final firestore_user = FirebaseFirestore.instance.collection("utilisateur");
  final instanceFirestorage = FirebaseStorage.instance;
  final firestoreChat = FirebaseChatCore.instance;
  
//Fonction d'insription

Future <User?> inscription(String mail, String password) async {
  final authResult = await authBase.createUserWithEmailAndPassword(email: mail, password: password);
  final user=authResult.user;
  String identifiant = user!.uid;
  return user;
}

void addInfoUserFireAuth(Utilisateur utilisateur) async {
    await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: utilisateur.prenom,
          id: utilisateur.identifiant, // UID from Firebase Authentication
          // imageUrl: utilisateur.profilPicturePath,
          lastName: utilisateur.nom,
        ),
    );
  }

Future <User> connexion(String mail, String password) async {
  final authResult = await authBase.signInWithEmailAndPassword(email: mail, password: password);
  final user = authResult.user;
  return user!;
}

String getIdentifiant(){
  String identifiant=authBase.currentUser!.uid;
  return identifiant;
}

addUser(Map <String,dynamic> map ,String uid){
  firestore_user.doc(uid).set(map);
}

Future <Utilisateur> getUtilisateur(String uid) async {
  DocumentSnapshot snapshot = await firestore_user.doc(uid).get();
  return Utilisateur(snapshot);
}

  }


