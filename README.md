## firebase 연결하는 방법 
### 필요 명령 및 도구 설치
1. firebase 로그인
~~~bash
firebase login
~~~
2. flutterfire_cli 설치
~~~bash
dart pub global activate flutterfire_cli
~~~

### 앱에서 firebase 를 사용하도록 구성
1. firebase 설정
~~~bash
flutterfire configure
~~~

### firebase 를 앱에서 초기화
1. 핵심 플러그인 설치
~~~bash
flutter pub add firebase_core
~~~

2. lib/main.dart 파일에서 Firebase 핵심 플러그인과 이전에 생성한 구성 파일을 가져옵니다.
~~~dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
~~~

3. 또한 lib/main.dart 파일에서 구성 파일에서 내보낸 DefaultFirebaseOptions 개체를 사용하여 Firebase를 초기화합니다.
~~~dart
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
~~~

~~~dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //astnc란 비동기 함수를 선언할 때 사용하는 키워드
  runApp(const MyApp()); //
}
~~~

## flutter firebase auth 연결
### 플러터에서 파이어베이스 인증 추가
1. 플러터 앱에 파이어베이스 인증 플러그인 추가

~~~bash
flutter pub add firebase_auth
~~~

2. firebase_auth 패키지를 가져옵니다.
~~~dart
import 'package:firebase_auth/firebase_auth.dart';
~~~

### 인증 확인
~~~dart
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
~~~

### 구글 인증 등록
1. firebase 콘솔에서 구글 인증 등록
~~~bash
flutter pub add google_sign_in
~~~

2. 구글 로그인 함수 가져오기
~~~dart
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
~~~

3. 정확한 로직은 모르겠으나 IOS에서 구글 로그인을 위해선
Xcode에 GoogleService-Info.plist 파일 추가 해야함
- Runner > Runner > Add Files to "Runner" > GoogleService-Info.plist 파일 추가