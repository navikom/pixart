import 'package:flutter/material.dart';

class PixelHistory {
  final DateTime time = DateTime.now();
  final int index;
  final Color extraColor;
  PixelHistory(this.index, [this.extraColor]);

  @override
  String toString() {
    return '{"time": $time, "index": $index, "extraColor": $extraColor}';
  }
}
