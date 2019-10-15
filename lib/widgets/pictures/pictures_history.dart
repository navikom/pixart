import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pixart/locator.dart';
import 'package:pixart/store/pictures/picture.dart';
import 'package:pixart/store/pictures/pictures.dart';
import 'package:pixart/widgets/pictures/pictures_list.dart';

class PicturesHistory extends StatelessWidget {
  final Pictures pictures = locator<Pictures>();
  final bool isList;

  PicturesHistory({Key key, this.isList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double iconSize = min(size.width, size.height);
    ObservableList<Picture> list = pictures.usedPictures;
    return list.length > 0
        ? PicturesList(isList: isList, pictures: list)
        : Container(
            width: size.width,
            height: size.height,
            child: Icon(
              Icons.image,
              size: iconSize / 2,
              color: Theme.of(context).iconTheme.color.withAlpha(50),
            ),
          );
  }
}
