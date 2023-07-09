import 'package:flutter/material.dart';

class EightAnimation extends StatefulWidget {
  const EightAnimation({super.key});

  @override
  State<EightAnimation> createState() => _EightAnimationState();
}

class _EightAnimationState extends State<EightAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controllerA;
  late Animation<double> _animationSize;
  late Animation<Offset> _animationPosition;

  @override
  void initState() {
    _controllerA =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationSize = Tween<double>(begin: 1.6, end: 0.3).animate(
        CurvedAnimation(parent: _controllerA, curve: Curves.bounceOut));
_animationPosition =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -0.23))
            .animate(
                CurvedAnimation(parent: _controllerA, curve: Curves.easeInOut));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controllerA.isCompleted) {
            _controllerA.reverse();
          } else {
            _controllerA.forward();
          }
        },
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(30),
        child: ClipRRect(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            width: 350,
            height: 300,
            child: Stack(
              children: [
                const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Thank you for your answer',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                Positioned.fill(
                  child: SlideTransition(
                    position: _animationPosition,
                    child: ScaleTransition(
                      scale: _animationSize,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green),
                        height: 300,
                        width: 350,
                        child: const Icon(
                          Icons.done,
                          size: 100,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
