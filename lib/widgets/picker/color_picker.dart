library flutter_colorpicker;

import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/hsv_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pixart/widgets/picker/color_picker_store.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    @required this.store,
    this.paletteType: PaletteType.hsv,
    this.enableAlpha: true,
    this.enableLabel: true,
    this.displayThumbColor: false,
    this.colorPickerWidth: 300.0,
    this.pickerAreaHeightPercent: 1.0,
  });

  final ColorPickerStore store;
  final PaletteType paletteType;
  final bool enableAlpha;
  final bool enableLabel;
  final bool displayThumbColor;
  final double colorPickerWidth;
  final double pickerAreaHeightPercent;

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  void dispose() {
    super.dispose();
    widget.store.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: Observer(
        builder: (_) {
          return Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  width: widget.colorPickerWidth * .5,
                  height: 90.0,
                  child: ColorPickerArea(widget.store.currentHsvColor,
                      (HSVColor color) {
                    widget.store.onColorChanged(color);
                  }, widget.paletteType),
                ),
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40.0,
                            width: widget.colorPickerWidth * .5,
                            child: ColorPickerSlider(
                              TrackType.hue,
                              widget.store.currentHsvColor,
                              (HSVColor color) {
                                widget.store.onColorChanged(color);
                              },
                              displayThumbColor: true,
                            ),
                          ),
                          widget.enableAlpha
                              ? SizedBox(
                                  height: 35.0,
                                  width: widget.colorPickerWidth * .5,
                                  child: ColorPickerSlider(
                                    TrackType.alpha,
                                    widget.store.currentHsvColor,
                                    (HSVColor color) {
                                      widget.store.onColorChanged(color);
                                    },
                                    displayThumbColor: true,
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(height: 5.0),
                          RawMaterialButton(
                            shape: new CircleBorder(),
                            constraints:
                                BoxConstraints(minWidth: 45, minHeight: 45),
                            fillColor: widget.store.originRGBAColor,
                            child: Text(''),
                            onPressed: () {
                              widget.store.resetColor();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  widget.enableLabel
                      ? ColorPickerLabel(widget.store.currentHsvColor)
                      : SizedBox(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
