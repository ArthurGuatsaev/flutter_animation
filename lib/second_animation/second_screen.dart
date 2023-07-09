// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class SecondAnimation extends StatefulWidget {
  const SecondAnimation({super.key});

  @override
  State<SecondAnimation> createState() => _SecondAnimationState();
}

class _SecondAnimationState extends State<SecondAnimation>
    with TickerProviderStateMixin {
  late Animation animationFirst;
  late Animation animationSecond;

  late final AnimationController _controller;
  late final AnimationController _flipController;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animationFirst = Tween<double>(begin: 0.0, end: -pi / 2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    _flipController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animationSecond = Tween<double>(begin: 0.0, end: pi).animate(
        CurvedAnimation(parent: _flipController, curve: Curves.bounceOut));

    _controller.forward();
    super.initState();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationSecond = Tween<double>(
                begin: animationSecond.value, end: animationSecond.value + pi)
            .animate(CurvedAnimation(
                parent: _flipController, curve: Curves.bounceOut));
        _flipController
          ..reset()
          ..forward();
      }
    });
    _flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationFirst = Tween<double>(
                begin: animationFirst.value, end: animationFirst.value - pi / 2)
            .animate(
                CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
        _controller
          ..repeat()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(vertical: 30),
          child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateZ(animationFirst.value),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                            animation: _flipController,
                            builder: (context, child) {
                              return Transform(
                                alignment: Alignment.centerRight,
                                transform: Matrix4.identity()
                                  ..rotateY(animationSecond.value),
                                child: ClipPath(
                                  clipper:
                                      const HalfCircleCliper(cutUp: CutUp.left),
                                  child: Container(
                                    color: Colors.white,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                              );
                            }),
                        AnimatedBuilder(
                            animation: _flipController,
                            builder: (context, child) {
                              return Transform(
                                alignment: Alignment.centerLeft,
                                transform: Matrix4.identity()
                                  ..rotateY(animationSecond.value),
                                child: ClipPath(
                                  clipper: const HalfCircleCliper(
                                      cutUp: CutUp.right),
                                  child: Container(
                                    color: Colors.amber,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                              );
                            })
                      ]),
                );
              })),
    );
  }
}

enum CutUp { right, left }

extension ToPath on CutUp {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;
    switch (this) {
      case CutUp.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CutUp.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(offset,
        radius: Radius.elliptical(size.width / 2, size.height / 2),
        clockwise: clockwise);
    path.close();
    return path;
  }
}

class HalfCircleCliper extends CustomClipper<Path> {
  final CutUp cutUp;
  const HalfCircleCliper({
    required this.cutUp,
  });
  @override
  Path getClip(Size size) => cutUp.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
