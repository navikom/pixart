// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_picker_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ColorPickerStore on _ColorPicker, Store {
  final _$pictureAtom = Atom(name: '_ColorPicker.picture');

  @override
  Picture get picture {
    _$pictureAtom.context.enforceReadPolicy(_$pictureAtom);
    _$pictureAtom.reportObserved();
    return super.picture;
  }

  @override
  set picture(Picture value) {
    _$pictureAtom.context.conditionallyRunInAction(() {
      super.picture = value;
      _$pictureAtom.reportChanged();
    }, _$pictureAtom, name: '${_$pictureAtom.name}_set');
  }

  final _$pixelsSetAtom = Atom(name: '_ColorPicker.pixelsSet');

  @override
  PixelsSet get pixelsSet {
    _$pixelsSetAtom.context.enforceReadPolicy(_$pixelsSetAtom);
    _$pixelsSetAtom.reportObserved();
    return super.pixelsSet;
  }

  @override
  set pixelsSet(PixelsSet value) {
    _$pixelsSetAtom.context.conditionallyRunInAction(() {
      super.pixelsSet = value;
      _$pixelsSetAtom.reportChanged();
    }, _$pixelsSetAtom, name: '${_$pixelsSetAtom.name}_set');
  }

  final _$originColorAtom = Atom(name: '_ColorPicker.originColor');

  @override
  HSVColor get originColor {
    _$originColorAtom.context.enforceReadPolicy(_$originColorAtom);
    _$originColorAtom.reportObserved();
    return super.originColor;
  }

  @override
  set originColor(HSVColor value) {
    _$originColorAtom.context.conditionallyRunInAction(() {
      super.originColor = value;
      _$originColorAtom.reportChanged();
    }, _$originColorAtom, name: '${_$originColorAtom.name}_set');
  }

  final _$originRGBAColorAtom = Atom(name: '_ColorPicker.originRGBAColor');

  @override
  Color get originRGBAColor {
    _$originRGBAColorAtom.context.enforceReadPolicy(_$originRGBAColorAtom);
    _$originRGBAColorAtom.reportObserved();
    return super.originRGBAColor;
  }

  @override
  set originRGBAColor(Color value) {
    _$originRGBAColorAtom.context.conditionallyRunInAction(() {
      super.originRGBAColor = value;
      _$originRGBAColorAtom.reportChanged();
    }, _$originRGBAColorAtom, name: '${_$originRGBAColorAtom.name}_set');
  }

  final _$currentHsvColorAtom = Atom(name: '_ColorPicker.currentHsvColor');

  @override
  HSVColor get currentHsvColor {
    _$currentHsvColorAtom.context.enforceReadPolicy(_$currentHsvColorAtom);
    _$currentHsvColorAtom.reportObserved();
    return super.currentHsvColor;
  }

  @override
  set currentHsvColor(HSVColor value) {
    _$currentHsvColorAtom.context.conditionallyRunInAction(() {
      super.currentHsvColor = value;
      _$currentHsvColorAtom.reportChanged();
    }, _$currentHsvColorAtom, name: '${_$currentHsvColorAtom.name}_set');
  }

  final _$_ColorPickerActionController = ActionController(name: '_ColorPicker');

  @override
  void update(PixelsSet pSet) {
    final _$actionInfo = _$_ColorPickerActionController.startAction();
    try {
      return super.update(pSet);
    } finally {
      _$_ColorPickerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onColorChanged(HSVColor hsv) {
    final _$actionInfo = _$_ColorPickerActionController.startAction();
    try {
      return super.onColorChanged(hsv);
    } finally {
      _$_ColorPickerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetColor() {
    final _$actionInfo = _$_ColorPickerActionController.startAction();
    try {
      return super.resetColor();
    } finally {
      _$_ColorPickerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$_ColorPickerActionController.startAction();
    try {
      return super.dispose();
    } finally {
      _$_ColorPickerActionController.endAction(_$actionInfo);
    }
  }
}
