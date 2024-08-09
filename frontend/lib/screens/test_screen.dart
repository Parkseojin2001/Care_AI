import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/speech_service.dart';
import 'package:frontend/widgets/chat_message.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final SpeechService _speechService = SpeechService();
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _speechService.initialize();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(
          () {
            _messages.add(
              const ChatMessage(
                text:
                    'What mental illness would you like to be tested for?\n ex) depression, stress, loneliness, etc...',
                isUserMessage: false,
              ),
            );
            const Row(
              children: [],
            );
          },
        );
      },
    );
  }

  // 사용자 메시지 출력 및 AI 응답 출력
  void _sendMessage() async {
    if (_textController.text.isEmpty) return;

    String userMessage = _textController.text;
    String page = '2';
    setState(() {
      _messages.add(ChatMessage(text: userMessage, isUserMessage: true));
      _textController.clear();
    });

    String response =
        await ApiService.sendToServer(userMessage, _messages, page);
    setState(() {
      _messages.add(ChatMessage(text: response, isUserMessage: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffA593E0),
        centerTitle: true,
        title: const Text(
          "Care Ai",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: const BackButton(
          color: Color(0xffFFFFF3),
        ),
      ),
      backgroundColor: const Color(0xffA593E0),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: const Color(0xffFFFFF3),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 14),
                  child: Icon(
                    Icons.manage_search_rounded,
                    color: Colors.grey,
                    size: 32,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffFFFFF3),
                            width: 1,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      keyboardType: TextInputType.text,
                      maxLines: 3,
                      minLines: 1,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(
                    Icons.send_rounded,
                    color: Colors.grey,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
