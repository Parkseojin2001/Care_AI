import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/widgets/join_widget.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "회원가입",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Form(
        child: Theme(
          data: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(40),
                  // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
                  // SingleChildScrollView으로 감싸 줌
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const JoinWidget(
                        title: "아이디*",
                        example: "ex)careai",
                        isPassword: false,
                      ),
                      const JoinWidget(
                        title: "비밀번호*",
                        example: "ex) 영문, 숫자 조합 8~16자리",
                        isPassword: true,
                      ),
                      const JoinWidget(
                          title: "비밀번호 확인*",
                          example: "비밀번호를 한번 더 입력해 주세요",
                          isPassword: true),
                      const JoinWidget(
                          title: "닉네임*", example: "ex) 홍길동", isPassword: false),
                      const SizedBox(
                        height: 50,
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 140,
                            vertical: 12,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          backgroundColor: Colors.grey,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text("가입"),
                      ),
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
