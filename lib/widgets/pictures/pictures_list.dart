import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:pixart/store/pictures/picture.dart';
import 'package:pixart/widgets/picture/picture_item_button.dart';
import 'package:provider/provider.dart';

class PicturesList extends StatelessWidget {
  final bool isList;
  final ObservableList<Picture> pictures;
  final double padding = 40.0;

  PicturesList({Key key, this.isList, this.pictures}) : super(key: key);

  Widget _list(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double minScreenSize = min(size.width, size.height);
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        thickness: .3,
        color: Theme.of(context).dividerColor,
      ),
      itemBuilder: (context, index) {
        final Picture p = pictures[index];
        final double maxPictureSize = max(p.width, p.height) + padding;
        final double size = minScreenSize / maxPictureSize;
        return Container(
          child: Provider<Picture>.value(
            value: p,
            child: PicturesItemButton(size: size),
          ),
          alignment: Alignment.center,
        );
      },
      itemCount: pictures.length,
    );
  }

  Border _gridDivider(BuildContext context, int index) {
    final bool isOdd = index % 2 != 0;
    final Color color = Theme.of(context).dividerColor;
    if (index == 0) {
      return null;
    }

    if (index == 1) {
      return Border(
        left: BorderSide(color: color, width: .3),
      );
    }

    if (isOdd) {
      return Border(
        left: BorderSide(color: color, width: .3),
        top: BorderSide(color: color, width: .3),
      );
    }

    return Border(
      top: BorderSide(color: color, width: .3),
    );
  }

  Widget _grid(BuildContext context) {
    final int length = pictures.length;
    final bool isEven = length % 2 == 0;
    final Size size = MediaQuery.of(context).size;
    final double minScreenSize = min(size.width, size.height);
    return GridView.builder(
      itemCount: isEven ? length : length + 1,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        double size;
        Picture p;
        if (index < length) {
          p = pictures[index];
          final double maxPictureSize = max(p.width, p.height) + padding / 2;
          size = minScreenSize / maxPictureSize / 2;
        }
        return Container(
          decoration: BoxDecoration(border: _gridDivider(context, index)),
          child: index == length
              ? Container()
              : Provider<Picture>.value(
                  value: p,
                  child: PicturesItemButton(size: size),
                ),
          alignment: Alignment.center,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => isList ? _list(context) : _grid(context),
    );
  }
}
