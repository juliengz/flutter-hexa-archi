import 'package:dartz/dartz.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/failure.dart';
import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_manager_interface.dart';

class SigninUseCase {
  final AuthManagerInterface authManager;

  SigninUseCase({required this.authManager});

  Future<Either<Failure, dynamic>> call(String login, String password) async {
    return await authManager.signin(login, password);
  }
}
