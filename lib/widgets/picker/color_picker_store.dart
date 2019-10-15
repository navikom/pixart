import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pixart/store/pictures/picture.dart';
import 'package:pixart/store/pictures/pixels_set.dart';

part 'color_picker_store.g.dart';

class ColorPickerStore = _ColorPicker with _$ColorPickerStore;

abstract class _ColorPicker with Store {
  @observable
  Picture picture;
  @observable
  PixelsSet pixelsSet;
  @observable
  HSVColor originColor;
  @observable
  Color originRGBAColor;
  @observable
  HSVColor currentHsvColor;
  Timer timer;

  ReactionDisposer pixelsSetDisposer;

  _ColorPicker(this.picture) {
    pixelsSetDisposer =
        reaction((_) => picture.currentPixelsSet, (PixelsSet pixelsSet) {
      update(pixelsSet);
    });
    update(null);
  }

  @action
  void update(PixelsSet pSet) {
    if (pSet == null) {
      currentHsvColor = HSVColor.fromAHSV(0.0, 0.0, 0.0, 0.0);
      originColor = currentHsvColor;
      pixelsSet = null;
      originRGBAColor = Colors.white;
    } else {
      pixelsSet = pSet;
      originColor = pSet.hsvOriginColor;
      currentHsvColor = pSet.hsvColor;
      originRGBAColor = pSet.originColor;
    }
  }

  @action
  void onColorChanged(HSVColor hsv) {
    currentHsvColor = hsv;
    clearTimer();
    if (pixelsSet == null) {
      return;
    }
    timer = Timer(Duration(milliseconds: 500), () {
      pixelsSet.setExtraColor(hsv.toColor());
      timer.cancel();
    });
  }

  @action
  void resetColor() {
    pixelsSet.resetColor();
    update(pixelsSet);
  }

  void clearTimer() {
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
  }

  @action
  void dispose() {
    clearTimer();
    pixelsSetDisposer();
  }

  @override
  String toString() {
    return '{"pixelsSet": $pixelsSet, "originColor": $originColor, "currentHsvColor": $currentHsvColor, "timer": $timer}';
  }
}
