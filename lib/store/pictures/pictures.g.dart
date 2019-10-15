// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pictures.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Pictures on _Pictures, Store {
  Computed<ObservableList<Picture>> _$usedPicturesComputed;

  @override
  ObservableList<Picture> get usedPictures => (_$usedPicturesComputed ??=
          Computed<ObservableList<Picture>>(() => super.usedPictures))
      .value;

  final _$loadingAtom = Atom(name: '_Pictures.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$itemsAtom = Atom(name: '_Pictures.items');

  @override
  ObservableList<Picture> get items {
    _$itemsAtom.context.enforceReadPolicy(_$itemsAtom);
    _$itemsAtom.reportObserved();
    return super.items;
  }

  @override
  set items(ObservableList<Picture> value) {
    _$itemsAtom.context.conditionallyRunInAction(() {
      super.items = value;
      _$itemsAtom.reportChanged();
    }, _$itemsAtom, name: '${_$itemsAtom.name}_set');
  }

  final _$addItemAsyncAction = AsyncAction('addItem');

  @override
  Future<void> addItem(String path) {
    return _$addItemAsyncAction.run(() => super.addItem(path));
  }

  final _$fetchItemsAsyncAction = AsyncAction('fetchItems');

  @override
  Future fetchItems() {
    return _$fetchItemsAsyncAction.run(() => super.fetchItems());
  }

  final _$_PicturesActionController = ActionController(name: '_Pictures');

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_PicturesActionController.startAction();
    try {
      return super.setLoading(value);
    } finally {
      _$_PicturesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadItem(File file) {
    final _$actionInfo = _$_PicturesActionController.startAction();
    try {
      return super.loadItem(file);
    } finally {
      _$_PicturesActionController.endAction(_$actionInfo);
    }
  }
}
