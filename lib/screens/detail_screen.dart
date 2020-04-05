import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/data_provider.dart';
import '../screens/edit_resto_screen.dart';
import '../shared/colors.dart';
import '../shared/public_shared.dart';


class DetailScreen extends StatefulWidget {
  static const routeName = '/detail';

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  Widget build(BuildContext context) {

    final restoId = ModalRoute.of(context).settings.arguments as String;
    final resto = Provider.of<RestoProvider>(context, listen: false).findById(restoId);

    Future<Null> confirmDelete() async {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0.0),
            title: Text('SUPPRIMER ?', style: TextStyle(fontSize: 17)),
            titleTextStyle: TextStyle(
              color: Colors.red,
              fontFamily: 'Poppins'
            ),
            content: new Text('Êtes-vous sûr de supprimer ce Resto ?'),
            contentTextStyle: new TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('ANNULER', style: TextStyle(color: Colors.black)),
                onPressed: () => Navigator.of(context).pop() ,
              ),

              FlatButton(
                child: Text('OK'),
                textColor: Colors.red,
                onPressed: () async {
                  await Provider.of<RestoProvider>(context, listen: false).deleteResto(resto.id);
                  // Navigator.of(context).popUntil(predicate);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                  EdgeAlert.show(context, icon: Icons.delete, title: 'Succès', description: 'Resto supprimé avec succès !', backgroundColor: Colors.green, duration: 2);

                  Future.delayed(Duration.zero).then((_) {
                    Provider.of<RestoProvider>(context).fetchAndSetResto();
                  });

                },
              )
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
          ),
      );
    }
    
   
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            expandedHeight: 250,
            leading: CircleAvatar(
              backgroundColor: Colors.black38,
              child: IconButton(
                padding: EdgeInsets.all(0),
                iconSize: 18,
                icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                onPressed: () => Navigator.of(context).pop(context)
              ),
            ),

            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                '${resto.nom}',
                style: TextStyle(
                  shadows: [
                    Shadow(
                      offset: Offset(1.5, 1.5),
                      blurRadius: 2
                    )
                  ],
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
              ),

              background: Container(
                color: primaryColor,
                child: Hero(
                  tag: resto.id,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/load_img.png',
                    image: ('$publicLink/${resto.image}'.isEmpty) ? '$publicLink/images/default.jpg' : '$publicLink/${resto.image}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate(
              <Widget> [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    buildListTile(Icons.restaurant, (resto.type != '') ? resto.type : 'null', 'Type'),
                    buildListTile(Icons.location_on, (resto.ville != '') ? '${resto.ville}, ${resto.commune}' : 'null', 'Ville - commune'),
                    buildListTile(Icons.call, (resto.tel != '') ? '${resto.tel}' : 'null' , 'Telephone'),
                    buildListTile(Icons.my_location, (resto.longi != null) ? '${resto.longi}' : 'null', 'Longitude'),
                    buildListTile(Icons.my_location, (resto.lati != null) ? '${resto.lati}' : 'null', 'Latitude'),

                    Divider(),

                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton.icon(
                          elevation: 14,
                          icon: Icon(Icons.edit, color: white,),
                          label: Text(
                            'Modifier ',
                            textScaleFactor: 1.3,
                            style: TextStyle(
                              color: white
                            ),
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   new MaterialPageRoute(
                            //     builder: (context) {
                            //       return new EditRestoScreen(
                            //         title: ' Modifier le resto',
                            //         icon: Icons.edit,
                            //       );
                            //     },
                            //     settings: RouteSettings(arguments: resto.id) 
                            //   ) 
                            // );

                            Navigator.push(
                            context, 
                              CupertinoPageRoute(
                              builder: (context) => EditRestoScreen(
                                title: ' Modifier le resto',
                                icon: Icons.edit,
                              ),
                              settings: RouteSettings(
                                arguments: resto.id
                              )
                            ),
                          );
                          },
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            )
                          ),
                        ),

                        RaisedButton.icon(
                          elevation: 14,
                          icon: Icon(Icons.delete_outline, color: white,),
                          label: Text(
                            'Supprimer',
                            textScaleFactor: 1.3,
                            style: TextStyle(
                              color: white
                            ),
                          ),
                          onPressed:  confirmDelete ,
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            )
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 50,),
                  ],
                )
              ] 
            )
          )

          
        ],
      ),
    );
  }

  ListTile buildListTile(IconData icon, String title, subtitle) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins'
        ),
      ),

      subtitle: Text(subtitle),
    );
  }
}