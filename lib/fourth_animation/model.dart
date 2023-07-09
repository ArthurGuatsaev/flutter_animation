// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class Person {
  final String name;
  final int age;
  final String emojy;
  const Person({
    required this.name,
    required this.age,
    required this.emojy,
  });
}

