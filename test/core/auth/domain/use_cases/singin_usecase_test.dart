// ignore_for_file: unused_local_variable

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/failure.dart';
import 'package:flutter_clean_archi/core/auth/domain/entities/user.dart';
import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_repository_interface.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/signin_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class StubAuthRepository implements AuthRepositoryInterface {
  @override
  Future<Either<Failure, User>> getUser() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> signin(String login, String password) async {
    final Map tokens = {
      "accessToken": "123456789",
      "refreshToken": "123456789",
    };
    return (login == "admin" && password == "admin")
        ? Right(tokens)
        : Left(BadCredentialFailure());
  }
}

void main() {
  SigninUseCase? usecase;

  setUp(() {
    usecase = SigninUseCase(authRepository: StubAuthRepository());
  });

  final Map tokens = {
    "accessToken": "123456789",
    "refreshToken": "123456789",
  };

  test('should return tokens from repository', () async {
    final Either<Failure, dynamic> signinSuccessResult =
        await usecase!.call('admin', 'admin');
    final Either<Failure, dynamic> signinFailureResult =
        await usecase!.call('wronglogin', 'wrongpassword');

    signinSuccessResult.fold(
      (left) => fail('test failed'),
      (right) {
        expect(right, equals(tokens));
      },
    );

    signinFailureResult.fold(
      (left) => {expect(true, left is Failure)},
      (right) => fail('test failed'),
    );
  });
}
