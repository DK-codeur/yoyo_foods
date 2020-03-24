import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/resto.dart';
import 'dart:math' as math;

import '../screens/detail_screen.dart';
import '../shared/colors.dart';
import '../shared/public_shared.dart';


class RestoItem extends StatefulWidget {

  @override
  _RestoItemState createState() => _RestoItemState();
}

class _RestoItemState extends State<RestoItem> {
  @override
  Widget build(BuildContext context) {

    final resto = Provider.of<Resto>(context, listen: false);

    return Center(
        child: Container(
        margin: EdgeInsets.symmetric(vertical: 7),
        child: Stack(
          children: <Widget>[
            Container(
              width: 342.0,
              height: 120.0,
              decoration: BoxDecoration(
                // color: primaryPink, 
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300])
              ),

              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)
                    ),

                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(
                        DetailScreen.routeName,
                        arguments: resto.id
                      ),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/load_img.png',
                        image: ('$publicLink/${resto.image}'.isEmpty) ? '$publicLink/images/default.jpg' : '$publicLink/${resto.image}',
                          height: 120.0,
                          width: 138.46153846153845,
                          fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  

                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 5, bottom: 5),
                    child: Container(
                      height: 120.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                (resto.nom != '') ? '${resto.nom}' : 'null',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 17,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500
                                ),
                              ),

                              Row(  
                                children: <Widget>[
                                  Icon(Icons.location_on, size: 15, color: darkText,),
                                  Text(
                                    (resto.ville != '') ? '${resto.ville} . ${resto.commune}' : 'null . null',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: darkText
                                    ),
                                  ),
                                ],
                              ), 
                            ],
                          ),


                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                               Row(
                                children: <Widget>[
                                  Icon(Icons.restaurant, size: 16, color: darkText,),
                                  Text(
                                    (resto.type != '') ? ' ${resto.type}' : 'null',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: darkText
                                    ),
                                  ),
                                ],
                              ), 

                              Row(
                                children: <Widget>[
                                  Icon(Icons.call, size: 15, color: darkText,),
                                  Text(
                                    (resto.tel != '') ? ' ${resto.tel}' : 'null',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      color: darkText,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                             ],
                           )
                          
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),


            Positioned(
              // left: 140,
              // top: 30.0,
              left: MediaQuery.of(context).size.width / 2.57,
              top: MediaQuery.of(context).size.width / 11.8,
              child: Stack(
                children: <Widget>[
                  Container(
                    transform: Matrix4.rotationZ(math.pi * 10 / 40),
                    width: 29,
                    height: 29,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, 1),
                          blurRadius: 5,
                          color: Colors.grey[400]
                        )
                      ]
                    ),
                    
                  ),
                 
                ],
              ),
            ),

            Positioned(
              // left: 111.0,
              // top: 21.0,
              left: MediaQuery.of(context).size.width / 3.25,
              top: MediaQuery.of(context).size.width / 16.8,
              child:  Container(
                // transform: Matrix4.rotationY(math.pi * 1 / 65) ,
                child: IconButton(
                  icon: Icon(Icons.directions, size: 42.7, color: white,),
                  onPressed: () async {
                    print('ID: ${resto.id}');
                    // await Provider.of<RestoProvider>(context, listen: false).deleteResto(resto.id);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}