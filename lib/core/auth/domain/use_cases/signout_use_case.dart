import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_manager_interface.dart';

class SignoutUseCase {
  final AuthManagerInterface authManager;

  SignoutUseCase({required this.authManager});

  Future<void> call() async {
    return await authManager.signout();
  }
}
