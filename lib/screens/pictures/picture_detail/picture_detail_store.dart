import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pixart/store/pictures/picture.dart';
import 'package:pixart/store/pictures/pixel.dart';
import 'package:pixart/store/pictures/pixel_history.dart';
import 'package:pixart/store/pictures/pixels_set.dart';

part 'picture_detail_store.g.dart';

class PictureDetailStore = _PictureDetail with _$PictureDetailStore;

enum PlayStatus { playing, stopped }

abstract class _PictureDetail with Store {
  static int maxDifference = 1000;
  static double normalDelay = 100;
  static double minSpeed = .1;
  static double maxSpeed = 3.5;
  static double stepSpeed = .5;

  @observable
  Picture picture;
  @observable
  PlayStatus status = PlayStatus.stopped;

  Observable<int> index = Observable(0);
  Observable<int> version = Observable(0);

  double delay = normalDelay;
  double speed = 2.0;

  Timer timer;
  DateTime currentTime;

  List<Pixel> pixelsData = [];

  _PictureDetail(this.picture) {
    picture.pixelsData.forEach(
      (Pixel p) => pixelsData.add(
        Pixel(p.index, p.origin, p.gray, p.colorIndex),
      ),
    );
  }

  @computed
  bool get isPlaying => status == PlayStatus.playing;

  @action
  void switchPlay() {
    if (isPlaying) {
      pause();
    } else {
      play();
    }
  }

  @action
  void upgradeVersion() {
    version.value = version.value + 1;
  }

  void increaseSpeed() {
    double step = speed < .5 ? .1 : stepSpeed;
    speed = min(speed + step, maxSpeed);
  }

  void decreaseSpeed() {
    double step = speed <= .5 ? .1 : stepSpeed;
    speed = max(speed - step, minSpeed);
  }

  void rewindToFrame(int toIndex) {
    int i = index.value;
    int length = toIndex;
    toIndex = min(toIndex, picture.historyLength);
    bool forvard = true;
    if (index.value > toIndex) {
      i = toIndex;
      length = index.value;
      forvard = false;
    }
    for (; i < length; i++) {
      forvard
          ? playForvard(picture.history[i])
          : rewindBack(picture.history[i]);
    }

    runInAction(() {
      upgradeVersion();
      index.value = toIndex;
    });
  }

  Color currentColor(int i) {
    Pixel p = pixelsData[i];
    return p.painted ? p.origin : p.gray;
  }

  void playForvard(PixelHistory h, [bool makeFlash = false]) {
    if (h.extraColor == null) {
      pixelsData[h.index].onTap();
      if (makeFlash) {
        pixelsData[h.index].makeFlash();
      }
    } else {
      PixelsSet pixelsSet = picture.pixelsMap[picture.colors[h.index]];
      pixelsSet.pixels.forEach((Pixel p) {
        pixelsData[p.index].origin = h.extraColor;
      });
    }
  }

  void rewindBack(PixelHistory h) {
    if (h.extraColor == null) {
      pixelsData[h.index].revert();
    } else {
      PixelsSet pixelsSet = picture.pixelsMap[picture.colors[h.index]];
      pixelsSet.pixels.forEach((Pixel p) {
        pixelsData[p.index].origin = pixelsSet.originColor;
      });
    }
  }

  void playFrame() {
    PixelHistory frame = picture.history[index.value];
    int difference = 0;
    if (currentTime != null) {
      difference =
          min(maxDifference, frame.time.difference(currentTime).inMilliseconds);
    }
    delay = normalDelay * (difference / maxDifference);
    timer = Timer(Duration(milliseconds: (delay / speed).floor()), () {
      runInAction(() => (index.value = index.value + 1));
      currentTime = frame.time;

      playForvard(frame, true);

      runInAction(() => upgradeVersion());
      if (index.value < picture.history.length) {
        playFrame();
      } else {
        pause();
      }
    });
  }

  void play() {
    int l = picture.historyLength;
    if (index.value < l) {
      runInAction(() {
        status = PlayStatus.playing;
      });
      playFrame();
    }
  }

  void pause() {
    cancelTimer();
    runInAction(() {
      status = PlayStatus.stopped;
    });
  }

  void cancelTimer() {
    if (timer != null) {
      timer.cancel();
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
  }
}
