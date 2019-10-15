import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:mobx/mobx.dart';
import 'package:pixart/service/non_painted_animation_service.dart';
import 'package:pixart/store/pictures/directions.dart';
import 'package:pixart/store/pictures/pixel.dart';
import 'package:pixart/store/pictures/pixel_history.dart';
import 'package:pixart/store/pictures/pixels_set.dart';
import 'package:pixart/utils/color_helper.dart';

part 'picture.g.dart';

class Picture = _Picture with _$Picture;

abstract class _Picture with Store {
  static const int MAX_SIZE = 150;
  static const int MAX_LENGTH = 30000;

  String path;
  num width;
  num height;
  double size = 40.0;
  Offset offset = Offset.zero;
  Size screenSize;

  Map<m.Color, PixelsSet> pixelsMap = new Map();
  List<m.Color> colors = new List<m.Color>();

  @observable
  List<Pixel> pixelsData = [];
  @observable
  double scale = 0.0;
  @observable
  ObservableList<PixelHistory> history = new ObservableList<PixelHistory>();
  @observable
  ObservableList<List<int>> neighboursStack = new ObservableList<List<int>>();
  @observable
  PixelsSet currentPixelsSet;

  Observable<double> nonPintedAnimationValue =
      Observable(NonPaintedAnimationService.START_VALUE);

  ReactionDisposer stackDisposer;
  Timer timer;

  _Picture(this.path) {
    stackDisposer = reaction((_) => neighboursStack.length,
        (int length) => handleNeighborsStack(length));
  }

  @computed
  int get historyLength => history.length;

  bool get isPainted => allNonePaintedNumber == 0;

  int _allNonePaintedNumber() {
    int number = 0;
    int l = pixelsData.length;
    while (l-- > 0) {
      if (!pixelsData[l].painted) {
        number++;
      }
    }
    return number;
  }

  int _pixelsSetNonePaintedNumber() {
    int number = 0;
    int l = currentPixelsSet.pixels.length;
    while (l-- > 0) {
      if (!currentPixelsSet.pixels[l].painted) {
        number++;
      }
    }
    return number;
  }

  Computed<int> get nonePaintedNumber => currentPixelsSet == null
      ? Computed(_allNonePaintedNumber)
      : Computed(_pixelsSetNonePaintedNumber);

  int get allNonePaintedNumber => _allNonePaintedNumber();

  Offset get fullsize => Offset(width * size, height * size);

  m.Color getBorderColor(m.Color color) {
    final m.HSVColor hsv = m.HSVColor.fromColor(color);
    final m.HSVColor hsv1 = m.HSVColor.fromAHSV(hsv.alpha, hsv.hue,
        hsv.saturation, hsv.value > .8 ? hsv.value / 1.2 : hsv.value * 1.2);
    return hsv1.toColor();
  }

  @action
  void nonePaintedValueListener(double value) {
    nonPintedAnimationValue.value = value;
  }

  @action
  void clear() {
    if (timer != null) {
      timer.cancel();
    }
    if (currentPixelsSet != null) {
      selectPixelsSet(currentPixelsSet, false);
    }
  }

  @action
  void handleNeighborsStack(int length) {
    List<int> point = neighboursStack.removeLast();

    timer = new Timer(const Duration(milliseconds: 500), () {
      traverseNeighbours(point);
    });
  }

  @action
  Image prepareImage(Uint8List bytes) {
    Image image = decodeImage(bytes);
    int w = image.width;
    int h = image.height;
    if (w * h > MAX_LENGTH) {
      double diff = min(MAX_SIZE / w, MAX_SIZE / h);
      int nWidth = (w * diff).floor();
      int nHright = (h * diff).floor();
      return copyResize(image, width: nWidth, height: nHright);
    }
    return image;
  }

  @action
  Future<void> setPixels() async {
    ByteData imageData = await rootBundle.load(path);
    Uint8List bytes = imageData.buffer.asUint8List();
    createImage(bytes);
  }

