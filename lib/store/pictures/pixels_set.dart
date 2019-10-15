import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pixart/store/pictures/picture.dart';
import 'package:pixart/store/pictures/pixel.dart';
import 'package:pixart/store/pictures/pixel_history.dart';

part 'pixels_set.g.dart';

class PixelsSet = _PixelsSet with _$PixelsSet;

abstract class _PixelsSet with Store {
  List<Pixel> pixels = new List<Pixel>();
  HSVColor hsvOriginColor;
  HSVColor hsvExtraColor;
  Picture parent;

  @observable
  Color originColor;
  @observable
  Color extraColor;
  _PixelsSet(this.originColor, this.parent) {
    hsvOriginColor = HSVColor.fromColor(originColor);
  }

  @computed
  Color get color => extraColor != null ? extraColor : originColor;

  HSVColor get hsvColor => extraColor != null ? hsvExtraColor : hsvOriginColor;

  int get size => pixels.length;

  @action
  void resetColor() {
    extraColor = null;
    hsvExtraColor = null;
    parent.history
        .add(PixelHistory(parent.colors.indexOf(originColor), originColor));
  }

  @action
  void setExtraColor(Color color) {
    extraColor = color;
    hsvExtraColor = HSVColor.fromColor(color);
    parent.history.add(PixelHistory(parent.colors.indexOf(originColor), color));
  }

  @action
  void setSelected([bool value = true]) {
    pixels.forEach((Pixel pixel) => pixel.setSelected(value));
  }

  @override
  String toString() {
    return '{"hsvOriginColor": $hsvOriginColor, "hsvExtraColor": $hsvExtraColor, "originColor": $originColor, "extraColor": $extraColor}';
  }
}
