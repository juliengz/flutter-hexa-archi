abstract class Failure {}

class BadCredentialFailure implements Failure {}

class UserNotFoundFailure implements Failure {}

class ForbiddenFailure implements Failure {}

class AuthFailure implements Failure {}
