import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; //
import 'package:firebase_auth/firebase_auth.dart'; // firebase_auth 라이브러리 추가 : 로그인을 위해
import 'package:google_sign_in/google_sign_in.dart'; // google_sign_in 라이브러리 추가 : 구글 로그인을 위해
//import mainPage.dart
import 'mainPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //astnc란 비동기 함수를 선언할 때 사용하는 키워드
  runApp(const MaterialApp(home: MyApp())); //
}

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser =
      await GoogleSignIn().signIn(); // 구글 로그인 팝업창 띄우기
  // 구글 로그인 팝업창에서 받은 정보를 googleAuth에 저장
  final GoogleSignInAuthentication? googleAuth = await googleUser
      ?.authentication; // googleUser가 null이 아닐 때 googleUser의 authentication을 googleAuth에 저장

  final credential = GoogleAuthProvider.credential(
    // googleAuth에 저장된 정보를 credential에 저장
    accessToken:
        googleAuth?.accessToken, // googleAuth의 accessToken을 credential에 저장
    idToken: googleAuth?.idToken, // googleAuth의 idToken을 credential에 저장
  );

  return await FirebaseAuth.instance
      .signInWithCredential(credential); // credential을 이용해 firebase에 로그인
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pastelBlue = const Color(0xFFB2EBF2); // 파스텔 블루 색상 변수
  bool _passwordVisible = false; // 비밀번호 보이기 or 숨기기 변수

  @override
  void initState() {
    super.initState();
//am i logined?
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
          (route) => route.isFirst,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //firebase 가 연결되었는지 확인하는 조건문
    // ignore: avoid_print
    Firebase.apps.isEmpty ? print("not connected") : print("connected");
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

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
                  child: TextField(
                    obscureText: !_passwordVisible, //
                    decoration: InputDecoration(
                      //password hide on off button
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'password',
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
                const SizedBox(height: 30),
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
                          // google social login button
                          iconSize: 50,
                          onPressed: () {
                            signInWithGoogle();
                            setState(() {});
                          },
                          icon: Image.asset('assets/logo/google_logo.png')),
                      TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          },
                          child: const Text('Logout_test')),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Text("am i logined?"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
