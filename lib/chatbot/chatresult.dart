import 'package:flutter/material.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:myrailguide/widgets/loading.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:myrailguide/auth/secrets.dart' as env;

String apiKey = env.API_KEY;
int status = 0;
String resultQ = 'Result not yet generated. Wait...';

final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

class ChatResult extends StatefulWidget {
  final String query;
  const ChatResult({super.key, required this.query});

  @override
  State<ChatResult> createState() => _ChatResultState();
}

class _ChatResultState extends State<ChatResult> {
  Future<void> getQueryResult(reqQuery) async {
    final content = [Content.text(reqQuery)];
    final response = await model.generateContent(content);
    resultQ = (response.text) ?? 'Result not generated';
    setState(() {
      status = 1;
    });
  }

  @override
  void initState() {
    super.initState();
    status = 0;
    getQueryResult(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Chatbot", true),
      body: SafeArea(
        child: status == 0
            ? const PNRLoading()
            : Padding(
                padding: Paddings.maincontent,
                child: Markdown(
                  data: resultQ,
                ),
              ),
      ),
    );
  }
}
