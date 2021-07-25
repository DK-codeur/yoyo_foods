import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:yoyo_foods/sqflite/db.dart';
import '../providers/models/resto.dart';
import 'package:http/http.dart' as http;

class RestoProvider with ChangeNotifier{
  final String publicLink = 'http://192.168.43.59:8024/yoyo_food_api/api/resto';

  List<Resto> _resto = [];
  List<Resto> get resto {
    return [..._resto];
  }

  //sqflite
  List<Resto> _restoOffline = [];
  List<Resto> get restoOffline {
    return [..._restoOffline];
  }

  Future<void> fetchAndSetResto() async {
    final url = '$publicLink/read.php';

    try {
      
      final response = await http.get(url);
      print('get:' + '${response.statusCode}');
      final extractedData = json.decode(response.body);

      if(extractedData == null) {
        return;
      }

      // print(extractedData);
      // final List<Resto> loadedResto = [];
      // for (var i = 0; i < extractedData.length; i++) {
      //   var restoItem = Resto.fromJson(extractedData[i]); 
      //   loadedResto.add(restoItem);
      // }

      // _resto = loadedResto;
      // notifyListeners();

      // _resto.map((resto) {
      //   DBSql.insert('resto', resto);
      // }).toList();

      print(['all Instance of Resto']);
      // print('OFFLINE : $_restoOffline');

      //sqflite
      for (var i = 0; i < extractedData.length; i++) {
        DBSql.insert(
          'resto', 
          Resto.fromJson(extractedData[i])
        );
      }

    } catch (error) {
      throw error;
    }
  }

  //sqflite : get
  Future<void> fetchAndSetOfflineResto() async {
    final dataList = await DBSql.getData('resto');
    _restoOffline = dataList.map((resto) => Resto(
      id: resto['id'].toString(),
      nom: resto['nom'],
      type: resto['type'],
      ville: resto['ville'],
      commune: resto['commune'],
      tel: resto['tel'],
      longi: resto['longi'],
      lati: resto['lati'],
      image: resto['image'],
    )).toList();
    notifyListeners();
  }

  Resto findById(String id) {
    return _restoOffline.firstWhere( (resto) => resto.id == id);
  }

  // Resto findById(String id) {
  //   return _resto.firstWhere( (resto) => resto.id == id);
  // }

  Future<void> addResto(Resto resto) async {
    final url = '$publicLink/create.php';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'nom': resto.nom,
          'type': resto.type,
          'ville': resto.ville,
          'commune': resto.commune,
          'tel': resto.tel,
          'longi': resto.longi,
          'lati': resto.lati,
          'image': 'images/default.jpg'
        })
      );

       print('post:' + '${response.statusCode}');

      //recup resto to insert in resto list
      // final newResto = Resto(
      //   nom: resto.nom,
      //   type: resto.type,
      //   ville: resto.ville,
      //   commune: resto.commune,
      //   tel: resto.tel,
      //   longi: resto.longi,
      //   lati: resto.lati,
      //   image: resto.image
      // );

      // _resto.add(newResto);
      // _resto.insert(0, newResto);
      // notifyListeners();

    } catch (error) {
      throw error;
    }
  }

  // void removeResto(var id) async{
  //   _resto.removeWhere((resto) => resto.id == id);
  //   notifyListeners();
  // }

  Future<void> updateResto(String id, Resto newResto) async {
    // final restoIndex = _resto.indexWhere((resto) => resto.id == id);
    // print('Resto Index : $restoIndex');
    // if (restoIndex >= 0) {
        final url = '$publicLink/update.php?id=$id';

      try {
        final response = await http.put(
          url,
          body: json.encode({
            'nom': newResto.nom,
            'type': newResto.type,
            'ville': newResto.ville,
            'commune': newResto.commune,
            'tel': newResto.tel,
            'longi': newResto.longi,
            'lati': newResto.lati,
            'image': newResto.image
          })
        );

        print('update :' + '${response.body}');

      } catch (e) {
        throw e;
      }

    //   _resto[restoIndex] = newResto;
    // } else {
    //   print('bad index');
    // }
  }

  Future<void> deleteResto(var id) async {
    final url = '$publicLink/delete.php?id=$id';

    final response = await http.delete(url);
    // notifyListeners();
    print('delete :' + '${response.body}');
  }

}