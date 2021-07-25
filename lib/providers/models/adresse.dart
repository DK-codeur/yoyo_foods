import 'package:flutter/material.dart';

class Adress with ChangeNotifier {
   int createdAt;
    int updatedAt;
    int id;
    String commune;
    String ville;
    double logitude;
    double latitude;

    Adress({
        this.createdAt,
        this.updatedAt,
        this.id,
        this.commune,
        this.ville,
        this.logitude,
        this.latitude,
    });

    factory Adress.fromJson(Map<String, dynamic> myjson) => Adress(
      id: myjson['id'],
      commune: myjson['commune'],
      ville: myjson['ville'],
      logitude: myjson['logitude'],
      latitude: myjson['latitude'],
    );
}