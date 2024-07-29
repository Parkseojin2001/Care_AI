import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  LoginWidget({
    super.key,
    required this.label,
    required this.controller,
  });

  final inputValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      keyboardType: TextInputType.text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
