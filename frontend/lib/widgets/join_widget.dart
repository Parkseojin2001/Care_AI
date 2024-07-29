import 'package:flutter/material.dart';

class JoinWidget extends StatelessWidget {
  final String title, example;
  final bool isPassword;

  const JoinWidget({
    super.key,
    required this.title,
    required this.example,
    required this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
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
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  labelText: example,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                keyboardType: TextInputType.text,
                obscureText: isPassword,
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
