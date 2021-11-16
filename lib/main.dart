// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_archi/dependencies_injection.dart' as di;
import 'package:flutter_clean_archi/ui/auth/pages/signin_page.dart';
import 'package:flutter_clean_archi/ui/home/notifiers/home_notifier.dart';
import 'package:flutter_clean_archi/ui/auth/notifiers/signin_notifier.dart';
import 'package:flutter_clean_archi/ui/home/pages/home_page.dart';

import 'package:provider/provider.dart';

void main() async {
  await di.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.sl<HomeNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.sl<SigninNotifier>(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => const SigninPage(),
        '/': (context) => const HomePage(),
      },
    );
  }
}
