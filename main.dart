// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_maps/shortest_distance.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'home.dart';
main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:ShortestDistance(),
    );
  }
}
