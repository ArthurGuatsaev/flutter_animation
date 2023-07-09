import 'dart:math' show pi;

import 'package:flutter/material.dart';

class SeventhAnimation extends StatefulWidget {
  final Widget drawer;
  final Widget child;
  const SeventhAnimation(
      {super.key, required this.child, required this.drawer});

  @override
  State<SeventhAnimation> createState() => _SeventhAnimationState();
}

class _SeventhAnimationState extends State<SeventhAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controllerDrawer;
  late Animation animation;
  late AnimationController _controllerChild;
  late Animation animationDrawer;
  late Animation animationChild;
  @override
  void initState() {
    _controllerDrawer = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _controllerChild = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animationDrawer =
        Tween<double>(begin: pi / 2.7, end: 0).animate(_controllerDrawer);
    animationChild =
        Tween<double>(begin: 0, end: pi / 2).animate(_controllerChild);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final maxScreen = MediaQuery.of(context).size.width;
    final maxDrag = maxScreen * 0.8;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final delta = details.delta.dx / maxDrag;
        _controllerChild.value += delta;
        _controllerDrawer.value += delta;
      },
      onHorizontalDragEnd: (details) {
        if (_controllerChild.value < 0.5) {
          _controllerChild.reverse();
          _controllerDrawer.reverse();
        } else {
          _controllerChild.forward();
          _controllerDrawer.forward();
        }
      },
      child: AnimatedBuilder(
          animation: Listenable.merge([_controllerChild, _controllerDrawer]),
          builder: (context, child) {
            return Stack(
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                ),
                Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)..translate(_controllerChild.value * maxDrag)
                      ..rotateY(-animationChild.value),
                    alignment: Alignment.centerLeft,
                    child: widget.child),
                Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(
                          -maxScreen + _controllerDrawer.value * maxDrag)
                      ..rotateY(-animationDrawer.value),
                    alignment: Alignment.centerRight,
                    child: widget.drawer)
              ],
            );
          }),
    );
  }
}
