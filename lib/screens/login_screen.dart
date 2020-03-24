import 'package:animatedloginbutton/animatedloginbutton.dart';
import 'package:flutter/material.dart';
import '../shared/colors.dart';

class LoginScreen extends StatefulWidget {
  static const routename = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<RestoProvider>(context).getAndSetResto();
    // });
    super.initState();
  }

  final _formKey =  GlobalKey<FormState>();



  Widget _emailField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Entrer votre email',
          prefixIcon: Icon(Icons.email),
          border: OutlineInputBorder()
        ),
      ),
    );
  }

  Widget _passWordField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Entrez votre mot de passe',
          prefixIcon: Icon(Icons.lock),
          border: OutlineInputBorder()
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2.7,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    // bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(80),
                  )
                ),

                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 52,
                          child: CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 46,
                            child: Icon(Icons.restaurant_menu, size: 60, color: Colors.white,),
                          )
                        ),

                        Text(
                          'yoyo foods',
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            color: Colors.white,
                            fontSize: 24
                          ),
                        ),

                        Text(
                          '- LOGIN -',
                          style: TextStyle(
                            fontFamily: 'CenturyGhotic',
                            color: Colors.white,
                            fontSize: 12
                          ),
                        )
                      ],
                    ),

                    // Positioned(
                    //   top:15,
                    //   left: 1,
                    //   child: IconButton(
                    //     icon: Icon(Icons.close, color: white,),
                    //     onPressed: () {},
                    //   ),
                    // )
                  ],
                ),
              ),

              // SizedBox(height: 15,),

              Form(
                key: _formKey,
                child: Container(
                  height: ((MediaQuery.of(context).size.height) - (MediaQuery.of(context).size.height / 2.7)),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80)
                      )
                    ),
                    elevation: 40,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 13),
                    child: Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Column(
                        children: <Widget>[

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              // IconButton(
                              //   icon: Icon(Icons.group_add),
                              //   onPressed: () {},
                              // )
                              GestureDetector(
                                onTap: () {},
                                child: Icon(Icons.group_add, size: 30,),
                              )
                            ],
                          ),
                          _emailField(),
                          _passWordField(),

                          SizedBox(height: 20,),

                          // OutlineButton.icon(
                          //   borderSide: BorderSide(
                          //     color: Colors.red,
                          //     width: 2
                          //   ),
                          //   icon: Icon(Icons.person_pin), //group_add
                          //   label: Text('Je me connecte'),
                          //   onPressed: () {}
                          // ),

                          AnimatedLoginButton(
                            loginTip: 'Je me connecte',
                            buttonColorNormal: Colors.black87,
                            onTap: () async {

                            },
                          )

                          


                        ],
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}