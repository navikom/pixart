// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Picture on _Picture, Store {
  Computed<int> _$historyLengthComputed;

  @override
  int get historyLength =>
      (_$historyLengthComputed ??= Computed<int>(() => super.historyLength))
          .value;

  final _$pixelsDataAtom = Atom(name: '_Picture.pixelsData');

  @override
  List<Pixel> get pixelsData {
    _$pixelsDataAtom.context.enforceReadPolicy(_$pixelsDataAtom);
    _$pixelsDataAtom.reportObserved();
    return super.pixelsData;
  }

  @override
  set pixelsData(List<Pixel> value) {
    _$pixelsDataAtom.context.conditionallyRunInAction(() {
      super.pixelsData = value;
      _$pixelsDataAtom.reportChanged();
    }, _$pixelsDataAtom, name: '${_$pixelsDataAtom.name}_set');
  }

  final _$scaleAtom = Atom(name: '_Picture.scale');

  @override
  double get scale {
    _$scaleAtom.context.enforceReadPolicy(_$scaleAtom);
    _$scaleAtom.reportObserved();
    return super.scale;
  }

  @override
  set scale(double value) {
    _$scaleAtom.context.conditionallyRunInAction(() {
      super.scale = value;
      _$scaleAtom.reportChanged();
    }, _$scaleAtom, name: '${_$scaleAtom.name}_set');
  }

  final _$historyAtom = Atom(name: '_Picture.history');

  @override
  ObservableList<PixelHistory> get history {
    _$historyAtom.context.enforceReadPolicy(_$historyAtom);
    _$historyAtom.reportObserved();
    return super.history;
  }

  @override
  set history(ObservableList<PixelHistory> value) {
    _$historyAtom.context.conditionallyRunInAction(() {
      super.history = value;
      _$historyAtom.reportChanged();
    }, _$historyAtom, name: '${_$historyAtom.name}_set');
  }

  final _$neighboursStackAtom = Atom(name: '_Picture.neighboursStack');

  @override
  ObservableList<List<int>> get neighboursStack {
    _$neighboursStackAtom.context.enforceReadPolicy(_$neighboursStackAtom);
    _$neighboursStackAtom.reportObserved();
    return super.neighboursStack;
  }

  @override
  set neighboursStack(ObservableList<List<int>> value) {
    _$neighboursStackAtom.context.conditionallyRunInAction(() {
      super.neighboursStack = value;
      _$neighboursStackAtom.reportChanged();
    }, _$neighboursStackAtom, name: '${_$neighboursStackAtom.name}_set');
  }

  final _$currentPixelsSetAtom = Atom(name: '_Picture.currentPixelsSet');

  @override
  PixelsSet get currentPixelsSet {
    _$currentPixelsSetAtom.context.enforceReadPolicy(_$currentPixelsSetAtom);
    _$currentPixelsSetAtom.reportObserved();
    return super.currentPixelsSet;
  }

  @override
  set currentPixelsSet(PixelsSet value) {
    _$currentPixelsSetAtom.context.conditionallyRunInAction(() {
      super.currentPixelsSet = value;
      _$currentPixelsSetAtom.reportChanged();
    }, _$currentPixelsSetAtom, name: '${_$currentPixelsSetAtom.name}_set');
  }

  final _$setPixelsAsyncAction = AsyncAction('setPixels');

  @override
  Future<void> setPixels() {
    return _$setPixelsAsyncAction.run(() => super.setPixels());
  }

  final _$_PictureActionController = ActionController(name: '_Picture');

  @override
  void nonePaintedValueListener(double value) {
    final _$actionInfo = _$_PictureActionController.startAction();
    try {
      return super.nonePaintedValueListener(value);
    } finally {
      _$_PictureActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$_PictureActionController.startAction();
    try {
      return super.clear();
    } finally {
      _$_PictureActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleNeighborsStack(int length) {
    final _$actionInfo = _$_PictureActionController.startAction();
    try {
      return super.handleNeighborsStack(length);
    } finally {
      _$_PictureActionController.endAction(_$actionInfo);
    }
  }

  @override
  Image prepareImage(Uint8List bytes) {
    final _$actionInfo = _$_PictureActionController.startAction();
    try {
      return super.prepareImage(bytes);
    } finally {
      _$_PictureActionController.endAction(_$actionInfo);
    }
  }

  @override
  void createImage(Uint8List bytes) {
    final _$actionInfo = _$_PictureActionController.startAction();
    try {
      return super.createImage(bytes);
    } finally {
      _$_PictureActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addPixel(Image origin, Image gray, int x, int y) {
    final _$actionInfo = _$_PictureActionController.startAction();
    try {
      return super.addPixel(origin, gray, x, y);
    } finally {
      _$_PictureActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setZoom(double scaleValue) {
    final _$actionInfo = _$_PictureActionController.startAction();
    try {
      return super.setZoom(scaleValue);
    } finally {
      _$_PictureActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic paintPixel(int x, int y) {
    final _$actionInfo = _$_PictureActionController.startAction();
    try {
      return super.paintPixel(x, y);
    } finally {
      _$_PictureActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onTap(Offset point) {
    final _$actionInfo = _$_PictureActionController.startAction();
    try {
      return super.onTap(point);
    } finally {
      _$_PictureActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onDoubleTap(Offset point) {
    final _$actionInfo = _$_PictureActionController.startAction();
    try {
      return super.onDoubleTap(point);
    } finally {
      _$_PictureActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleNeighbors(Offset point) {
    final _$actionInfo = _$_PictureActionController.startAction();
    try {
      return super.handleNeighbors(point);
    } finally {
      _$_PictureActionController.endAction(_$actionInfo);
    }
  }

  @override
  void traverseNeighbours(List<int> coords) {
    final _$actionInfo = _$_PictureActionController.startAction();
    try {
      return super.traverseNeighbours(coords);
    } finally {
      _$_PictureActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectPixelsSet(PixelsSet pixels, bool isPickerOpened) {
    final _$actionInfo = _$_PictureActionController.startAction();
    try {
      return super.selectPixelsSet(pixels, isPickerOpened);
    } finally {
      _$_PictureActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$_PictureActionController.startAction();
    try {
      return super.dispose();
    } finally {
      _$_PictureActionController.endAction(_$actionInfo);
    }
  }
}
