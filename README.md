## firebase 연결하는 방법 
### 필요 명령 및 도구 설치
1. firebase 로그인
~~~
firebase login
~~~
2. flutterfire_cli 설치
~~~
dart pub global activate flutterfire_cli
~~~

### 앱에서 firebase 를 사용하도록 구성
1. firebase 설정
~~~
flutterfire configure
~~~

### firebase 를 앱에서 초기화
1. 핵심 플러그인 설치
~~~
flutter pub add firebase_core
~~~

2. lib/main.dart 파일에서 Firebase 핵심 플러그인과 이전에 생성한 구성 파일을 가져옵니다.
~~~
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
~~~

3. 또한 lib/main.dart 파일에서 구성 파일에서 내보낸 DefaultFirebaseOptions 개체를 사용하여 Firebase를 초기화합니다.
~~~
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
~~~

~~~
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //astnc란 비동기 함수를 선언할 때 사용하는 키워드
  runApp(const MyApp()); //
}
~~~