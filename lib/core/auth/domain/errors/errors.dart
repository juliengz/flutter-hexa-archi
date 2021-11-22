import 'package:flutter/foundation.dart';

abstract class AuthError {}

class BadCredentialError implements AuthError {}

class UserNotFoundError implements AuthError {}

class ForbiddenError implements AuthError {}
