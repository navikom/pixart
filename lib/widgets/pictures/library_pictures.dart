import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pixart/locator.dart';
import 'package:pixart/store/pictures/pictures.dart';
import 'package:pixart/widgets/pictures/pictures_list.dart';

class LibPictures extends StatelessWidget {
  final LibraryPictures pictures = locator<LibraryPictures>();
  final bool isList;

  LibPictures({Key key, this.isList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double iconSize = min(size.width, size.height);
    return pictures.items.length > 0
        ? PicturesList(isList: isList, pictures: pictures.items)
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
