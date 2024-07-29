import 'dart:convert';

import 'package:frontend/services/auth_service.dart';
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
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final id = _idController.text;
    final password = _passwordController.text;

    // 유효성 검사
    if (id.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('로그인 실패'),
          content: const Text('아이디와 비밀번호 모두 입력해주세요.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        ),
      );
      return;
    }
    try {
      final response = await AuthService.login(
        id: _idController.text,
        password: _passwordController.text,
      );
      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accessToken = data['access'];
        //토큰 저장 후 다음 화면으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PromptScreen(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('로그인 실패'),
            content: const Text('아이디 또는 비밀번호가 잘못되었습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              )
            ],
          ),
        );
      }
    } catch (e) {
      // 예외 처리
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('오류'),
            content: const Text('로그인 중 문제가 발생했습니다. 나중에 다시 시동해 주세요'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  '확인',
                ),
              ),
            ],
          ),
        );
      }
    }
  }

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
                      LoginWidget(
                        label: "아이디",
                        isPassword: false,
                        controller: _idController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      LoginWidget(
                        label: "비밀번호",
                        controller: _passwordController,
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                        onPressed: _login,
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
