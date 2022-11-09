import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iec_app/app/modules/authentication/views/screens/login_screen.dart';
import 'package:iec_app/app/modules/profile/data/user.dart';
import 'package:iec_app/app/modules/wrapper/views/bottom_nav_bar.dart';
import 'package:iec_app/app/shared/helpers/preferences/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Preferences.initalize();
  cachedName = Preferences.getString('name') ?? '';
  cachedMail = Preferences.getString('mail') ?? '';
  cachedPassword = Preferences.getString('password') ?? '';
  devToken = Preferences.getString('token');
  cachedCart = Preferences.getStringList('cachedCartList') ?? [];

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: devToken != null ? const BottomNavBarWidget() : const LoginScreen(),
    );
  }
}
