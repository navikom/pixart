// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pixels_set.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PixelsSet on _PixelsSet, Store {
  Computed<Color> _$colorComputed;

  @override
  Color get color =>
      (_$colorComputed ??= Computed<Color>(() => super.color)).value;

  final _$originColorAtom = Atom(name: '_PixelsSet.originColor');

  @override
  Color get originColor {
    _$originColorAtom.context.enforceReadPolicy(_$originColorAtom);
    _$originColorAtom.reportObserved();
    return super.originColor;
  }

  @override
  set originColor(Color value) {
    _$originColorAtom.context.conditionallyRunInAction(() {
      super.originColor = value;
      _$originColorAtom.reportChanged();
    }, _$originColorAtom, name: '${_$originColorAtom.name}_set');
  }

  final _$extraColorAtom = Atom(name: '_PixelsSet.extraColor');

  @override
  Color get extraColor {
    _$extraColorAtom.context.enforceReadPolicy(_$extraColorAtom);
    _$extraColorAtom.reportObserved();
    return super.extraColor;
  }

  @override
  set extraColor(Color value) {
    _$extraColorAtom.context.conditionallyRunInAction(() {
      super.extraColor = value;
      _$extraColorAtom.reportChanged();
    }, _$extraColorAtom, name: '${_$extraColorAtom.name}_set');
  }

  final _$_PixelsSetActionController = ActionController(name: '_PixelsSet');

  @override
  void resetColor() {
    final _$actionInfo = _$_PixelsSetActionController.startAction();
    try {
      return super.resetColor();
    } finally {
      _$_PixelsSetActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExtraColor(Color color) {
    final _$actionInfo = _$_PixelsSetActionController.startAction();
    try {
      return super.setExtraColor(color);
    } finally {
      _$_PixelsSetActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelected([bool value = true]) {
    final _$actionInfo = _$_PixelsSetActionController.startAction();
    try {
      return super.setSelected(value);
    } finally {
      _$_PixelsSetActionController.endAction(_$actionInfo);
    }
  }
}
