import 'package:flutter/material.dart';

class Resto with ChangeNotifier {
    final String id;
    final String nom;
    final String type;
    final String ville;
    final String commune;
    final String tel;
    final String longi;
    final String lati;
    final String image;


  Resto({
    this.id, 
    this.nom, 
    this.type, 
    this.ville, 
    this.commune, 
    this.tel, 
    this.longi, 
    this.lati, 
    this.image
  });

  factory Resto.fromJson(Map<String, dynamic> myjson) {
    return Resto(
      id: myjson['id_resto'],
      nom: myjson['nom'],
      type: myjson['type'],
      ville: myjson['ville'],
      commune: myjson['commune'],
      tel: myjson['tel'],
      longi: myjson['longi'],
      lati: myjson['lati'],
      image: myjson['image']
    );
  }

}