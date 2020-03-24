import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoyo_foods/shared/colors.dart';
import 'package:yoyo_foods/widgets/app_bar_props.dart';

import '../providers/data_provider.dart';
import '../screens/edit_resto_screen.dart';
import '../screens/login_screen.dart';
import '../shared/public_shared.dart';
import '../widgets/accueil.dart';
import '../widgets/resto_offline_screen.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  var _isInit = true;
  var _isLoading = false;


  @override
  void initState() {
    _widget = Accueil();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<RestoProvider>(context).fetchAndSetResto().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }


  final menu = new Menu(
    items: [
      new MenuItem(
        id: 'accueil',
        title: 'Accueil',
        icon: Icons.store
      ),
      new MenuItem(
        id: 'offline',
        title: 'Mes retos offline',
        icon: Icons.signal_wifi_off
      ),

      new MenuItem(
        id: 'login',
        title: 'Sign in',
        icon: Icons.person_outline
      ),
      
      new MenuItem(
        id: 'other3',
        title: 'Sortir',
        icon: Icons.power_settings_new
      ),
    ],
  );

  var selectedMenuItemId = 'accueil';
  Widget _widget;


  Future<void> refreshResto(BuildContext context) async {
    await Provider.of<RestoProvider>(context, listen: false).fetchAndSetResto();
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: new DrawerScaffold(
        percentage: 0.7,
          appBar: buildAppBarProps(context),

          menuView: new MenuView(
            menu: menu,
            animation: true,
            color: Colors.black87,
            selectedItemId: selectedMenuItemId,
            background: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/back.png',
              )
            ),

            onMenuItemSelected: (String itemId) {
              selectedMenuItemId = itemId;
              if (itemId == 'accueil') {
                setState(() => _widget = Accueil());
              } else if (itemId == 'offline') {
                setState(() => _widget = RestoOfflineScreen());
              } else if (itemId == 'login') {
                setState(() {
                  selectedMenuItemId = 'accueil';
                  _widget = Accueil();
                });
                Navigator.of(context).pushNamed(LoginScreen.routename);
              } else {
                setState(() => _widget = Center(child: Text("Deconnecting...")));
              }
            },
          ),
          
          contentView: Screen(
            contentBuilder: (context) => LayoutBuilder(
              builder: (context, constraint) => Container(
                color: Colors.white,
                width: constraint.maxWidth,
                height: constraint.maxHeight,
                child: FutureBuilder(
                  future: refreshResto(context),
                  builder: (ctx, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      print('waiting');
                      return Center(child: Text('Loading...'),);
                    } else{ 

                      //hasData...
                      
                      print('Stop load');

                      return  RefreshIndicator(
                        onRefresh: () => refreshResto(context),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              height: 50,
                              color: Colors.black,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'YoYo',
                                    style: TextStyle(
                                      fontSize:22,
                                      fontFamily: 'Poppins',
                                      color: white
                                    ),
                                    
                                  ),
                                  Text(
                                    'Foods',
                                    style: TextStyle(
                                      fontSize:25,
                                      fontFamily: 'Pacifico',
                                      color: Colors.redAccent
                                    ),
                                  ),
                                ],
                              )
                            ),

                            Flexible(
                              // flex: 10,
                              fit: FlexFit.tight,
                              child: ListView(
                                children: <Widget>[
                                  SizedBox(
                                    height: 50,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 8,
                                      itemBuilder: (ctx, i) {
                                        return Column(
                                          children: <Widget>[
                                            FlutterLogo(),
                                            Container(
                                              height: 20,
                                              width: 60,
                                              child: Text(i.toString())
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),

                                  _widget
                                ],
                              )
                            )
                          ],
                        )
                        
                      );
                    }
                  }
                 
                )
            ),
            // color: white,
          )
        ),
      
      ),

      floatingActionButton: FloatingActionButton(
        child: _isLoading ? CircularProgressIndicator(backgroundColor: Colors.white,) : Icon(Icons.add_circle) ,
        tooltip: 'Add resto',
        shape: (_isLoading) ? CircleBorder() : DiamondBorder(),
        backgroundColor: Colors.black,
        onPressed: (_isLoading) ? () {} : () => Navigator.push(
          context, 
          new MaterialPageRoute(
            builder: (context) {
              return new EditRestoScreen(
                title: ' Ajouter un restaurant',
                icon: Icons.add_box,
              );
            }
          )),
        elevation: 20,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  
  }

  