import 'dart:async';

import 'package:flutter/material.dart';

class Zoom extends StatefulWidget {
  final Offset frameSize;
  final Offset maxSize;
  final Widget header;
  final Widget footer;
  final Widget child;
  final double minScale;
  final void Function(Offset) onPositionUpdate;
  final void Function(double) onScaleUpdate;
  final void Function(Offset) onTap;
  final void Function(Offset) onDoubleTap;
  final void Function(Offset) onLongPress;
  final double headerHeight;

  Zoom({
    Key key,
    this.minScale,
    this.frameSize,
    this.maxSize,
    this.header,
    this.footer,
    this.child,
    this.onPositionUpdate,
    this.onScaleUpdate,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.headerHeight,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> with TickerProviderStateMixin {
  Offset _startDrag = Offset.zero;
  DateTime _startTime;
  Offset position = Offset.zero;
  Offset _oldPosition = Offset.zero;
  double scale;
  Offset _dragDirection;
  double velocity;
  double _normalTranslateSpeed = 400 / 500;
  Timer _timer;
  double _oldScale;
  double _tmpScale;
  TapDownDetails _tapDetails;
  AnimationController _scaleAnimationController;
  Animation _scaleAnimation;
  Offset _scaleShift = Offset.zero;
  static const double SCALE_STEP = .01;

  @override
  void initState() {
    scale = widget.minScale;
    _scaleAnimationController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 250,
        ));
    _translate(0, 0);
    widget.onScaleUpdate(scale);
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    _scaleAnimationController.dispose();
    super.dispose();
  }

  Offset get _center =>
      Offset(widget.frameSize.dx / 2, widget.frameSize.dy / 2);

  void _runScaleAnimation() {
    double scaleDifference = 1.0 - scale;
    double start = scale;
    double end = 1.0;
    if (scaleDifference < .2) {
      end = widget.minScale;
    }

    _setScaleShift(_tapDetails != null ? _tapDetails.localPosition : _center);
    _scaleAnimation =
        Tween<double>(begin: start, end: end).animate(_scaleAnimationController)
          ..addListener(() {
            setState(() {
              scale = _scaleAnimation.value;
            });
            widget.onScaleUpdate(scale);

            _afterScale();
          });
    _scaleAnimationController.reset();
    _scaleAnimationController.forward();
  }

  void _translate(double dx, double dy) {
    final Offset size = widget.maxSize.scale(scale, scale);
    double dxMax = size.dx - widget.frameSize.dx;
    double dyMax = size.dy - widget.frameSize.dy;

    if (dx < -dxMax) {
      dx = -dxMax;
    }

    if (dy < -dyMax) {
      dy = -dyMax;
    }

    if (dx > 0 || dxMax < 0) {
      dx = 0;
    }
    if (dy > 0 || dyMax < 0) {
      dy = 0;
    }

    if (dxMax < 0) {
      dx = widget.frameSize.dx / 2 - size.dx / 2;
    }

    if (dyMax < 0) {
      dy = widget.frameSize.dy / 2 - size.dy / 2;
    }

    dx = dx / scale;
    dy = dy / scale;
    setState(() {
      position = Offset(dx, dy);
    });
    widget.onPositionUpdate(position);
  }

  void _onStartDrag(ScaleStartDetails details) {
    if (_timer != null) {
      _timer.cancel();
      velocity = 0;
    }
    _oldPosition = position.scale(scale, scale);
    _startDrag = details.focalPoint;
    _oldScale = scale;
    _setScaleShift(details.focalPoint);
    _startTime = DateTime.now();
  }

  void _onMove(ScaleUpdateDetails details) {
    if (details.scale != 1.0) {
      _onScaleUpdate(details);
    } else {
      _onPositionUpdate(details);
    }
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final double forCheck = _tmpScale != null ? _tmpScale : _oldScale;
    double newScale = scale +
        ((details.scale - forCheck) > 0
            ? _ZoomState.SCALE_STEP
            : -_ZoomState.SCALE_STEP);
    if (newScale < widget.minScale) {
      newScale = widget.minScale;
    }
    if (newScale > 1) {
      newScale = 1;
    }
    final double legacyScale = scale;
    setState(() {
      scale = newScale;
    });
    widget.onScaleUpdate(scale);
    if (legacyScale != scale) {
      _afterScale();
    }
    _tmpScale = details.scale;
  }

  void _setScaleShift(Offset focalPoint) {
    double dx = position.dx * scale;
    double dy = position.dy * scale;
    final double maxSizeX = widget.maxSize.dx * scale;
    final double maxSizeY = widget.maxSize.dy * scale;
    _scaleShift = Offset(
        (focalPoint.dx - dx) / maxSizeX, (focalPoint.dy - dy) / maxSizeY);
  }

  void _afterScale() {
    // print('$scale $oldScale');
    // check if point in canvas is
    // scale .1 position(500, 1500) focal(144, 246) shift((144 - 50) / 300 = .31, (246 - 150) / 300 = .32)
    // dx = widget.maxSize.dx * scale * shift.dx + (frame.dx / 2 - focal.dx)
    // dy = widget.maxSize.dy * scale * shift.dy + (frame.dy / 2 - focal.dy)
    final Offset maxSize = widget.maxSize.scale(scale, scale);

    double dx = maxSize.dx * _scaleShift.dx - widget.frameSize.dx / 2;
    double dy = maxSize.dy * _scaleShift.dy - widget.frameSize.dy / 2;
    if (position.dx <= 0) {
      dx = dx * -1;
    }
    if (position.dy <= 0) {
      dy = dy * -1;
    }
    _translate(dx, dy);
  }

  void _onPositionUpdate(ScaleUpdateDetails details) {
    double x = details.focalPoint.dx;
    double y = details.focalPoint.dy;
    double dx = x - _startDrag.dx;
    double dy = y - _startDrag.dy;
    _translate(_oldPosition.dx + dx, _oldPosition.dy + dy);
  }

  void _onStopDrag() {
    double length;
    double normal;
    _tmpScale = null;
    int time = DateTime.now().difference(_startTime).inMilliseconds;
    if (_oldScale != scale || time == 0) {
      return;
    }
    Offset posScaled = position.scale(scale, scale);
    Offset vector =
        Offset(posScaled.dx - _oldPosition.dx, posScaled.dy - _oldPosition.dy);
    length = vector.distance * scale;
    _dragDirection = Offset(vector.dx / length, vector.dy / length);
    normal = _normalTranslateSpeed;
    double speed = length / time;
    velocity = speed / normal;
    if (velocity > 0) {
      _accelerate(_oldScale == scale);
    }
  }

  void _accelerate(bool isTranslate) {
    velocity *= .9;
    double speed = 50 * velocity;
    if (isTranslate) {
      _translate(position.dx * scale + _dragDirection.dx * speed,
          position.dy * scale + _dragDirection.dy * speed);
    } else {}
    _timer = new Timer(const Duration(milliseconds: 10), () {
      if (velocity > 0.1) {
        _accelerate(isTranslate);
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.header,
        Positioned(
          top: widget.headerHeight,
          child: Container(
            height: widget.frameSize.dy,
            color: Colors.white,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: (TapDownDetails details) {
                _tapDetails = details;
              },
              onLongPress: () {
                widget.onLongPress(_tapDetails.localPosition);
              },
              onTap: () {
                widget.onTap(_tapDetails.localPosition);
              },
              onDoubleTap: () {
                _runScaleAnimation();
                widget.onDoubleTap(Offset.zero);
              },
              onScaleStart: (ScaleStartDetails details) {
                _onStartDrag(details);
              },
              onScaleUpdate: (ScaleUpdateDetails details) {
                _onMove(details);
              },
              onScaleEnd: (ScaleEndDetails details) {
                _onStopDrag();
              },
              child: Transform(
                transform: Matrix4.diagonal3Values(scale, scale, 0)
                  ..translate(position.dx, position.dy),
                child: widget.child,
              ),
            ),
          ),
        ),
        widget.footer
      ],
    );
  }
}
