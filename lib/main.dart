// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return GetMaterialApp(
      theme: theme(),
      debugShowCheckedModeBanner: true,
      defaultTransition: Transition.rightToLeft,
      initialRoute: Login.nameRoute,
      getPages: [
        GetPage(name: Login.nameRoute,          page: () => Login()),
        GetPage(name: ResetPassword.nameRoute,  page: () => ResetPassword()),
        GetPage(name: Register.nameRoute,       page: () => Register()),
        GetPage(name: Dashboard.nameRoute,      page: () => Dashboard()),
        GetPage(name: RekapIzin.nameRoute,      page: () => RekapIzin()),
        GetPage(name: InputRekapIzin.nameRoute, page: () => InputRekapIzin()),
      ],
    );
  }
}
