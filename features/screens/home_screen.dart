import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';


@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: const Center(
        child: Text('Welcome to Home Page!'),
      ),
    );
  }
}