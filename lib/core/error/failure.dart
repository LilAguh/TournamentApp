abstract class Failure {
  final String message;
  Failure(this.message);
}

class BadRequestFailure extends Failure {
  BadRequestFailure(super.message);
}

class UnAuthorizedFailure extends Failure {
  UnAuthorizedFailure(super.message);
}

class ForbiddenFailure extends Failure {
  ForbiddenFailure(super.message);
}

class NotFoundFailure extends Failure {
  NotFoundFailure(super.message);
}

class MethodNotAllowedFailure extends Failure {
  MethodNotAllowedFailure(super.message);
}

class UnknownFailure extends Failure {
  UnknownFailure(super.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}
