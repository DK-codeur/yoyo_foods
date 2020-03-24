import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/data_provider.dart';
import '../providers/resto.dart';
import '../shared/colors.dart';

class EditRestoScreen extends StatefulWidget {
  static const routeName = '/create';

  final String title;
  final IconData icon;

  const EditRestoScreen({this.title, this.icon});

  @override
  _EditRestoScreenState createState() => _EditRestoScreenState();
}

class _EditRestoScreenState extends State<EditRestoScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  var _isInit = true;

  final _typeFocusNode = FocusNode();
  final _villeFocusNode = FocusNode();
  final _communeFocusNode = FocusNode();
  final _telFocusNode = FocusNode();
  final _longiFocusNode = FocusNode();
  final _latiFocusNode = FocusNode();
  //image...


  @override
  void dispose() {
    _typeFocusNode.dispose();
    _villeFocusNode.dispose();
    _communeFocusNode.dispose();
    _telFocusNode.dispose();
    _longiFocusNode.dispose();
    _latiFocusNode.dispose();
    super.dispose();
  }

  var selectedType;
  List<String> _typeList = <String> [
    'Fast-food',
    'Burger',
    'Pizza',
    'Resto',
    'Limonaderie',
    'African',
    'Boisson'
  ];

  var _editedResto = Resto(
    id : null,
    nom: '',
    type: '',
    ville: '',
    commune: '',
    tel: '',
    longi: '',
    lati: '',
    image: '',
  );

  var _initValues = {
    'nom': '',
    'type': null,
    'ville': '',
    'commune': '',
    'tel': '',
    'longi': '',
    'lati': '',
    // image: '',
  };

  @override
  didChangeDependencies() {
    if(_isInit) {
      final restoId = ModalRoute.of(context).settings.arguments as String;
      print('restoId: $restoId');
      if (restoId != null) {
        _editedResto = Provider.of<RestoProvider>(context, listen: false).findById(restoId);
        print('_editedResto ID: ${_editedResto.id}');
        _initValues = {
          'nom': _editedResto.nom,
          'type': _editedResto.type,
          'ville': _editedResto.ville,
          'commune': _editedResto.commune,
          'tel': _editedResto.tel,
          'longi': _editedResto.longi,
          'lati': _editedResto.lati,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }



  Future<void> _submit() async {
    if(!_formKey.currentState.validate()) {
      return ;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if(_editedResto.id != null) {
      await Provider.of<RestoProvider>(context, listen: false).updateResto(_editedResto.id, _editedResto);
      EdgeAlert.show(context, title: 'Succès', description: 'Resto modifié avec succès !', backgroundColor: Colors.blueAccent, duration: 2);
    } else {
      try {
        await Provider.of<RestoProvider>(context, listen: false).addResto(_editedResto);
        EdgeAlert.show(context, title: 'Succès', description: 'Resto crée avec succès !', backgroundColor: Colors.green, duration: 2);
      } catch (error) {
        //
        throw error;
      }
    }

    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).pop(context);
    
    
    Future.delayed(Duration.zero).then((_) {
      Provider.of<RestoProvider>(context).fetchAndSetResto();
    });

  }

  Widget _labelField() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        initialValue: _initValues['nom'],
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Nom du resto',
          prefixIcon: Icon(Icons.restaurant)
        ),

        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_villeFocusNode);
        },

        validator: (value) {
          if(value.isEmpty) {
            return 'Le nom du retaurant SVP';
          }

          return null;
        },

        onSaved: (value) {
          _editedResto = Resto(
            nom: value,
            type: _editedResto.type,
            ville: _editedResto.ville,
            commune: _editedResto.commune,
            tel: _editedResto.tel,
            longi: _editedResto.longi,
            lati: _editedResto.lati,
            //image...
          );
        },
      ),
    );
  }

  // Widget _typeField() {
  //   return Padding(
  //     padding: const EdgeInsets.all(4.0),
  //     child: TextFormField(
  //       keyboardType: TextInputType.text,
  //       decoration: InputDecoration(
  //         labelText: 'Type du resto',
  //         prefixIcon: Icon(Icons.fastfood)
  //       ),

  //       focusNode: _typeFocusNode,
  //       textInputAction: TextInputAction.next,
  //       onFieldSubmitted: (_) {
  //         FocusScope.of(context).requestFocus(_villeFocusNode);
  //       },

  //       validator: (value) {
  //         if(value.isEmpty) {
  //           return 'Le nom du retaurant SVP';
  //         }

  //         return null;
  //       },
  //     ),
  //   );
  // }

  Widget _typeField() {
    return DropdownButtonFormField(
      items: _typeList.map((type) => DropdownMenuItem(
        child: Text(type, ),
        value: type,
      )).toList(),

      onChanged: (value) {
        setState(() {
          _initValues['type'] = value;
        });
      },

      value: _initValues['type'],
      hint: Text('Type du resto'),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.fastfood) 
      ),

      onSaved: (value) {
        _editedResto = Resto(
          nom: _editedResto.nom,
          type: value,
          ville: _editedResto.commune,
          commune: _editedResto.commune,
          tel: _editedResto.tel,
          longi: _editedResto.longi,
          lati: _editedResto.lati,
          //image...
        );
      },
        
      validator: (value) {
        if (value == null) {
          return 'Selectionnez le type du resto';
        }

        return null;
      },
    );
  }

  Widget _villeField() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
         initialValue: _initValues['ville'],
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Ville',
          prefixIcon: Icon(Icons.location_on),
        ),

        focusNode: _villeFocusNode,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_communeFocusNode);
        },

        validator: (value) {
          if(value.isEmpty) {
            return 'Entrez la ville';
          }
          return null;
        },

        onSaved: (value) {
          _editedResto = Resto(
          nom: _editedResto.nom,
          type: _editedResto.type,
          ville: value,
          commune: _editedResto.commune,
          tel: _editedResto.tel,
          longi: _editedResto.longi,
          lati: _editedResto.lati,
          //image...
        );
        },
      ),
    );
  }

  Widget _communeField() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        initialValue: _initValues['commune'],
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Commune',
          prefixIcon: Icon(Icons.add_location)
        ),

        focusNode: _communeFocusNode,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_telFocusNode);
        },

        validator: (value) {
          if(value.isEmpty) {
            return 'Entrez une commune';
          }
          return null;
        },

        onSaved: (value) {
          _editedResto = Resto(
            nom: _editedResto.nom,
            type: _editedResto.type,
            ville: _editedResto.ville,
            commune: value,
            tel: _editedResto.tel,
            longi: _editedResto.longi,
            lati: _editedResto.lati,
            //image...
          );
        },
      ),
    );
  }

  Widget _phoneField() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextFormField(
          initialValue: _initValues['tel'],
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Telephone',
            prefixIcon: Icon(Icons.call)
          ),

          focusNode: _telFocusNode,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_longiFocusNode);
          },

          maxLength: 8,
          validator: (value) {
            if(value.isEmpty) {
              return 'Entrez un numero de telephone';
            }

            if(value.length < 8) {
              return 'Numero invalide';
            }

            return null;
          },

          onSaved: (value) {
            _editedResto = Resto(
            nom: _editedResto.nom,
            type: _editedResto.type,
            ville: _editedResto.ville,
            commune: _editedResto.commune,
            tel: value,
            longi: _editedResto.longi,
            lati: _editedResto.lati,
            //image...
        );
          },
        ),
      ),
    );
  }

  Widget _longField() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextFormField(
          initialValue: _initValues['longi'],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Longitude',
            prefixIcon: Icon(Icons.location_searching)
          ),

          focusNode: _longiFocusNode,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_latiFocusNode);
          },

          // validator: (value) {
          //   if(value.isEmpty) {
          //     return ''
          //   }
          // },

          onSaved: (value) {
            _editedResto = Resto(
              nom: _editedResto.nom,
              type: _editedResto.type,
              ville: _editedResto.ville,
              commune: _editedResto.commune,
              tel: _editedResto.tel,
              longi: value,
              lati: _editedResto.lati,
              //image...
            );
          },
        ),
      ),
    );
  }

   Widget _latiField() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextFormField(
          initialValue: _initValues['lati'],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Latitude',
            prefixIcon: Icon(Icons.location_searching)
          ),

          focusNode: _latiFocusNode,
          textInputAction: TextInputAction.done,

          onSaved: (value) {
            _editedResto = Resto(
          nom: _editedResto.nom,
          type: _editedResto.type,
          ville: _editedResto.ville,
          commune: _editedResto.commune,
          tel: _editedResto.tel,
          longi: _editedResto.longi,
          lati: value,
          //image...
        );
          },
        ),
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(context),
          ),
          title: Row(
            children: <Widget>[
              Icon(widget.icon),
              Text(widget.title),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: (_isLoading)? CircularProgressIndicator(backgroundColor: Colors.white,): Icon(Icons.save),
              onPressed: _submit
            )
          ],
          centerTitle: true,

        ),

        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _typeField(),
                    _labelField(),
                    _villeField(),
                    _communeField(),
                    _phoneField(),

                    Row(
                      children: <Widget>[
                        Expanded(child: _longField()),
                        Expanded(child: _latiField())
                      ],
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border.all()
                          ),
                        ),
                        OutlineButton.icon(
                          icon: Icon(Icons.add_a_photo),
                          textColor: darkText,
                          label: Text('Choisir...'),
                          onPressed: () {},
                          borderSide: BorderSide(
                            color: darkText
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15,),

                    // OutlineButton.icon(
                    //   icon: Icon(Icons.add),
                    //   label: Text(' Ajouter '),
                    //   color: Colors.blue,
                    //   borderSide: BorderSide(
                    //     color: primaryColor
                    //   ),
                    //   textColor: primaryColor,
                    //   onPressed: () {},
                    // ),

                    // SizedBox(height: 15,)
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}