import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speechToText = SpeechToText();

  Future<void> initialize() async {
    await _speechToText.initialize();
  }

  void startListening({required Function(String) onResult}) async {
    await _speechToText.listen(onResult: (SpeechRecognitionResult result) {
      onResult(result.recognizedWords);
    });
  }

  void stopListening() async {
    await _speechToText.stop();
  }
}
