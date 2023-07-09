// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:animation_project/fourth_animation/model.dart';

class FouthAnimation extends StatefulWidget {
  const FouthAnimation({super.key});

  @override
  State<FouthAnimation> createState() => _FouthAnimationState();
}

class _FouthAnimationState extends State<FouthAnimation> {
  final people = const [
    Person(name: 'jon', age: 23, emojy: '\u{1f5A4}'),
    Person(name: 'sarha', age: 23, emojy: '\u{1f64B}'),
    Person(name: 'jon', age: 23, emojy: '\u{1f648}'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: people.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PersonDetaile(
                        person: people[index],
                        index: index,
                      ))),
              leading: Hero(
                flightShuttleBuilder: (flightContext, animation,
                    flightDirection, fromHeroContext, toHeroContext) {
                  switch (flightDirection) {
                    case HeroFlightDirection.push:
                      return Material(
                        color: Colors.transparent,
                        child: ScaleTransition(
                          scale: animation.drive(Tween<double>(
                            begin: 0.0, end: 1.0
                          ).chain(CurveTween(curve: Curves.bounceInOut))),
                          child: toHeroContext.widget));
                    case HeroFlightDirection.pop:
                      return Material(
                        color: Colors.transparent,
                        child: toHeroContext.widget);
                  }
                },
                tag: index,
                child: Text(
                  people[index].emojy,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
              title: Text(people[index].name),
              subtitle: Text('${people[index].age}'),
            );
          }),
    );
  }
}

class PersonDetaile extends StatelessWidget {
  final Person person;
  final int index;
  const PersonDetaile({
    Key? key,
    required this.index,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Hero(tag: index, child: Text(person.emojy))),
    );
  }
}
