import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;

  const LoginWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.isPassword,
  });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final inputValue = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(
                    () {
                      _obscureText = !_obscureText;
                    },
                  );
                },
              )
            : null,
      ),
      keyboardType: TextInputType.text,
      obscureText: widget.isPassword ? _obscureText : false,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
