import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ThirdAnimation extends StatefulWidget {
  const ThirdAnimation({super.key});

  @override
  State<ThirdAnimation> createState() => _ThirdAnimationState();
}

class _ThirdAnimationState extends State<ThirdAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _xController;
  late final AnimationController _yController;
  late final AnimationController _zController;
  late Tween<double> _animation;
  @override
  void initState() {
    _xController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _yController =
        AnimationController(vsync: this, duration: const Duration(seconds: 30));
    _zController =
        AnimationController(vsync: this, duration: const Duration(seconds: 40));
    _animation = Tween<double>(begin: 0, end: pi);
    super.initState();
  }

  final size = 100.0;
  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..forward();
    _yController
      ..reset()
      ..forward();
    _zController
      ..reset()
      ..forward();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: Listenable.merge(
                    [_xController, _yController, _zController]),
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateX(_animation.evaluate(_xController))
                      ..rotateY(_animation.evaluate(_yController))
                      ..rotateZ(_animation.evaluate(_zController)),
                    child: Stack(
                      children: [
                        Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()
                            ..rotateY(pi/2),
                          child: Container(
                            color: Colors.blue,
                            height: size,
                            width: size,
                          ),
                        ),
                        Transform(
                          alignment: Alignment.centerRight,
                          transform: Matrix4.identity()
                            ..rotateY(-pi/2),
                          child: Container(
                            color: Colors.green,
                            height: size,
                            width: size,
                          ),
                        ),
                        Container(
                          color: Colors.red,
                          height: size,
                          width: size,
                        ),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..translate(Vector3(0, 0, -size)),
                          child: Container(
                            color: Colors.yellow,
                            height: size,
                            width: size,
                          ),
                        ),
                        
                        Transform(
                          alignment: Alignment.topCenter,
                          transform: Matrix4.identity()
                            ..rotateX(-pi/2),
                          child: Container(
                            color: Colors.pink,
                            height: size,
                            width: size,
                          ),
                        ),
                        Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()
                            ..rotateX(pi/2),
                          child: Container(
                            color: Colors.white,
                            height: size,
                            width: size,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
