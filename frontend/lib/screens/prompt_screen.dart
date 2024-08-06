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
  late SpeechService _speechService;
  bool _isListening = false;
  String _text = '';
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _speechService = SpeechService(
      onResult: (val) {
        setState(
          () {
            _text = val;
            _textController.text = val;
          },
        );
      },
    );
  }

  void _listen() {
    if (!_isListening) {
      _speechService.startListening();
      setState(() => _isListening = true);
    } else {
      _speechService.stopListening();
      setState(() => _isListening = false);
      print('Text: $_text');
    }
  }

  void _sendMessage() async {
    if (_textController.text.isEmpty) return;

    String message = _textController.text;
    setState(() {
      _messages.add(ChatMessage(text: message));
      _textController.clear();
    });

    await ApiService.sendToServer(message);
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
          onPressed: _listen,
          color: Colors.white,
          icon: Icon(
            _isListening ? Icons.mic : Icons.mic_none,
            size: 30,
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
