import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/speech_service.dart';
import 'package:frontend/widgets/chat_message.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  final SpeechService _speechService = SpeechService();
  bool _isListening = false;
  String _text = '';
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _speechService.initialize(onResult: _onSpeechResult);
  }

  void _startListening() async {
    _speechService.startListening();
    setState(() {
      _isListening = true;
    });
  }

  void _stopListening() async {
    _speechService.stopListening();
    setState(() {
      _isListening = false;
    });
    if (_text.isNotEmpty) {
      _textController.text = _text;
      _sendMessage();
    } else {
      setState(
        () {
          _messages.add(
            const ChatMessage(
              text: 'Sorry, voice recognition failed. Please say again...',
              isUserMessage: false,
            ),
          );
        },
      );
    }
  }

  void _onSpeechResult(String recognizedWords) {
    setState(() {
      _text = recognizedWords;
    });
  }

  // 사용자 메시지 출력 및 AI 응답 출력
  void _sendMessage() async {
    if (_textController.text.isEmpty) return;

    String userMessage = _textController.text;
    setState(() {
      _messages.add(ChatMessage(text: userMessage, isUserMessage: true));
      _textController.clear();
    });

    String response = await ApiService.sendToServer(userMessage);
    setState(() {
      _messages.add(ChatMessage(text: response, isUserMessage: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff23B6E4),
        centerTitle: true,
        title: const Text(
          "Care Ai",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: _isListening ? _stopListening : _startListening,
          tooltip: 'Listen',
          icon: Icon(
            _isListening ? Icons.mic : Icons.mic_off,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color(0xff23B6E4),
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
              color: const Color(0xffBDE9F7),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.manage_search_outlined,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
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
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
