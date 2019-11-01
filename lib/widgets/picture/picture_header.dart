import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pixart/config/main_theme.dart';
import 'package:pixart/locator.dart';
import 'package:pixart/service/navigation_service.dart';
import 'package:pixart/service/non_painted_animation_service.dart';
import 'package:pixart/store/pictures/picture.dart';
import 'package:pixart/store/pictures/pixels_set.dart';
import 'package:pixart/utils/color_helper.dart';
import 'package:pixart/constants/routes_path.dart' as constants;

class PictureHeader extends StatefulWidget {
  final Picture picture;
  final double height;

  PictureHeader(this.picture, this.height);

  @override
  State<StatefulWidget> createState() => _PictureHeaderState();
}

class _PictureHeaderState extends State<PictureHeader>
    with SingleTickerProviderStateMixin {
  final NavigationService _navigationService = locator<NavigationService>();
  NonPaintedAnimationService _animationsService;

  @override
  void initState() {
    super.initState();
    _animationsService = NonPaintedAnimationService(
        widget.picture.size, widget.picture.nonePaintedValueListener, this);
  }

  void _rightButtonClickHandler() {
    if (widget.picture.isPainted) {
      _navigateTo();
    } else {
      _animationsService.start();
    }
  }

  void _navigateTo() {
    _navigationService.navigateTo(constants.PICTURE_DETAIL_ROUTE,
        arguments: widget.picture);
  }

  void _navigateBack() {
    widget.picture.dispose();
    _navigationService.goBack();
  }

  @override
  Widget build(BuildContext context) {
    Picture picture = widget.picture;
    return Observer(
      builder: (_) {
        int historyLength = picture.historyLength;
        PixelsSet pixelsSet = picture.currentPixelsSet;
        Color circleColor = Theme.of(context).appBarTheme.iconTheme.color;
        Color textColor = Colors.white;
        int circleData = picture.nonePaintedNumber.value;

        double circleTextSize = circleData > 9999 ? 11.0 : 14.0;
        if (pixelsSet != null) {
          textColor = ColorHelper.textColorByColor(pixelsSet.color);
          circleColor = pixelsSet.originColor;
        }
        return picture.scale < .25
            ? Container(
                color: bgNavColor,
                height: widget.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      child: IconButton(
                        splashColor: Colors.transparent,
                        color: Theme.of(context).appBarTheme.iconTheme.color,
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () => _navigateBack(),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Align(
                      child: Text(
                        '',
                        style: Theme.of(context).appBarTheme.textTheme.title,
                      ),
                      alignment: Alignment.center,
                    ),
                    Align(
                      child: RawMaterialButton(
                        onPressed: () => _rightButtonClickHandler(),
                        shape: new CircleBorder(),
                        fillColor: circleColor,
                        constraints: BoxConstraints(minWidth: 40),
                        child: Center(
                          child: picture.isPainted
                              ? Icon(
                                  Icons.done_all,
                                  color: Colors.white,
                                  size: 25,
                                )
                              : Text(
                                  '$circleData',
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: circleTextSize),
                                ),
                        ),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
              )
            : Container();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationsService.dispose();
  }
}
