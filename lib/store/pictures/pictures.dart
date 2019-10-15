import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:pixart/store/pictures/picture.dart';
import 'package:pixart/store/requestable.dart';
import 'package:pixart/widgets/dialog.dart' as dialog;
part 'pictures.g.dart';

class Pictures = _Pictures with _$Pictures;
class LibraryPictures = _Pictures with _$Pictures;

abstract class _Pictures extends Requestable with Store {
  @observable
  bool loading = false;
  @observable
  ObservableList<Picture> items = ObservableList<Picture>();
  BuildContext context;

  _Pictures() {
    reaction((_) => hasError, (bool error) => error ? showAlert() : null);
  }

  @computed
  ObservableList<Picture> get usedPictures =>
      ObservableList.of(items.where((Picture p) => p.historyLength > 0));

  @action
  void setLoading(bool value) {
    loading = value;
  }

  @action
  Future<void> addItem(String path) async {
    Picture item = Picture(path);
    items.add(item);
    await item.setPixels();
  }

  @action
  void loadItem(File file) {
    try {
      Picture item = Picture(file.path);
      items.add(item);
      item.createImage(file.readAsBytesSync());
    } catch (exception) {
      setError(exception.toString());
    }
  }

  @action
  Future fetchItems() async {
    List<String> images = [
      'assets/images/rubbit.png',
      'assets/images/vini.png',
      'assets/images/pony.png'
    ];
    try {
      for (int i = 0; i < images.length; i++) {
        addItem(images[i]);
      }
    } catch (exception) {
      setError(exception.toString());
    }
  }

  @override
  String toString() {
    return '{"loading: $loading", "items": $items}';
  }

  void setContext(BuildContext ctx) {
    context = ctx;
  }

  void showAlert() {
    print('Pictures Error: $error');
    dialog.show(
      context,
      'Pictures notification',
      Text(error),
      null,
    );
    setError(null);
  }
}
