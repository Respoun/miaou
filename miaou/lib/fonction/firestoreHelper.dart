import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:miaou/model/Utilisateur.dart';


class firestoreHelper{
  final authBase = FirebaseAuth.instance;

  // final instanceFirestore = FirebaseFirestore.instance;
  // final firestore_user = FirebaseFirestore.instance.collection("utilisateur");
  // final instanceFirestorage = FirebaseStorage.instance;



//Fonction d'insription
Future <User?> inscription(String mail, String password) async {
  final authResult = await authBase.createUserWithEmailAndPassword(email: mail, password: password);
  final user=authResult.user;
  String identifiant = user!.uid;
  return user;
}


Future <User> connexion(String mail, String password) async {
  final authResult = await authBase.signInWithEmailAndPassword(email: mail, password: password);
  final user = authResult.user;
  return user!;

}





  }


