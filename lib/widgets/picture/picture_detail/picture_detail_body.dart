import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pixart/screens/pictures/picture_detail/picture_detail_store.dart';
import 'package:pixart/store/pictures/picture.dart';
import 'package:pixart/store/pictures/pixel.dart';
import 'package:pixart/utils/color_helper.dart';
import 'package:pixart/widgets/picture/picture_detail/picture_detail_footer.dart';
import 'package:provider/provider.dart';

class PictureDetailBody extends StatefulWidget {
  final PictureDetailStore store;

  const PictureDetailBody({Key key, this.store}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PictureDetailState();
}

class _PictureDetailState extends State<PictureDetailBody> {
  @override
  Widget build(BuildContext context) {
    PictureDetailStore store = widget.store;
    final Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    final double screenMinLength = min(size.width, size.height);
    final double cellSize = orientation == Orientation.portrait
        ? screenMinLength / store.picture.width
        : screenMinLength / store.picture.height;
    final footerHeight = 200.0;
    return Column(
      children: <Widget>[
        Provider<PictureDetailStore>(
          builder: (_) => store,
          child: Consumer<PictureDetailStore>(
            builder: (_, value, child) => Container(
              alignment: Alignment.topCenter,
              child: Observer(
                builder: (_) {
                  int versionValue = value.version.value;
                  return Container(
                    width: value.picture.width * cellSize,
                    height: value.picture.height * cellSize,
                    child: CustomPaint(
                      painter:
                          _PictureDetailClipper(value, cellSize, versionValue),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Provider<PictureDetailStore>.value(
          value: store,
          child: PictureDetailFooter(height: footerHeight),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.store.dispose();
  }
}

class _PictureDetailClipper extends CustomPainter {
  final PictureDetailStore store;
  final double size;
  final int version;

  _PictureDetailClipper(this.store, this.size, this.version);

  @override
  void paint(Canvas canvas, Size size) {
    drawTiles(canvas);
  }

  void drawTiles(Canvas canvas) {
    final Paint paint = Paint();
    Picture picture = store.picture;
    final int width = picture.width;
    List<_PixelSplash> splashes = new List<_PixelSplash>();

    for (int y = 0; y < picture.height; y++) {
      for (int x = 0; x < width; x++) {
        paint.color = store.currentColor(y * width + x);
        final double xOffset = x * size;
        final double yOffset = y * size;
        Pixel p = store.pixelsData[y * width + x];
        if (p.souldFlash) {
          splashes.add(_PixelSplash(p, Offset(xOffset, yOffset), size));
        }
        var rect = Rect.fromLTWH(xOffset, yOffset, size, size);
        canvas.drawRect(rect, paint);
      }
    }
    drawSplash(canvas, splashes);
  }

  void drawSplash(Canvas canvas, List<_PixelSplash> splashes) {
    final Paint paint = Paint();
    splashes.forEach((_PixelSplash ps) {
      ps.draw(canvas, paint);
    });
    Timer(Duration(milliseconds: 100), () => store.upgradeVersion());
  }

  void drawGrid(Canvas canvas, Paint paint) {
    Picture picture = store.picture;
    final int w = picture.width;
    final int h = picture.height;
    final Offset fullsize = Offset(h * size, w * size);
    paint.color = Color.fromARGB((1 * 150).ceil(), 171, 183, 183);
    for (int i = 1; i < w; i++) {
      double j = i * size;
      canvas.drawLine(Offset(0, j), Offset(fullsize.dy, j), paint);
      canvas.drawLine(Offset(j, 0), Offset(j, fullsize.dx), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _PixelSplash {
  final Pixel pixel;
  final Offset offset;
  final double size;

  _PixelSplash(this.pixel, this.offset, this.size);

  void draw(Canvas canvas, Paint paint) {
    paint.color = Colors.orange;
    paint.maskFilter = MaskFilter.blur(
        BlurStyle.normal, ColorHelper.convertRadiusToSigma(size));
    canvas.drawCircle(offset.translate(size / 2, size / 2), size * 2, paint);
    pixel.flashed();
  }
}
