import 'package:flutter/foundation.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/signin_use_case.dart';

/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
class HomeNotifier with ChangeNotifier {
  final SigninUseCase _signinUseCase;

  HomeNotifier({
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
    final result = await _signinUseCase('admin', 'd');

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
