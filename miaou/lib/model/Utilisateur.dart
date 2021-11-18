import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Utilisateur{
  late String prenom;
  late String nom;
  late String pseudo;
  late String image;
  late String identifiant;

  Utilisateur(DocumentSnapshot snapshot){
    identifiant = snapshot.id;
    Map<String,dynamic> map = snapshot.data() as Map<String,dynamic>;
    prenom = map["prenom"];
    nom = map["nom"];
    pseudo= map["pseudo"] ;
    image= map["image"];
  }
}