  @action
  void createImage(Uint8List bytes) {
    Image preparedImage = prepareImage(bytes);

    Image image = quantize(preparedImage, numberOfColors: 20);
    Image imageGray = grayscale(image.clone());

    width = image.width;
    height = image.height;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        addPixel(image, imageGray, x, y);
      }
    }
  }

  @action
  void addPixel(Image origin, Image gray, int x, int y) {
    // origin image
    int cell = origin.getPixel(x, y);
    List<int> argb = ColorHelper.uint32ToRGB(cell);
    m.Color color = m.Color.fromARGB(argb[0], argb[1], argb[2], argb[3]);

    // gray image
    int grayPixel = gray.getPixel(x, y);
    List<int> grayArgb = ColorHelper.uint32ToRGB(grayPixel);
    m.Color grayColor =
        m.Color.fromARGB(grayArgb[0], grayArgb[1], grayArgb[2], grayArgb[3]);
    if (!ColorHelper.isWhite(color) && !colors.contains(color)) {
      colors.add(color);
    }

    Pixel pixel =
        Pixel(origin.index(x, y), color, grayColor, colors.indexOf(color) + 1);
    if (pixelsMap[color] == null) {
      pixelsMap[color] = PixelsSet(color, this);
    }
    pixelsMap[color].pixels.add(pixel);
    pixel.setParent(pixelsMap[color]);

    pixelsData.add(pixel);
  }

  @action
  void setZoom(double scaleValue) {
    scale = scaleValue;
  }

  @action
  dynamic paintPixel(int x, int y) {
    Pixel pixel = pixelsData[y * width + x];
    if (!pixel.selected) {
      return false;
    }
    if (!pixel.painted) {
      pixel.onTap();
      history.add(PixelHistory(pixel.index));
      return true;
    }
    return false;
  }

  @action
  dynamic onTap(Offset point) {
    int x = ((offset.dx * scale + point.dx) / (size * scale)).floor();
    int y = ((offset.dy * scale + point.dy) / (size * scale)).floor();
    if (x < width && y < height) {
      return paintPixel(x, y) ? [x, y] : false;
    }
    return false;
  }

  @action
  void onDoubleTap(Offset point) {}

  @action
  void handleNeighbors(Offset point) {
    dynamic coords = onTap(point);
    if (coords is List) {
      traverseNeighbours(coords);
    }
  }

  @action
  void traverseNeighbours(List<int> coords) {
    Pixel targetPixel = pixelsData[coords[1] * width + coords[0]];
    if (!targetPixel.selected || targetPixel.traversed) {
      return;
    }
    targetPixel.traversed = true;
    Direction(coords, width, height)
      ..traverseNeighbours((List<int> dirCoords) {
        Pixel pixel = pixelsData[dirCoords[1] * width + dirCoords[0]];
        if (targetPixel.origin == pixel.origin) {
          paintPixel(dirCoords[0], dirCoords[1]);
          if (!neighboursStack.any(
              (List<int> l) => l[0] == dirCoords[0] && l[1] == dirCoords[1])) {
            neighboursStack.add(dirCoords);
          }
        }
      });
  }

  @action
  void selectPixelsSet(PixelsSet pixels, bool isPickerOpened) {
    if (currentPixelsSet == null) {
      currentPixelsSet = pixels;
      currentPixelsSet.setSelected();
    } else if (currentPixelsSet == pixels) {
      if (!isPickerOpened) {
        currentPixelsSet.setSelected(false);
        currentPixelsSet = null;
        return;
      }
    } else {
      currentPixelsSet.setSelected(false);
      currentPixelsSet = pixels;
      currentPixelsSet.setSelected();
    }
  }

  @action
  void dispose() {
    clear();
    super.dispose();
  }

  bool shouldBeDraw(int x, int y) {
    double xOffset = x * size + size;
    double yOffset = y * size + size;
    double padding = -size;
    double startScreenX = offset.dx + padding;
    double startScreenY = offset.dy + padding;
    double endScreenX = offset.dx + screenSize.width / scale - padding + size;
    double endScreenY = offset.dy + screenSize.height / scale - padding + size;
    bool visible = xOffset > startScreenX &&
        xOffset < endScreenX &&
        yOffset > startScreenY &&
        yOffset < endScreenY;
    return visible;
  }

  setOffset(Offset value) {
    offset = value.scale(-1, -1);
  }

  setScreensize(Size value) {
    screenSize = value;
  }

  @override
  String toString() {
    return '{\n "path": $path,\n "pixelsData": $pixelsData,\n "offset": $offset,\n}';
  }
}
