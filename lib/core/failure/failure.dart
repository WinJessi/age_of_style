import '../constants/constants.dart';

abstract class Failure {}

class UnauthorizedUser extends Failure {}

class SomethingWentWrong extends Failure {
  SomethingWentWrong({this.message});

  final String? message;
}

class InvalidCredential extends Failure {}

class UserNotFound extends Failure {}

class TimeOutError extends Failure {}

class UnexpectedError extends Failure {}

class ServerException extends Failure {}

class InvalidCode extends Failure {}

class TooManyAttempt extends Failure {}

class AddressNotFound extends Failure {}

class FailureToString {
  static String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerException:
        return kSERVER_EXCEPTION_MESSAGE;
      case InvalidCredential:
        return kINVALID_CREDENTIAL_MESSAGE;
      case UnauthorizedUser:
        return kUNAUTHORIZED_USER_MESSAGE;
      case SomethingWentWrong:
        return kSOMETHING_WENT_WRONG;
      case TimeOutError:
        return kTIME_OUT_MESSAGE;
      case InvalidCode:
        return kINVALID_CODE;
      case TooManyAttempt:
        return kTOO_MANY_ATTEMPT;
      case AddressNotFound:
        return kADDRESS_NOT_FOUND;
      default:
        return kUNEXPECTED_ERROR_MESSAGE;
    }
  }
}
