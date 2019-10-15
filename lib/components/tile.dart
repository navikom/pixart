import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pixart/store/pictures/pixel.dart';
import 'package:pixart/utils/color_helper.dart';

class Tile {
  final Offset offset;
  final double size;
  final Paint paint;
  final double scale;
  final Pixel pixel;

  Tile(this.offset, this.size, this.paint, this.scale, this.pixel);

  void render(Canvas canvas) {
    paint.color = pixel.currentColor;
    var rect = Rect.fromLTWH(offset.dx, offset.dy, size, size);
    if (pixel.shouldHighlight) {
      paint.maskFilter = MaskFilter.blur(
          BlurStyle.inner, ColorHelper.convertRadiusToSigma(30));
    } else {
      paint.maskFilter = null;
    }
    canvas.drawRect(rect, paint);
    if (scale > .7 && !ColorHelper.isWhite(paint.color) && !pixel.painted) {
      drawText(canvas);
    }
  }

  void drawText(Canvas canvas) {
    final double fontSize = size * .5;
    final textStyle = TextStyle(
      color: pixel.textColor,
      fontSize: fontSize,
    );
    final textSpan = TextSpan(
      text: pixel.colorIndex.toString(),
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size,
    );
    Offset drawPosition = Offset(offset.dx + size / 2 - textPainter.width / 2,
        offset.dy + size / 2 - textPainter.height / 2);
    textPainter.paint(canvas, drawPosition);
  }
}
