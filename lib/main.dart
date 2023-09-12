import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_beelogix/view/homeview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( //basically extended version of MaterialApp and make strong support of routing management
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:HomeView()
    );
  }
}

