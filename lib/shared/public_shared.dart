import 'package:flutter/material.dart';

import 'colors.dart';

final String publicLink = 'http://192.168.43.59:8024/yoyo_food_api';


class DiamondBorder extends ShapeBorder {

  const DiamondBorder();

  @override
  EdgeInsetsGeometry get dimensions {
    return const EdgeInsets.only();
  }

  @override
  Path getInnerPath(Rect rect, { TextDirection textDirection }) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, { TextDirection textDirection }) {
    return Path()
      ..moveTo(rect.left + rect.width / 2.0, rect.top)
      ..lineTo(rect.right, rect.top + rect.height / 2.0)
      ..lineTo(rect.left + rect.width  / 2.0, rect.bottom)
      ..lineTo(rect.left, rect.top + rect.height / 2.0)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, { TextDirection textDirection }) {}

  // This border doesn't support scaling.
  @override
  ShapeBorder scale(double t) {
    return null;
  }
}


Padding buildTitleText(String text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(11, 24, 0, 10),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
              color: darkText 
            ),
          ),
        ],
    ),
  );
}