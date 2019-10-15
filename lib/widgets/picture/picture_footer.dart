import 'dart:math';

import 'package:pixart/utils/color_helper.dart';
import 'package:pixart/widgets/picker/color_picker_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pixart/store/pictures/picture.dart';
import 'package:pixart/store/pictures/pixels_set.dart';
import 'package:pixart/widgets/picker/color_picker.dart';

class PictureFooter extends StatefulWidget {
  final double height;
  final Picture picture;

  const PictureFooter(this.picture, this.height);
  @override
  State<StatefulWidget> createState() => _PictureFooterStore();
}

class _PictureFooterStore extends State<PictureFooter>
    with TickerProviderStateMixin {
  static const double PICKER_HEIGHT = 100;
  bool _colorPickerEnabled = false;
  double _colorPickerIconAngle = pi / 2;
  AnimationController _animationController;
  double _colorPickerHeight = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _runAnimation() {
    Animation angleAnimation;
    Animation heightAnimation;
    angleAnimation = Tween<double>(
            begin: _colorPickerIconAngle, end: _colorPickerIconAngle * -1)
        .animate(_animationController)
          ..addListener(() {
            setState(() => (_colorPickerIconAngle = angleAnimation.value));
          });
    heightAnimation = Tween<double>(
            begin: _colorPickerHeight,
            end: _colorPickerHeight > 0 ? 0 : _PictureFooterStore.PICKER_HEIGHT)
        .animate(_animationController)
          ..addListener(() {
            setState(() => (_colorPickerHeight = heightAnimation.value));
          });
    setState(() => (_colorPickerEnabled = !_colorPickerEnabled));
    _animationController.reset();
    _animationController.forward();
  }

  Widget _renderColorPicker() {
    final Picture picture = widget.picture;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: _colorPickerHeight,
        child: Observer(
          builder: (_) {
            return Container(
              child: Provider<ColorPickerStore>(
                builder: (_) => ColorPickerStore(picture),
                child: Consumer<ColorPickerStore>(
                  builder: (_, store, child) => SingleChildScrollView(
                    child: ColorPicker(
                      store: store,
                      colorPickerWidth: MediaQuery.of(context).size.width,
                      enableAlpha: false,
                      displayThumbColor: false,
                      enableLabel: false,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _renderColorsList() {
    final Picture picture = widget.picture;
    int length = picture.colors.length;
    return Observer(
      builder: (_) => Expanded(
        child: Observer(
          builder: (_) {
            PixelsSet currentPixelsSet = picture.currentPixelsSet;
            if (currentPixelsSet != null) {
              Color currentColor = currentPixelsSet.color;
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final Color color = picture.colors[index];
                final PixelsSet pixelsSet = picture.pixelsMap[color];

                final Color textColor =
                    ColorHelper.textColorByColor(pixelsSet.color);
                final Color borderColor =
                    picture.getBorderColor(pixelsSet.color);
                return Container(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      picture.selectPixelsSet(
                          pixelsSet, _colorPickerHeight > 0);
                    },
                    child: Transform.scale(
                      scale: currentPixelsSet == pixelsSet
                          ? 1.2
                          : currentPixelsSet == null ? 1.0 : .8,
                      child: Container(
                        height: 50.0, // height of the button
                        width: 50.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: pixelsSet.color,
                          border: new Border.all(
                            color: borderColor,
                            width: currentPixelsSet == pixelsSet ? 2.0 : 1.0,
                          ),
                        ), // width of the button
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(color: textColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: length,
            );
          },
        ),
      ),
    );
  }

  Widget _renderPickerButton() {
    final Picture picture = widget.picture;
    return Observer(builder: (_) {
      PixelsSet currentPixelsSet = picture.currentPixelsSet;
      return SizedBox(
        height: 35,
        child: Transform.rotate(
          angle: _colorPickerIconAngle,
          alignment: Alignment.center,
          child: Transform.scale(
            scale: 1.5,
            child: IconButton(
              color: Theme.of(context).buttonColor,
              icon: Icon(Icons.chevron_right, size: 20),
              onPressed: () {
                if (currentPixelsSet != null) {
                  _runAnimation();
                }
              },
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // IconThemeData icinTheme = Theme.of(context).iconTheme
    return Positioned(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: widget.height + _colorPickerHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Column(
            children: <Widget>[
              _renderColorsList(),
              _renderPickerButton(),
              _renderColorPicker(),
            ],
          ),
        ),
      ),
    );
  }
}
