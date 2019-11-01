import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pixart/locator.dart';
import 'package:pixart/store/pictures/pictures.dart';
import 'package:pixart/widgets/pictures/library_pictures.dart';
import 'package:pixart/widgets/pictures/pictures_history.dart';
import 'package:pixart/widgets/pictures/storage_pictures.dart';

enum ListStatus { List, Grid }

class PicturesPages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PicturesPagesState();
}

class _PicturesPagesState extends State<PicturesPages> {
  final LibraryPictures pictures = locator<LibraryPictures>();
  final PageController _controller = PageController(initialPage: 1);
  double _currentPage;
  ListStatus _listStatus = ListStatus.Grid;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page;
      });
    });
    _currentPage = 1.0;
  }

  bool get isList => _listStatus == ListStatus.List;

  void _switchListStatus() {
    setState(() {
      _listStatus =
          _listStatus == ListStatus.List ? ListStatus.Grid : ListStatus.List;
    });
  }

  void _getImage() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    pictures.loadItem(file);
  }

  Matrix4 _transform(int position) {
    return Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateX(_currentPage - position)
      ..rotateY(_currentPage - position)
      ..rotateZ(_currentPage - position);
  }

  Widget _renderScreen(int position) {
    return position == 0
        ? LibPictures(isList: isList)
        : position == 1
            ? StoragePictures(isList: isList)
            : PicturesHistory(isList: isList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _currentPage == 0
            ? IconButton(
                splashColor: Color(0x20FFB64D),
                iconSize: IconTheme.of(context).size,
                icon: Icon(Icons.photo_camera),
                onPressed: () => _getImage(),
              )
            : Container(),
        centerTitle: true,
        title: Container(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.fiber_manual_record,
                  size: _currentPage.floor() == 0 ? 35 : 25),
              Icon(Icons.fiber_manual_record,
                  size: _currentPage.floor() == 1 ? 35 : 25),
              Icon(Icons.fiber_manual_record,
                  size: _currentPage.floor() == 2 ? 35 : 25),
            ],
          ),
        ),
        actions: <Widget>[
          Transform.rotate(
            angle: pi / 2,
            child: IconButton(
              splashColor: Color(0x20FFB64D),
              iconSize: IconTheme.of(context).size,
              icon: Icon(isList ? Icons.view_module : Icons.view_column),
              onPressed: () => _switchListStatus(),
            ),
          ),
        ],
      ),
      body: PageView.builder(
          itemCount: 3,
          controller: _controller,
          itemBuilder: (context, position) {
            if (position == _currentPage) {
              return Transform(
                alignment: Alignment.center,
                transform: _transform(position),
                child: _renderScreen(position),
              );
            } else if (position == _currentPage.floor() + 1) {
              return Transform(
                alignment: Alignment.center,
                transform: _transform(position),
                child: _renderScreen(position),
              );
            } else {
              return _renderScreen(position);
            }
          }),
    );
  }
}
