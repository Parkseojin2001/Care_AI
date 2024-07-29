import 'package:flutter/material.dart';
import 'package:frontend/screens/join_screen.dart';
import 'package:frontend/widgets/login_widget.dart';
import 'package:frontend/screens/prompt_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "로그인",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        child: Theme(
          data: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(fontSize: 18),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
                  // SingleChildScrollView으로 감싸 줌
                  child: Column(
                    children: [
                      const LoginWidget(label: "아이디"),
                      const SizedBox(
                        height: 20,
                      ),
                      const LoginWidget(label: "비밀번호"),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: Color(0xff02C139),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "자동로그인",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "아이디/비밀번호",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 110,
                            vertical: 12,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          backgroundColor: const Color(0xff02C139),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PromptScreen(),
                            ),
                          );
                        },
                        child: const Text("지금 로그인"),
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const JoinScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "지금 바로 회원가입 >",
                          style: TextStyle(
                            color: Color(0xff02C139),
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
