import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  const ChatMessage({
    required this.text,
    required this.isUserMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment:
            isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUserMessage) ...[
            const CircleAvatar(
              child: Text('AI'),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                text,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          if (isUserMessage) ...[
            const SizedBox(
              width: 10,
            ),
            const CircleAvatar(
              child: Text('Me'),
            ),
          ]
        ],
      ),
    );
  }
}
