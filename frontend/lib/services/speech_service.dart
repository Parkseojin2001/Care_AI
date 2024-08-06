import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  late stt.SpeechToText _speech;
  final Function(String) onResult;

  SpeechService({required this.onResult}) {
    _speech = stt.SpeechToText();
  }

  void startListening() async {
    bool available = await _speech.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    if (available) {
      _speech.listen(
        onResult: (val) => onResult(val.recognizedWords),
      );
    }
  }

  void stopListening() {
    _speech.stop();
  }
}
