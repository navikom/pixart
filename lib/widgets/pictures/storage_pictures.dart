import 'package:flutter/material.dart';
import 'package:pixart/locator.dart';
import 'package:pixart/store/pictures/pictures.dart';
import 'package:pixart/widgets/pictures/pictures_list.dart';

class StoragePictures extends StatelessWidget {
  final bool isList;
  final Pictures pictures = locator<Pictures>();

  StoragePictures({Key key, this.isList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    pictures.setContext(context);
    return PicturesList(isList: isList, pictures: pictures.items);
  }
}
