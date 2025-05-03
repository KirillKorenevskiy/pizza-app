import 'package:flutter/material.dart';

class MyMacroWidget extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;
  final TextEditingController controller;

  const MyMacroWidget({
    required this.title,
    required this.value,
    required this.icon,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Icon(
                icon,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 4),
              TextField(
                controller: controller,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.black),
                  isDense: true,
                  suffixText: title == 'Calories' ? '' : 'g',
                  suffixStyle: const TextStyle(color: Colors.black),
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
