import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_manager_interface.dart';

class AuthNotifier with ChangeNotifier {
  final AuthManagerInterface authManager;

  AuthNotifier({required this.authManager});
}
