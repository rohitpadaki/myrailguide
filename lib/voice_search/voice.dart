import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:myrailguide/auth.dart';

// For text-only input, use the gemini-pro model
final model = GenerativeModel(
  model: 'gemini-pro',
  apiKey: Environment.geminiApiKey,
);

FlutterTts flutterTts = FlutterTts();

class VoiceRecognition extends StatefulWidget {
  const VoiceRecognition({super.key});
  @override
  State<VoiceRecognition> createState() => _VoiceRecognitionState();
}

class _VoiceRecognitionState extends State<VoiceRecognition> {
  SpeechToText speechToText = SpeechToText();
  var voiceText = "Hold the button and start speaking";
  var listening = false;
  String answer = "I'd be happy to assist you";

  Future ttsspeak(speech) async {
    await flutterTts.speak(speech);
  }

  void sendQuery(voiceMessage) async {
    if (voiceMessage.isNotEmpty) {
      try {
        final content = [Content.text(voiceMessage)];
        final response = await model.generateContent(content);

        setState(() {
          answer = response.text ?? "";
        });
        ttsspeak(answer);
      } catch (error) {
        if (kDebugMode) {
          print("Error sending message: $error");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        glowRadiusFactor: 2.0,
        animate: listening,
        duration: const Duration(milliseconds: 2000),
        glowColor: Colors.black26,
        repeat: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!listening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  listening = true;
                  speechToText.listen(onResult: (result) {
                    setState(() {
                      voiceText = result.recognizedWords;
                    });
                  });
                });
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              listening = false;
            });
            speechToText.stop();
            sendQuery(voiceText);
          },
          child: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 35,
            child: Icon(
              listening ? Icons.mic : Icons.mic_off,
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: buildAppBar(context, "Voice Assistant", true),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        margin: const EdgeInsets.only(bottom: 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "You:",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    voiceText,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Assistant:\t",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      GestureDetector(
                          onTap: () {
                            ttsspeak(answer);
                          },
                          child: const Icon(
                            Icons.volume_up_rounded,
                            color: Colors.white,
                            size: 18,
                          ))
                    ],
                  ),
                  Text(
                    answer,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
