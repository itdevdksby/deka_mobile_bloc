// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../di/di.dart';
import '../../../resource/theme.dart';
import '../../../ui/dashboard/dashboard.dart';
import '../../../ui/login/login.dart';
import '../../../ui/login/register/register.dart';
import '../../../ui/login/reset/reset_password.dart';
import '../../../ui/rekap_izin/input/input_rekap_izin.dart';
import '../../../ui/rekap_izin/rekap_izin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      debugShowCheckedModeBanner: true,
      initialRoute: Login.nameRoute,
      routes: {
        Login.nameRoute: (context) => Login(),
        ResetPassword.nameRoute: (context) => ResetPassword(),
        Register.nameRoute: (context) => Register(),
        Dashboard.nameRoute: (context) => Dashboard(),
        RekapIzin.nameRoute: (context) => RekapIzin(),
        InputRekapIzin.nameRoute: (context) => InputRekapIzin(),
      },
    );
  }
}
