import 'package:dartz/dartz.dart';
import 'package:flutter_clean_archi/core/auth/domain/entities/user.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/failure.dart';
import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_manager_interface.dart';
import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_repository_interface.dart';
import 'package:get_storage/get_storage.dart';

class JwtAuthManager implements AuthManagerInterface {
  final AuthRepositoryInterface authRepository;
  final box = GetStorage();
  User? currentUser;

  JwtAuthManager({required this.authRepository});

  @override
  Future<Either<Failure, dynamic>> signin(String login, String password) async {
    Failure? fail;
    Either<Failure, dynamic> signinResponse =
        await authRepository.signin(login, password);

    signinResponse.fold(
      (failure) {
        fail = failure;
      },
      (tokens) async {
        await box.write('accessToken', tokens['accessToken']);
        await box.write('refreshToken', tokens['refreshToken']);

        Either<Failure, User> userResponse = await authRepository.getUser();
        userResponse.fold(
          (failure) {
            fail = failure;
          },
          (user) async {
            currentUser = user;
          },
        );
      },
    );

    if (fail != null) {
      return Left(fail!);
    } else {
      return const Right(true);
    }
  }

  @override
  Future<void> signout() async {
    await box.remove('accessToken');
    await box.remove('refreshToken');
  }

  @override
  bool isAuthenticated() {
    return currentUser != null;
  }

  @override
  Future<void> handleAuthenticationState() async {
    String? accessToken = box.read('accessToken');

    if (accessToken != null) {
      Either<Failure, User> userResponse = await authRepository.getUser();
      userResponse.fold(
        (failure) async {
          print('handleAuthenticationState; user not retrived');
          await signout();
        },
        (user) async {
          currentUser = user;
        },
      );

      //TODO: handle token refresh
    }
  }
}
