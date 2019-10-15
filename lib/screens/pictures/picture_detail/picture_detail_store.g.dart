// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PictureDetailStore on _PictureDetail, Store {
  Computed<bool> _$isPlayingComputed;

  @override
  bool get isPlaying =>
      (_$isPlayingComputed ??= Computed<bool>(() => super.isPlaying)).value;

  final _$pictureAtom = Atom(name: '_PictureDetail.picture');

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

  final _$statusAtom = Atom(name: '_PictureDetail.status');

  @override
  PlayStatus get status {
    _$statusAtom.context.enforceReadPolicy(_$statusAtom);
    _$statusAtom.reportObserved();
    return super.status;
  }

  @override
  set status(PlayStatus value) {
    _$statusAtom.context.conditionallyRunInAction(() {
      super.status = value;
      _$statusAtom.reportChanged();
    }, _$statusAtom, name: '${_$statusAtom.name}_set');
  }

  final _$_PictureDetailActionController =
      ActionController(name: '_PictureDetail');

  @override
  void switchPlay() {
    final _$actionInfo = _$_PictureDetailActionController.startAction();
    try {
      return super.switchPlay();
    } finally {
      _$_PictureDetailActionController.endAction(_$actionInfo);
    }
  }

  @override
  void upgradeVersion() {
    final _$actionInfo = _$_PictureDetailActionController.startAction();
    try {
      return super.upgradeVersion();
    } finally {
      _$_PictureDetailActionController.endAction(_$actionInfo);
    }
  }
}
