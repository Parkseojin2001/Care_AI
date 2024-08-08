import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speechToText = SpeechToText();

  Future<void> initialize({required Function(String) onResult}) async {
    await _speechToText.initialize();
    _speechToText.listen(
      onResult: (SpeechRecognitionResult result) {
        onResult(result.recognizedWords);
      },
    );
  }

  void startListening() async {
    await _speechToText.listen();
  }

  void stopListening() async {
    await _speechToText.stop();
  }
}
