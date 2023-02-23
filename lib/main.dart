import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth/auth_widget.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'sign_up_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp(
      title: 'Whatsapp Chat Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(
          0xff075E54,
        )),
      ),
      home: AuthWidget(
        signedInBuilder: (context) => const Home(),
        nonSignedInBuilder: (context) => const SignUpLogIn(),
      ),
    );
  }
}
