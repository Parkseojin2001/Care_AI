import 'package:flutter/material.dart';

class JoinWidget extends StatefulWidget {
  final String title, example;
  final bool isPassword;
  final TextEditingController controller;

  const JoinWidget({
    super.key,
    required this.title,
    required this.example,
    required this.isPassword,
    required this.controller,
  });

  @override
  State<JoinWidget> createState() => _JoinWidgetState();
}

class _JoinWidgetState extends State<JoinWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  labelText: widget.example,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  suffixIcon: widget.isPassword
                      ? IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
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
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
