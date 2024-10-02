import 'package:flutter/material.dart';
import '../db/db_helper.dart';

class Contact {
  int? id;
  String nom;
  String prenom;
  String email;
  String telephone;

  Contact({this.id, required this.nom, required this.prenom, required this.email, required this.telephone});

  // Convertir un contact en Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'telephone': telephone,
    };
  }

  // Extraire un contact à partir d'un Map
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
      telephone: map['telephone'],
    );
  }
}
