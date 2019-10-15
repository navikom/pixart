import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pixart/screens/pictures/picture_detail/picture_detail_store.dart';
import 'package:provider/provider.dart';

class PictureDetailFooter extends StatelessWidget {
  final double height;

  const PictureDetailFooter({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PictureDetailStore store = Provider.of<PictureDetailStore>(context);
    return Container(
      height: height,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          Observer(
            builder: (_) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    iconSize: 40,
                    color: Theme.of(context).buttonColor,
                    icon: Icon(store.isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled),
                    onPressed: () => store.switchPlay(),
                  ),
                  IconButton(
                    iconSize: 40,
                    color: Theme.of(context).buttonColor,
                    icon: Icon(Icons.fast_rewind),
                    onPressed: () => store.decreaseSpeed(),
                  ),
                  Flexible(
                    child: Slider(
                      onChanged: (double index) =>
                          store.rewindToFrame(index.round()),
                      min: 0,
                      max: store.picture.historyLength * 1.0,
                      activeColor: Theme.of(context).buttonColor,
                      value: store.index.value * 1.0,
                    ),
                  ),
                  Transform.rotate(
                    angle: pi,
                    child: IconButton(
                      iconSize: 40,
                      color: Theme.of(context).buttonColor,
                      icon: Icon(Icons.fast_rewind),
                      onPressed: () => store.increaseSpeed(),
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                iconSize: 30,
                color: Theme.of(context).buttonColor,
                icon: Icon(Icons.save_alt),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 30,
                color: Theme.of(context).buttonColor,
                icon: Icon(Icons.share),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
