// ignore_for_file: unused_local_variable

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/errors.dart';
import 'package:flutter_clean_archi/core/auth/domain/entities/user.dart';
import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_backend_gateway.dart';
import 'package:flutter_clean_archi/core/auth/domain/use_cases/signin_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

User fakeUser = User(id: 1, name: 'admin');

class StubAuthBackendGateway implements AuthBackendGateway {
  @override
  Future<Either<AuthError, User>> signin(String login, String password) async {
    return (login == "admin" && password == "admin")
        ? Right(fakeUser)
        : Left(BadCredentialError());
  }

  @override
  Future<Either<AuthError, User>> me() {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthError, bool>> signout() {
    throw UnimplementedError();
  }
}

void main() {
  SigninUseCase? usecase;

  setUp(() {
    usecase = SigninUseCase(authBackendGateway: StubAuthBackendGateway());
  });

  test('Should return user from auth backend gateway', () async {
    final Either<AuthError, User> signinSuccessResult =
        await usecase!.call('admin', 'admin');

    signinSuccessResult.fold(
      (error) => fail('test failed'),
      (user) => expect(user, equals(fakeUser)),
    );
  });

  test('Should return error from auth backend gateway', () async {
    final Either<AuthError, User> signinFailureResult =
        await usecase!.call('wronglogin', 'wrongpassword');

    signinFailureResult.fold(
      (error) => {expect(true, error is AuthError)},
      (user) => fail('test failed'),
    );
  });
}
