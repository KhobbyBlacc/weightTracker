import 'package:flutter/material.dart';
import 'package:weight_tracker/screens/bottom_nav.dart';

class Home extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BottomNav();
  }
}
