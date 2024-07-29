import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  final String label;
  const LoginWidget({
    super.key,
    required this.label,
  });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final inputValue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputValue,
      decoration: InputDecoration(
        labelText: widget.label,
      ),
      keyboardType: TextInputType.text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
