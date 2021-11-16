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

  Future<void> signin() async {
    // show loading
    isLoading = true;
    notifyListeners();

    // Fetch the list
    final result = await _signinUseCase('admin', 'admin');

    // Handle success or error
    result.fold(
      (e) {
        error = "fail";
        isLoading = false;
      },
      (data) {
        tokens = data;
        isLoading = false;
      },
    );

    // notify UI
    notifyListeners();
  }
}
