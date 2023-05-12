import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //astnc란 비동기 함수를 선언할 때 사용하는 키워드
  runApp(const MyApp()); //
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pastelBlue = const Color(0xFFB2EBF2);

  @override
  void initState() {
    //initState는 위젯이 생성될 때 호출되는 함수
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //firebase 가 연결되었는지 확인하는 조건문
    // ignore: avoid_print
    Firebase.apps.isEmpty ? print("not connected") : print("connected");
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network('https://picsum.photos/250?image=220',
                            width: 200, height: 200),
                        const SizedBox(height: 16),
                        const Text("login Page",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            )),
                      ]),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        margin:
                            const EdgeInsets.only(left: 16, right: 8, top: 16),
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(_pastelBlue)),
                            onPressed: () {
                              print("회원가입 페이지로 이동");
                            },
                            child: const Text('회원가입')),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        margin:
                            const EdgeInsets.only(left: 8, right: 16, top: 16),
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(_pastelBlue)),
                            onPressed: () {
                              print("로그인 성공 or 실패");
                            },
                            child: const Text('로그인')),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                const Text("or login with Social Network",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          iconSize: 50,
                          onPressed: () {},
                          icon: const Icon(Icons.login)),
                      IconButton(
                          iconSize: 50,
                          onPressed: () {},
                          icon: const Icon(Icons.login)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
