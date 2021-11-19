import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/signin_use_case.dart';

class SigninNotifier with ChangeNotifier {
  final SigninUseCase _signinUseCase;

  SigninNotifier({
    required SigninUseCase signinUseCase,
  }) : _signinUseCase = signinUseCase;

  bool isLoading = false;
  Map<String, dynamic>? tokens;
  String? error;

  Future<void> signin(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final result = await _signinUseCase('admin', 'admin');

    result.fold(
      (e) {
        error = "fail";
        isLoading = false;
      },
      (data) {
        tokens = data;
        isLoading = false;
        Navigator.pushReplacementNamed(context, '/');
      },
    );

    notifyListeners();
  }
}
