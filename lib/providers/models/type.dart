import 'package:flutter/material.dart';

class Typ with ChangeNotifier{
  int createdAt;
  int updatedAt;
  int id;
  String name;

  Typ({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.name,
  });
}