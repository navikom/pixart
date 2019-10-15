import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pixart/store/pictures/pixels_set.dart';
import 'package:pixart/utils/color_helper.dart';

part 'pixel.g.dart';

enum FlashStatus {
  ShouldFlash,
  Fleshed,
}

class Pixel = _Pixel with _$Pixel;

abstract class _Pixel with Store {
  static Color highlight = Colors.orange;
  static HSVColor highlightHSV = HSVColor.fromColor(highlight);

  int index;
  Color origin;
  HSVColor originHSV;
  Color gray;
  HSVColor grayHSV;
  int colorIndex;
  bool painted = false;
  bool traversed = false;
  bool selected = false;
  FlashStatus flashStatus = FlashStatus.Fleshed;

  PixelsSet parent;

  _Pixel(this.index, this.origin, this.gray, this.colorIndex) {
    originHSV = HSVColor.fromColor(origin);
    grayHSV = HSVColor.fromColor(gray);
    if (isOriginWhite) {
      painted = true;
    }
  }

  bool get isOriginWhite =>
      originHSV.alpha == 1.0 &&
      originHSV.hue == 0.0 &&
      originHSV.saturation == 0.0 &&
      originHSV.value == 1.0;

  bool get isGrayWhite =>
      grayHSV.alpha == 1.0 &&
      grayHSV.hue == 0.0 &&
      grayHSV.saturation == 0.0 &&
      grayHSV.value == 1.0;

  Color get currentColor {
    if (painted) {
      return parent.color;
    }
    return selected ? highlight : gray;
  }

  bool get shouldHighlight => selected && !painted;

  bool get souldFlash => flashStatus == FlashStatus.ShouldFlash;

  Color get textColor => ColorHelper.textColorByColor(currentColor);

  void onTap() {
    painted = true;
  }

  void revert() {
    painted = false;
  }

  void setSelected([bool value = true]) {
    selected = value;
  }

  void setParent(PixelsSet pixelsSet) {
    parent = pixelsSet;
  }

  void makeFlash() {
    flashStatus = FlashStatus.ShouldFlash;
  }

  void flashed() {
    flashStatus = FlashStatus.Fleshed;
  }

  String toString() {
    return '{\n "index": $index,\n "origin": $origin,\n "gray": $gray,\n "painted": $painted,\n}';
  }
}
