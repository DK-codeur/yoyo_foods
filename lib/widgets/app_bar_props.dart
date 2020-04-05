import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import '../shared/colors.dart';

AppBarProps buildAppBarProps(BuildContext context) {
    return AppBarProps(
      backgroundColor: Colors.black,
      leadingIcon: Icon(Icons.sort),

      title: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 34,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(7)
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  // contentPadding: EdgeInsets.all(5),
                  hintText: '   Search here...',
                  suffixIcon: Material(
                    shadowColor: Colors.black,
                    elevation: 10.0,
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    child: Icon(Icons.search,)
                  ),
                  border: InputBorder.none
                ),
              ),
            ),
          ),

          IconButton(icon: Icon(Icons.person_outline, color: white, size: 30,), onPressed: null)
        ],
      ),
    
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: Container(
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
      )
    );
}


