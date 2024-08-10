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
  final List<Widget> _messages = [];
  bool _isButtonShown = true;

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
                    'What kind of mental pain are you experiencing?\n ex) depression, anxiety disorders, loneliness, etc....',
                isUserMessage: false,
              ),
            );
            _messages.add(_buildOption());
          },
        );
      },
    );
  }

  Widget _buildOption() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOptionButton('Depression'),
            _buildOptionButton('Loneliness'),
            _buildOptionButton('Anxiety Disorders'),
            _buildOptionButton('etc...'),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color>(const Color(0xff1e306e)),
        ),
        child: Text(text),
        onPressed: () {
          _selectButton(text);
        },
      ),
    );
  }

  void _startListening() async {
    print('Listening!!!');
    _speechService.startListening(onResult: _onSpeechResult);
    setState(() {
      _isListening = true;
    });
  }

  void _stopListening() async {
    print("Stop Listening!!!!");
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
    String page = '1';
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

  void _selectButton(String text) async {
    String userMessage = text;
    setState(() {
      _messages.add(ChatMessage(text: userMessage, isUserMessage: true));
      _textController.clear();
      _isButtonShown = false;
    });

    String response = 'Please tell me the specific situation';
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
            color: Color(0xffFFFFF3),
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: const BackButton(
          color: Color(0xffFFFFF3),
        ),
        actions: [
          IconButton(
            onPressed: _isListening ? _stopListening : _startListening,
            tooltip: 'Listen',
            icon: Icon(
              _isListening ? Icons.mic : Icons.mic_off,
              color: const Color(0xffFFFFF3),
            ),
          ),
        ],
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
