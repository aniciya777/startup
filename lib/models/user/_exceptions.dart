import '../../shared/strings.dart';

abstract interface class AuthException implements Exception {}

abstract interface class AuthEmailException implements AuthException {}

abstract interface class AuthPasswordException implements AuthException {}

abstract interface class AuthPasswordRepeatException implements AuthException {}

class AuthUnknownException extends AuthException {
  @override
  String toString() => StaticStrings.errorUnknown;
}

class AuthCredentialsInvalidException extends AuthException {
  @override
  String toString() => StaticStrings.errorCredentialsInvalid;
}

class AuthEmailInvalidException extends AuthEmailException {
  @override
  String toString() => StaticStrings.errorEmailInvalid;
}

class AuthEmailAlreadyInUseException extends AuthEmailException {
  @override
  String toString() => StaticStrings.errorEmailUse;
}

class AuthEmailEmptyException extends AuthEmailException {
  @override
  String toString() => StaticStrings.errorEmailEmpty;
}

class AuthEmailNotFoundException extends AuthEmailException {
  @override
  String toString() => StaticStrings.errorEmailNotFound;
}

class AuthPasswordEmptyException extends AuthPasswordException {
  @override
  String toString() => StaticStrings.errorPasswordEmpty;
}

class AuthPasswordWeakException extends AuthPasswordException {
  @override
  String toString() => StaticStrings.errorPasswordWeak;
}

class AuthPasswordNotMatchException extends AuthPasswordRepeatException {
  @override
  String toString() => StaticStrings.errorPasswordNotMatch;
}

class AuthPasswordTooShortException extends AuthPasswordException {
  int size;

  AuthPasswordTooShortException(this.size);

  @override
  String toString() => StaticStrings.errorPasswordShort
      .replaceFirst('%', size.toString());
}

class AuthPasswordWrongException extends AuthPasswordException {
  @override
  String toString() => StaticStrings.errorPasswordInvalid;
}