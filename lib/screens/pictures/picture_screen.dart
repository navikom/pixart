import 'package:flutter/material.dart';
import 'package:pixart/config/main_theme.dart';
import 'package:pixart/store/pictures/picture.dart';
import 'package:pixart/widgets/art_widget/pixel_art_widget.dart';
import 'package:pixart/widgets/picture/picture_footer.dart';
import 'package:pixart/widgets/picture/picture_header.dart';
import 'package:pixart/widgets/zoom/zoom_widget.dart';
import 'package:provider/provider.dart';

class PictureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Picture picture = Provider.of<Picture>(context);
    print('Picture data: ${picture.pixelsData.length}');
    final Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    final EdgeInsets insets = MediaQuery.of(context).padding;
    final double footerHeight = 100.0;
    final double headerHeight = 50.0;
    return Container(
      color: bgNavColor,
      child: SafeArea(
        // bottom: false,
        child: Scaffold(
          body: Zoom(
            minScale: orientation == Orientation.portrait
                ? size.width / picture.fullsize.dx
                : size.height / picture.fullsize.dy,
            frameSize: Offset(
                size.width,
                size.height -
                    insets.top -
                    insets.bottom -
                    headerHeight -
                    footerHeight),
            maxSize: Offset(picture.fullsize.dx, picture.fullsize.dy),
            onPositionUpdate: (Offset offset) => picture.setOffset(offset),
            onScaleUpdate: (double scale) => picture.setZoom(scale),
            onTap: (Offset point) => picture.onTap(point),
            onDoubleTap: (Offset point) => picture.onDoubleTap(point),
            onLongPress: (Offset point) => picture.handleNeighbors(point),
            child: Consumer<Picture>(
              builder: (context, value, child) =>
                  PixelArtWidget(value, footerHeight),
            ),
            header: Consumer<Picture>(
              builder: (context, value, child) =>
                  PictureHeader(value, headerHeight),
            ),
            footer: Consumer<Picture>(
              builder: (context, value, child) =>
                  PictureFooter(value, footerHeight),
            ),
            headerHeight: headerHeight,
          ),
        ),
      ),
    );
  }
}
