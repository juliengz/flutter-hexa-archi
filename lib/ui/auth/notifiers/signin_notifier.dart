import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/failure.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/signin_use_case.dart';

class SigninNotifier with ChangeNotifier {
  final SigninUseCase signinUseCase;

  bool isLoading = false;
  String? error;

  SigninNotifier({
    required this.signinUseCase,
  });

  Future<void> signin(
      BuildContext context, String login, String password) async {
    isLoading = true;
    notifyListeners();

    final result = await signinUseCase(login, password);

    result.fold(
      (failure) {
        error = (failure is BadCredentialFailure)
            ? "Bad credentials"
            : "Something's wrong";
        isLoading = false;
      },
      (data) {
        isLoading = false;
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      },
    );

    notifyListeners();
  }
}
