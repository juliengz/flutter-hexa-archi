import 'package:dartz/dartz.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/failure.dart';
import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_repository_interface.dart';

class SigninUseCase {
  final AuthRepositoryInterface authRepository;

  SigninUseCase({required this.authRepository});

  Future<Either<Failure, dynamic>> call(String login, String password) async {
    return await authRepository.signin(login, password);
  }
}
