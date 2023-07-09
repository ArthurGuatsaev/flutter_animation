import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class FivethAnimation extends StatefulWidget {
  const FivethAnimation({super.key});

  @override
  State<FivethAnimation> createState() => _FivethAnimationState();
}

Color getColor() => Color(0xFF000000 + math.Random().nextInt(0x00FFFFFF));

class _FivethAnimationState extends State<FivethAnimation> {
  Color _color = getColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ClipPath(
        clipper: CustomOval(),
        child: TweenAnimationBuilder(
            tween: ColorTween(begin: getColor(), end: _color),
            duration: const Duration(seconds: 3),
            onEnd: () {
              setState(() {
                _color = getColor();
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              color: Colors.red,
            ),
            builder: (context, Color? color, child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(color!, BlendMode.srcATop),
                child: child!);
            }),
      )),
    );
  }
}

class CustomOval extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);
    path.addOval(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
