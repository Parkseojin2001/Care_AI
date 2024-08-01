import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/widgets/join_widget.dart';
import 'package:frontend/services/auth_service.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  Future<void> _register() async {
    final id = _idController.text;
    final password = _passwordController.text;
    final passwordConfirm = _passwordConfirmController.text;
    final nickname = _nicknameController.text;

    // 유효성 검사
    if (id.isEmpty ||
        password.isEmpty ||
        passwordConfirm.isEmpty ||
        nickname.isEmpty) {
      _showErrorDialog('Please complete all fields.');
      return;
    }

    if (password != passwordConfirm) {
      _showErrorDialog('Password does not match.');
      return;
    }

    try {
      final response = await AuthService.register(
        id: id,
        password: password,
        nickname: nickname,
      );

      if (!mounted) return;

      if (response.statusCode == 201) {
        //회원가입 성공
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else {
        // 서버에서 응답 실패
        final errorMessage =
            jsonDecode(response.body)['error'] ?? 'Failed to sign up';
        _showErrorDialog(errorMessage);
      }
    } catch (e) {
      _showErrorDialog('An error occurred while requesting membership.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Check'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "SIGN UP",
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
                      JoinWidget(
                        title: "ID*",
                        example: "ex)careai",
                        isPassword: false,
                        controller: _idController,
                      ),
                      JoinWidget(
                        title: "Password*",
                        example: "ex) abcdef",
                        isPassword: true,
                        controller: _passwordController,
                      ),
                      JoinWidget(
                        title: "Check Password*",
                        example: "Enter your password one more time",
                        isPassword: true,
                        controller: _passwordConfirmController,
                      ),
                      JoinWidget(
                        title: "NickName*",
                        example: "ex) John",
                        isPassword: false,
                        controller: _nicknameController,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 120,
                            vertical: 14,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          backgroundColor: Colors.grey,
                        ),
                        onPressed: _register,
                        child: const Text("Sign Up"),
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
