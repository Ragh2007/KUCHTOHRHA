//id - 123@gmail.com
//password - Abc@1234 ws://192.168.1.5:3000
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login.dart';
import 'signup.dart';

import 'join.dart';
import 'signal.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ELabs App",
      theme: ThemeData(
        snackBarTheme: SnackBarThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: const EdgeInsets.all(16),
          elevation: 8,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.orange[700],
          contentTextStyle: const TextStyle(
            color: Colors.white60,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        dialogTheme: DialogThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: const EdgeInsets.all(16),
          elevation: 8,
          alignment: Alignment.center,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.orange[700],
          contentTextStyle: const TextStyle(
            color: Colors.white60,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/sign',
      routes: {
        '/log': (context) =>  Login(),
        '/sign': (context) =>  const Signup(),
        '/video': (context) => VideoCallWrapper(),},
    );
  }
}

class VideoCallWrapper extends StatelessWidget {
  VideoCallWrapper({super.key});

  final String websocketUrl = "ws://your_server_ip:port";

  final String selfCallerID =
  Random().nextInt(999999).toString().padLeft(6, '0');

  @override
  Widget build(BuildContext context) {
    SignallingService.instance.init(
      websocketUrl: "ws://10.189.24.75:3000",
      selfCallerID: selfCallerID,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(),
      ),
      themeMode: ThemeMode.dark,
      home: JoinScreen(selfCallerId: selfCallerID),
    );
  }
}
