import 'package:flutter/material.dart';
import 'package:pixart/store/pictures/picture.dart';

class PixelArtSmallWidget extends StatelessWidget {
  final Picture picture;
  final double size;
  PixelArtSmallWidget(this.picture, this.size);

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          width: picture.width * size,
          height: picture.height * size,
          // decoration: BoxDecoration(color: Colors.blue),
          child: CustomPaint(
            painter: _PixelArtSmallClipper(picture, size),
            child: Container(),
          ),
        ),
      );
}

class _PixelArtSmallClipper extends CustomPainter {
  final Picture picture;
  final double size;

  _PixelArtSmallClipper(this.picture, this.size);

  @override
  void paint(Canvas canvas, Size size) {
    drawTiles(canvas);
  }

  void drawTiles(Canvas canvas) {
    final Paint paint = Paint();
    final int width = picture.width;

    for (int y = 0; y < picture.height; y++) {
      for (int x = 0; x < width; x++) {
        paint.color = picture.pixelsData[y * width + x].currentColor;
        final double xOffset = x * size;
        final double yOffset = y * size;
        var rect = Rect.fromLTWH(xOffset, yOffset, size, size);
        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
