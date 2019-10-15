import 'package:flutter/material.dart';
import 'package:pixart/store/pictures/pixel.dart';

class ColorHelper {
  static const int WHITE = 4294967295;

  static Color textColorByColor(Color color) =>
      (color.red * 0.299 + color.green * 0.587 + color.blue * 0.114) > 186
          ? Colors.black54
          : Colors.white;

  static bool isWhite(Color color) {
    return color.value == WHITE;
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  static List<int> uint32ToRGBA(int pixel) {
    var r = pixel & 0xff;
    var g = (pixel >> 8) & 0xff;
    var b = (pixel >> 16) & 0xff;
    var a = pixel >> 24;
    return [a, r, g, b];
  }

  static List<int> uint32ToRGB(int pixel) {
    var r = pixel & 0xff;
    var g = (pixel >> 8) & 0xff;
    var b = (pixel >> 16) & 0xff;
    return [0xff, r, g, b];
  }

  static void blend(List<Pixel> list) {
    list.sort((Pixel a, Pixel b) {
      int h = a.originHSV.hue.compareTo(b.originHSV.hue);
      if (h != 0) {
        return h;
      }
      int s = a.originHSV.saturation.compareTo(b.originHSV.saturation);
      if (s != 0) {
        return s;
      }
      return a.originHSV.value.compareTo(b.originHSV.value);
    });
  }
}
