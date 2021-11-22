import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_archi/core/auth/domain/entities/user.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/errors.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/is_already_signin_use_case.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/signin_use_case.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/signout_use_case.dart';

class AuthNotifier with ChangeNotifier {
  final SigninUseCase signinUseCase;
  final SignoutUseCase signoutUseCase;
  final IsAlreadySigninUseCase isAlreadySigninUseCase;

  User? _currentUser;
  bool isLoading = false;
  String? error;

  AuthNotifier({
    required this.signinUseCase,
    required this.signoutUseCase,
    required this.isAlreadySigninUseCase,
  });

  User? get currentUser => _currentUser;

  // Future<void> isAuthenticated() async {
  //   final result = await isAlreadySigninUseCase();

  //   result.fold(
  //     (failure) {
  //       error = (failure is BadCredentialError)
  //           ? "Bad credentials"
  //           : "Something's wrong";
  //       isLoading = false;
  //     },
  //     (user) {
  //       error = null;
  //       isLoading = false;
  //       _currentUser = user;

  //       print(currentUser);
  //     },
  //   );
  // }

  Future<void> signin(
    BuildContext context,
    String login,
    String password,
  ) async {
    isLoading = true;
    notifyListeners();

    final result = await signinUseCase(login, password);

    result.fold(
      (failure) {
        error = (failure is BadCredentialError)
            ? "Bad credentials"
            : "Something's wrong";
        isLoading = false;
      },
      (user) {
        error = null;
        isLoading = false;
        _currentUser = user;
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      },
    );

    notifyListeners();
  }

  Future<void> signout(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await signoutUseCase();
    _currentUser = null;

    isLoading = false;
    notifyListeners();

    Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false);
  }
}
