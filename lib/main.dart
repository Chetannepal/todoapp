import 'package:flutter/material.dart';
import 'package:my_todo/Pages/homescreen.dart';

void main() {
  runApp(const MyTodo());
}

class MyTodo extends StatelessWidget {
  const MyTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
