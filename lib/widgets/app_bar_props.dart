import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import '../shared/colors.dart';

AppBarProps buildAppBarProps(BuildContext context) {
    return AppBarProps(
      backgroundColor: Colors.black,
      leadingIcon: Icon(Icons.sort),

      flexibleSpace: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
            // color: //
          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 35,
                ),
                
                Expanded(
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 34,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        hintText: 'Resto, FastFood, Snack...',
                        suffixIcon: Material(
                          shadowColor: Colors.black,
                          elevation: 10.0,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
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
          ),
        ),
      ),
      
    );
  }