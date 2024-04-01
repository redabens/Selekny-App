import 'package:flutter/material.dart';
import 'package:selek/pages/home/home.dart';
void main() {
  runApp( const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title:'Selekny',
      debugShowCheckedModeBanner: false,
      home:   HomePage(),
    );
  }
}
