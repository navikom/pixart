import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pixart/components/tile.dart';
import 'package:pixart/store/pictures/picture.dart';
import 'package:pixart/store/pictures/pixel.dart';
import 'package:pixart/store/pictures/pixels_set.dart';

class PixelArtWidget extends StatefulWidget {
  final double footerHeight;
  final Picture picture;

  PixelArtWidget(this.picture, this.footerHeight);

  @override
  State<StatefulWidget> createState() => _PixelArtState();
}

class _PixelArtState extends State<PixelArtWidget> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Picture picture = widget.picture;
    double size = picture.size;
    picture.setScreensize(
        Size(screenSize.width, screenSize.height - (widget.footerHeight)));

    return GestureDetector(
      child: Container(
        width: picture.width * size,
        height: picture.height * size,
        child: Observer(
          builder: (_) {
            return CustomPaint(
              painter: PixelArtClipper(
                  picture,
                  picture.historyLength,
                  picture.currentPixelsSet,
                  picture.nonPintedAnimationValue.value),
              child: Container(),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class PixelArtClipper extends CustomPainter {
  final Picture picture;
  final int repaintTrigger;
  final PixelsSet pixelset;
  final double splashValue;
  final List<_PixelSplash> splashes = new List<_PixelSplash>();

  PixelArtClipper(
      this.picture, this.repaintTrigger, this.pixelset, this.splashValue);

  @override
  void paint(Canvas canvas, Size size) {
    drawTiles(canvas);
  }

  void drawTiles(Canvas canvas) {
    final Paint paint = Paint();
    final int width = picture.width;
    final double size = picture.size;
    for (int y = 0; y < picture.height; y++) {
      for (int x = 0; x < width; x++) {
        Pixel pixel = picture.pixelsData[y * width + x];
        final Offset offset = Offset(x * size, y * size);
        if (picture.shouldBeDraw(x, y)) {
          Tile(offset, size, paint, picture.scale, pixel)..render(canvas);
          if (!pixel.painted && (pixelset == null || pixel.selected)) {
            splashes.add(
                _PixelSplash(offset.translate(size / 2, size / 2), pixel.gray));
          }
        }
      }
    }
    if (splashValue > .1 &&
        (splashes.length < 50 || (pixelset == null && splashes.length < 200))) {
      drawSplash(canvas);
    }

    if (picture.scale > 0.7) {
      drawGrid(canvas, paint);
    }
  }

  void drawGrid(Canvas canvas, Paint paint) {
    final int h = picture.height;
    final double size = picture.size;
    final Offset fullsize = picture.fullsize;
    paint.color = Color.fromARGB((picture.scale * 150).ceil(), 171, 183, 183);
    for (int i = 1; i < h; i++) {
      double j = i * size;
      canvas.drawLine(Offset(0, j), Offset(fullsize.dy, j), paint);
      canvas.drawLine(Offset(j, 0), Offset(j, fullsize.dx), paint);
    }
  }

  void drawSplash(Canvas canvas) {
    final Paint splashPaint = Paint();
    Color o = Colors.orange;
    Color orange = Color.fromARGB(100, o.red, o.green, o.blue);
    double circleRaduis = splashValue * .3;
    double ringRaduis = splashValue * .5;
    double circleRaduis2 = splashValue * .8;
    double ringRaduis2 = splashValue;
    splashes.forEach((_PixelSplash p) => p.draw(canvas, splashPaint,
        circleRaduis, ringRaduis, circleRaduis2, ringRaduis2, orange));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _PixelSplash {
  final Offset center;
  Color color;

  _PixelSplash(this.center, this.color) {
    color = Color.fromARGB(100, color.red, color.green, color.blue);
  }

  void draw(Canvas canvas, Paint paint, double circle, double ring,
      double circle1, double ring1, Color color1) {
    paint.color = color1;
    canvas.drawCircle(center, ring1, paint);
    paint.color = color;
    canvas.drawCircle(center, circle1, paint);
    paint.color = color1;
    canvas.drawCircle(center, ring, paint);
    paint.color = color;
    canvas.drawCircle(center, circle, paint);
  }
}
