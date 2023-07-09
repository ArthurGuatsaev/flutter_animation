// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'dart:math' show pi, cos, sin;

class SixthAnimation extends StatefulWidget {
  const SixthAnimation({super.key});

  @override
  State<SixthAnimation> createState() => _SixthAnimationState();
}

class _SixthAnimationState extends State<SixthAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controllerSize;
  late AnimationController _controllerRotate;
  late AnimationController _controllerSides;
  late Animation _animationSize;
  late Animation _animationRotate;
  late Animation _animationSides;
  @override
  void initState() {
    _controllerSize =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controllerRotate =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controllerSides =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationSize = Tween<double>(begin: 0, end: 1.0).animate(_controllerSize);
    _animationRotate =
        Tween<double>(begin: 0, end: 2 * pi).animate(_controllerRotate);
    _animationSides =
        Tween<double>(begin: 3, end: 10).animate(_controllerSides);
    super.initState();
    _controllerSides.repeat(reverse: true);
    _controllerSize.repeat(reverse: true);
    _controllerRotate.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: AnimatedBuilder(
                animation: Listenable.merge(
                    [_controllerRotate, _controllerSides, _controllerSize]),
                builder: (context, child) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * _animationSize.value,
                    height: MediaQuery.of(context).size.width * _animationSize.value,

                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                      ..rotateX(_animationRotate.value)
                      ..rotateY(_animationRotate.value)
                      ..rotateZ(_animationRotate.value),
                      child: CustomPaint(
                        painter:
                            MyCustomPaint(sides: (_animationSides.value).round()),
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}

class MyCustomPaint extends CustomPainter {
  final int sides;
  const MyCustomPaint({
    required this.sides,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke;
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final angle = (2 * pi) / sides;
    final angles = List.generate(sides, (index) => index * angle);
    path.moveTo(center.dx + radius * cos(0), center.dy + radius * sin(0));
    for (final angle in angles) {
      path.lineTo(
          center.dx + radius * cos(angle), center.dy + radius * sin(angle));
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is MyCustomPaint && oldDelegate.sides != this.sides;
}
