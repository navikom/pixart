import 'package:flutter/material.dart';
import 'package:pixart/store/pictures/picture.dart';
import 'package:pixart/store/pictures/pixel.dart';

class Palette extends StatelessWidget {
  final Picture picture;
  Palette(this.picture);
  @override
  Widget build(BuildContext context) {
    int index = 0;
    Map<Color, bool> repeated = new Map();
    Iterable<Pixel> pixels = picture.pixelsData.where((Pixel pixel) {
      bool used = false;
      if (repeated[pixel.origin] != null) {
        used = true;
      } else {
        repeated[pixel.origin] = true;
      }
      return !used;
    });
    // List<Pixel> pp = new List<Pixel>.from(pixels);

    // for (int x = 0; x < pp.length; x++) {
    //   print(
    //       '$x: hue: ${pp[x].originHSV.hue}, saturation: ${pp[x].originHSV.saturation}, value: ${pp[x].originHSV.value}');
    // }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: pixels.map(
          (Pixel pixel) {
            return Column(
              children: [
                Text(
                  (++index).toString(),
                  style: TextStyle(fontSize: 9),
                ),
                Container(
                  width: 30,
                  height: 600,
                  decoration: BoxDecoration(
                    color: pixel.origin,
                  ),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${pixel.originHSV} ${pixel.origin.value}  ${picture.pixelsMap[pixel.origin]}',
                        style: TextStyle(
                          fontSize: 15,
                          color: pixel.originHSV.value < .7
                              ? Colors.white
                              : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}
