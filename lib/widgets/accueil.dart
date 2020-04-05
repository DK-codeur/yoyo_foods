import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoyo_foods/screens/categories.dart';
import 'package:yoyo_foods/shared/public_shared.dart';
import '../providers/data_provider.dart';
import '../widgets/resto_item.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {

  @override
  Widget build(BuildContext context) {
    
    final restos = Provider.of<RestoProvider>(context).resto;
    
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Categories(),

          Column(
            children: <Widget>[
              buildTitleText('All your resto here '),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 70),
                itemCount: restos.length,
                itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: restos[i],
                  child: RestoItem(),
                ),
              ),
            ],
          ),

        ],
        
      ),
    );      
    }
  } // state



  

  // Container buildTitle(String str) {
  //   return Container(
  //     padding: EdgeInsets.only(left: 7),
  //     height: 30,
  //     color: white,
  //     child: Row(
  //       children: <Widget>[
  //         Text('$str', style: TextStyle(
  //           fontFamily: 'CenturyGhotic',
  //           fontSize: 18,
  //         ),)
  //       ],
  //     )
  //   );
  // }

  // Widget buildRestoItem(BuildContext context) {
    // return Container(
    //   margin: EdgeInsets.symmetric(vertical: 7),
    //   child: Stack(
    //     children: <Widget>[
    //       Container(
    //         width: MediaQuery.of(context).size.width * 0.95,
    //         height: MediaQuery.of(context).size.height / 5,
    //         decoration: BoxDecoration(
    //           // color: primaryPink, 
    //           borderRadius: BorderRadius.circular(12),
    //           border: Border.all(color: Colors.grey[300])
    //         ),

    //         child: Row(
    //           children: <Widget>[
    //             ClipRRect(
    //               borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(12),
    //                 bottomLeft: Radius.circular(12)
    //               ),

    //               child: GestureDetector(
    //                 onTap: () => Navigator.of(context).pushNamed(DetailScreen.routeName),
    //                 child: Image.asset(
    //                   'images/resto.jpg',
    //                   height: MediaQuery.of(context).size.height / 5,
    //                   width: MediaQuery.of(context).size.width / 2.6,
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //             ),

    //             Padding(
    //               padding: const EdgeInsets.only(left: 25, top: 5, bottom: 5),
    //               child: Container(
    //                 height: MediaQuery.of(context).size.height / 5,
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: <Widget>[
    //                         Text(
    //                           'Burger King',
    //                           style: TextStyle(
    //                             fontFamily: 'Poppins',
    //                             fontSize: 17,
    //                             color: primaryColor,
    //                             fontWeight: FontWeight.w500
    //                           ),
    //                         ),

    //                         Row(  
    //                           children: <Widget>[
    //                             Icon(Icons.location_on, size: 15, color: darkText,),
    //                             Text(
    //                               'Abidjan . Cocody',
    //                               style: TextStyle(
    //                                 fontFamily: 'Poppins',
    //                                 fontSize: 12,
    //                                 color: darkText
    //                               ),
    //                             ),
    //                           ],
    //                         ), 
    //                       ],
    //                     ),


    //                      Column(
    //                        crossAxisAlignment: CrossAxisAlignment.start,
    //                        children: <Widget>[
    //                          Row(
    //                           children: <Widget>[
    //                             Icon(Icons.restaurant, size: 16, color: darkText,),
    //                             Text(
    //                               ' Occidentaux',
    //                               style: TextStyle(
    //                                 fontFamily: 'Poppins',
    //                                 fontSize: 16,
    //                                 color: darkText
    //                               ),
    //                             ),
    //                           ],
    //                         ), 

    //                         Row(
    //                           children: <Widget>[
    //                             Icon(Icons.call, size: 15, color: darkText,),
    //                             Text(
    //                               ' 98 00 03 03',
    //                               style: TextStyle(
    //                                 fontFamily: 'Poppins',
    //                                 fontSize: 15,
    //                                 color: darkText,
    //                                 fontWeight: FontWeight.bold
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                        ],
    //                      )

                        
    //                   ],
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),


    //       Positioned(
    //         // left: 140,
    //         // top: 30.0,
    //         left: MediaQuery.of(context).size.width / 2.57,
    //         top: MediaQuery.of(context).size.width / 11.8,
    //         child: Stack(
    //           children: <Widget>[
    //             Container(
    //               transform: Matrix4.rotationZ(math.pi * 10 / 40),
    //               width: 29,
    //               height: 29,
    //               decoration: BoxDecoration(
    //                 color: Colors.black12,
    //                 boxShadow: [
    //                   BoxShadow(
    //                     offset: Offset(1, 1),
    //                     blurRadius: 5,
    //                     color: Colors.grey[400]
    //                   )
    //                 ]
    //               ),
                  
    //             ),
               
    //           ],
    //         ),
    //       ),

    //       Positioned(
    //         // left: 111.0,
    //         // top: 21.0,
    //         left: MediaQuery.of(context).size.width / 3.25,
    //         top: MediaQuery.of(context).size.width / 16.8,
    //         child:  Container(
    //           // transform: Matrix4.rotationY(math.pi * 1 / 65) ,
    //           child: IconButton(
    //             icon: Icon(Icons.directions, size: 42.7, color: white,),
    //             onPressed: () {},
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  // }

  // Widget buildCard() {
  //   return Card(
  //     elevation: 5,
  //     margin: EdgeInsets.all(9),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(6)
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         ClipRRect(
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(6),
  //             topRight: Radius.circular(6),
  //           ),

  //           child: Image.asset(
  //             'images/resto.jpg',
  //             height: 63,
  //             width: MediaQuery.of(context).size.width / 2.7,
  //             fit: BoxFit.cover,
  //           ),
  //         ),

  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 3),
  //           child: Text(
  //             'Burger King',
  //             overflow: TextOverflow.fade,
  //             style: TextStyle(
  //               fontFamily: 'CenturyGhotic',
  //               fontSize: 12,
  //             ),
  //           ),
  //         ),

  //       ],
  //     ),
  //   );
  // }







//map in column children

// children: restos.map((resto) {
//   return ChangeNotifierProvider.value(
//     value: restos[rr],
//     child: RestoItem(),
//   );
// }).toList()