import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage<String>()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome",
      debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.light(surface: Colors.grey.shade200, onSurface: Colors.black, primary: Colors.blue, onPrimary: Colors.white)),
        home: const Center(
          child: Text("Welcome"),
        )
    );
  }
}