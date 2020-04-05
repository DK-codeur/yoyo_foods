import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './providers/data_provider.dart';
import './screens/detail_screen.dart';
import './screens/edit_resto_screen.dart';
import './screens/home_page.dart';
import './screens/login_screen.dart';

//flutter create --androidx yoyo_food

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new RestoProvider(),
      child: MaterialApp(
        title: 'YoYo foods',
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.black
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,

        routes: {
          HomePage.routeName: (ctx) => HomePage(),
          DetailScreen.routeName: (ctx) => DetailScreen(),
          EditRestoScreen.routeName: (ctx) => EditRestoScreen(),
          LoginScreen.routename: (ctx) => LoginScreen(),
        },
      ),
    );
  }
}

