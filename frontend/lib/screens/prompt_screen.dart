import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/screens/login_screen.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          color: Colors.white,
          icon: const Icon(
            Icons.logout_outlined,
            size: 30,
          ),
        ),
      ),
      backgroundColor: const Color(0xff23B6E4),
      body: Form(
        child: Theme(
          data: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: const Color(0xffBDE9F7),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.manage_search_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
