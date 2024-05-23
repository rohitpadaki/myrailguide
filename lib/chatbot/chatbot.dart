import 'package:flutter/material.dart';
import 'package:myrailguide/auth.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// For text-only input, use the gemini-pro model
final model = GenerativeModel(
    model: 'gemini-1.5-pro-latest',
    apiKey: Environment.geminiApiKey,
    systemInstruction: Content.system(
        "You are a chatbot that is used in app called MyRailGuide. Your task is to respond to queries related to Trains, stations and anything related to railways. Provide the response without using Markdown. Do not split response. Answer in one go"));

List<Message> messages = [];

class Message {
  final String text;
  final DateTime timestamp;
  final String type;
  Message(this.text, this.type) : timestamp = DateTime.now();
}

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  TextEditingController chatController = TextEditingController();

  final chat = model.startChat();

  void sendMessage() async {
    if (chatController.text.isNotEmpty) {
      String myText = chatController.text;

      // Adding the initial message and placeholder synchronously
      setState(() {
        chatController.clear();
        messages.add(Message(myText, "user"));
        messages.add(Message(". . .", "model"));
      });

      try {
        // Performing the async operation outside of setState
        var content = Content.text(myText);
        var response = await chat.sendMessage(content);

        // Updating the state again after receiving the response
        setState(() {
          messages.removeLast(); // Remove the ". . ." placeholder

          if (response.text != null && response.text!.isNotEmpty) {
            messages.add(Message(response.text!, "model"));
          } else {
            messages.add(
                Message("No response received", "model")); // Fallback message
          }
        });
      } catch (error) {
        setState(() {
          messages.removeLast(); // Remove the ". . ." placeholder
          messages.add(
              Message("Error receiving response", "model")); // Error message
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, "AI Chatbot", true),
        body: SafeArea(
            child: Column(
          children: [
            const Text(
              "May produce incorrect results. Verify with official website",
              style: TextStyle(
                  fontFamily: "Urbanist", fontSize: 12, color: Colors.grey),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: messages.map((message) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: (message.type == "user")
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.5),
                            color: (message.type == "user")
                                ? Theme.of(context).primaryColorDark
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: (message.type == "user")
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.text,
                                style: TextStyle(
                                    color: (message.type == "user")
                                        ? Colors.white
                                        : Theme.of(context).primaryColorDark),
                              ),
                              Text(
                                "${message.timestamp.hour.toString().padLeft(2, '0')}: ${message.timestamp.minute.toString().padLeft(2, '0')}",
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: Theme.of(context).textTheme.headlineMedium,
                      controller: chatController,
                      cursorColor: Theme.of(context).dividerColor,
                      decoration: InputDecoration(
                        hintText: "Enter your query",
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFFDDDDDD), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFFAAAAAA), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      minWidth: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.send,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {
                        sendMessage();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        )));
  }
}
