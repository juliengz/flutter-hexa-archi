import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_manager_interface.dart';

class SignoutUseCase {
  final AuthManagerInterface authenticationManager;

  SignoutUseCase({required this.authenticationManager});

  Future<void> exec() async {
    return await authenticationManager.signout();
  }
}
