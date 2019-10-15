import 'dart:async';

import 'package:flutter/material.dart';

class NonPaintedAnimationService {
  static const double START_VALUE = .1;
  static const int ANIMATION_DURATION = 500;
  static const int STOP_TIME = 5;

  final double end;
  final Function(double) listener;
  AnimationController controller;
  SingleTickerProviderStateMixin widget;
  Animation animation;
  Timer timer;

  NonPaintedAnimationService(this.end, this.listener, this.widget) {
    controller = AnimationController(
      vsync: widget,
      duration: Duration(
        milliseconds: ANIMATION_DURATION,
      ),
      animationBehavior: AnimationBehavior.preserve,
    );
  }

  void start() {
    if (controller.status != AnimationStatus.dismissed) {
      return;
    }
    animation =
        Tween<double>(begin: START_VALUE, end: end * 2).animate(controller)
          ..addListener(() {
            listener(animation.value);
          });

    controller.repeat();
    timer = Timer(Duration(seconds: STOP_TIME), stop);
  }

  void stop() {
    controller.reset();
  }

  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    controller.dispose();
  }
}
