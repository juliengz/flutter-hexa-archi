import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/failure.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/signin_use_case.dart';

class SigninNotifier with ChangeNotifier {
  final SigninUseCase _signinUseCase;

  SigninNotifier({
    required SigninUseCase signinUseCase,
  }) : _signinUseCase = signinUseCase;

  bool isLoading = false;

  Map<String, dynamic>? tokens;
  String? error;

  Future<void> signin(
      BuildContext context, String login, String password) async {
    isLoading = true;
    notifyListeners();

    final result = await _signinUseCase(login, password);

    result.fold(
      (e) {
        error = (e is BadCredentialFailure)
            ? "Bad credentials"
            : "Something's wrong";
        isLoading = false;
      },
      (data) {
        tokens = data;
        isLoading = false;
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      },
    );

    notifyListeners();
  }
}
