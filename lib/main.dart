// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/is_already_signin_use_case.dart';
import 'package:flutter_clean_archi/dependencies_injection.dart' as di;
import 'package:flutter_clean_archi/ui/auth/views/signin_page.dart';
import 'package:flutter_clean_archi/ui/auth/notifiers/auth_notifier.dart';
import 'package:flutter_clean_archi/ui/home/pages/home_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init services
  // TODO: refactor init steps
  await di.init();
  await GetStorage.init();

  bool isAuthenticated = false;
  IsAlreadySigninUseCase isAlreadySigninUseCase =
      di.sl<IsAlreadySigninUseCase>();

  var result = await isAlreadySigninUseCase.call();

  result.fold(
    (failure) {
      isAuthenticated = false;
    },
    (user) {
      isAuthenticated = true;
    },
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.sl<AuthNotifier>(),
        ),
      ],
      child: MyApp(
        isAuthenticated: isAuthenticated,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isAuthenticated;

  const MyApp({
    Key? key,
    required this.isAuthenticated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: isAuthenticated ? '/' : '/signin',
      routes: {
        '/signin': (context) => const SigninPage(),
        '/': (context) => const HomePage(),
      },
    );
  }
}
