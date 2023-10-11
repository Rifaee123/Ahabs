class RegistrationResult {
  final bool? isRegistarationSuccess;
  final bool? emailAlreadyExisted;
  final bool? phoneNumberAlreadyExisted;
  final bool? userNameAlreadyExisted;
  final bool isError;
  final bool isLoadng;

  RegistrationResult({
    this.userNameAlreadyExisted,
    this.phoneNumberAlreadyExisted,
    this.isRegistarationSuccess,
    this.emailAlreadyExisted,
    required this.isError,
    required this.isLoadng,
  });
}

//"Phone number already exists"
//"username already exists"