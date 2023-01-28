// ignore_for_file: non_constant_identifier_names

import 'dart:math' as math;

import 'package:confirmation_success/model/bubble.dart';
import 'package:confirmation_success/paint/bubble_painter.dart';
import 'package:confirmation_success/paint/cir_painter.dart';
import 'package:flutter/material.dart';

class ConfirmationSuccess extends StatefulWidget {
  final Color reactColor;
  final bool showBubbleSplash;
  final Widget child;
  final double circleSize;
  final List<Color> bubbleColors;
  final double maxBubbleRadius;
  final int numofBubbles;

  const ConfirmationSuccess(
      {required this.reactColor,
      required this.child,
      this.circleSize = 100,
      this.showBubbleSplash = true,
      this.bubbleColors = const [
        Colors.red,
        Colors.green,
        Colors.blue,
        Colors.orange
      ],
      this.maxBubbleRadius = 10,
      this.numofBubbles = 20});
  @override
  State<ConfirmationSuccess> createState() => _ConfirmationSuccessState();
}

class _ConfirmationSuccessState extends State<ConfirmationSuccess>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bubbleAnimation;
  late Animation<double> _cirAnimation;
  late Animation<double> _fadeBubbleAnimation;
  late Animation<double> _fadeContentAnimation;
  final List<Bubble> _bubbles = [];

  double _maxDesplacedBubbleResaultant = 0;
  int _maxBubbles = 0;
  double _maxBubbleRadius = 0;
  double _refDx = 0.0;
  double _refDy = 0.0;
  bool cirRounderEnded = false;
  final GlobalKey _widgetKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _maxDesplacedBubbleResaultant = widget.circleSize * 2;
    _maxBubbles = widget.numofBubbles;
    _maxBubbleRadius = widget.maxBubbleRadius;
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    initStaggeredAnims();

    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      handleRenderBox();
      initBubbles();
      startMainAnim();
    });
  }

  void initStaggeredAnims() {
    CurvedAnimation circleCurve = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.35, curve: Curves.easeInCirc),
    );
    CurvedAnimation buublesCurve = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 0.75, curve: Curves.easeOutExpo),
    );
    CurvedAnimation fadeBubbleCurve = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.75, 1, curve: Curves.easeOutExpo),
    );
    CurvedAnimation fadeContentCurve = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 1, curve: Curves.easeIn),
    );

    _cirAnimation = Tween<double>(begin: 0, end: math.pi * 2 + math.pi / 2)
        .animate(circleCurve);
    _bubbleAnimation =
        Tween<double>(begin: 0, end: _maxDesplacedBubbleResaultant)
            .animate(buublesCurve);
    _fadeBubbleAnimation =
        Tween<double>(begin: 1, end: 0).animate(fadeBubbleCurve);
    _fadeContentAnimation =
        Tween<double>(begin: 0, end: 1).animate(fadeContentCurve);

    _bubbleAnimation.addListener(bubbleHandler);
    _cirAnimation.addListener(cirHandler);
    _controller.addListener(contListener);
  }

  void handleRenderBox() {
    final RenderBox renderBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox;

    _widgetKey.currentContext?.size;
    final Size size = renderBox.size;
    _refDx = size.width / 2;
    _refDy = size.height / 2;
  }

  void bubbleHandler() {
    for (var bubble in _bubbles) {
      bubble.dx = _refDx + math.cos(bubble.angle) * _bubbleAnimation.value;
      bubble.dy = _refDy + math.sin(bubble.angle) * _bubbleAnimation.value;
    }
  }

  void contListener() {
    if (_controller.value >= .35) {
      setState(() {
        cirRounderEnded = true;
      });
    }
  }

  void cirHandler() {}

  void generateBubbles() {
    List<Color> colors = widget.bubbleColors;
    if (colors.isEmpty) {
      colors = [Colors.red, Colors.green, Colors.blue, Colors.orange];
    }
    for (int i = 0; i < _maxBubbles; i++) {
      double angle = math.Random().nextDouble() * math.pi * 2;
      Bubble bubble = Bubble(
          angle: angle,
          dx: _refDx + math.sin(angle) * _maxDesplacedBubbleResaultant,
          dy: _refDy + math.cos(angle) * _maxDesplacedBubbleResaultant,
          r: math.Random().nextDouble() * _maxBubbleRadius,
          color: colors[math.Random().nextInt(colors.length)]);
      handleCollision(i, bubble);
      _bubbles.add(bubble);
    }
    for (var bubble in _bubbles) {
      //Initing launching pos
      bubble.dx = _refDx;
      bubble.dy = _refDy;
    }
  }

  void handleCollision(int i, Bubble bubble) {
    for (int j = 0; j < _bubbles.length; j++) {
      if (j == i) continue;
      if (distance(bubble.dx, bubble.dy, _bubbles[j].dx, _bubbles[j].dy) -
              (bubble.r + _bubbles[j].r) <
          0) {
        double angle = math.Random().nextDouble() * math.pi * 2;
        bubble.dx = _refDx + math.cos(angle) * _maxDesplacedBubbleResaultant;
        bubble.dy = _refDy + math.sin(angle) * _maxDesplacedBubbleResaultant;
        bubble.angle = angle;
        bubble.r = math.Random().nextDouble() * _maxBubbleRadius;
        handleCollision(i, bubble);
      }
    }
  }

  distance(x1, y1, x2, y2) {
    double xDiff = x2 - x1;
    double yDiff = y2 - y1;
    return math.sqrt(math.pow(xDiff, 2) + math.pow(yDiff, 2));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      key: _widgetKey,
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            if (cirRounderEnded)
              FadeTransition(
                opacity: _fadeBubbleAnimation,
                child: CustomPaint(
                  foregroundPainter: BubblePainter(
                      value: _bubbleAnimation.value, bubbles: _bubbles),
                  child: Container(),
                ),
              ),
            Align(
                alignment: Alignment.center,
                child: FadeTransition(
                  opacity: _fadeContentAnimation,
                  child: CircleAvatar(
                      radius: widget.circleSize,
                      backgroundColor: widget.reactColor,
                      child: child!),
                )),
            CustomPaint(
              foregroundPainter: CirPainter(
                  color: widget.reactColor.withOpacity(0.85),
                  deg: _cirAnimation.value,
                  innerCirSize: widget.circleSize,
                  refCenter: Offset(_refDx, _refDy)),
              child: Container(),
            ),
          ],
        );
      },
      child: widget.child,
    );
  }

  void initBubbles() {
    if (widget.showBubbleSplash) {
      if (_bubbles.isEmpty) {
        generateBubbles();
      }
    }
  }

  void startMainAnim() async {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reset();
    }
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
