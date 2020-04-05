import 'package:flutter/material.dart';
import 'package:yoyo_foods/shared/colors.dart';
import 'package:yoyo_foods/shared/public_shared.dart';
import 'package:yoyo_foods/widgets/cat_model.dart';
import 'package:yoyo_foods/widgets/categorie_item.dart';

class Categories extends StatelessWidget {

  final List<CatModel> catModelList = categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildTitleText('All Categories'),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: catModelList.length,
            itemBuilder: (BuildContext context, int index){
              return CategorieItem(
                categoryName: catModelList[index].categoryName,
                imagePath: catModelList[index].imagePath,
                numberOfItems: catModelList[index].numberOfItems,
              );
            },
          ),
        ),
      ],
    );
  }

  
}


final categories = [
  CatModel(
    numberOfItems: 43,
    imagePath: "assets/images/burger.png",
    categoryName: "Burger"
  ),

  CatModel(
    numberOfItems: 23,
    imagePath: "assets/images/pizza.png",
    categoryName: "Pizza"
  ),

    CatModel(
    numberOfItems: 23,
    imagePath: "assets/images/coffee-cup.png",
    categoryName: "Coffe Cup"
  ),

    CatModel(
    numberOfItems: 90,
    imagePath: "assets/images/beer.png",
    categoryName: "Beer"
  ),

    CatModel(
    numberOfItems: 55,
    imagePath: "assets/images/cheeseburger.png",
    categoryName: "Cheese Burger"
  ),
];