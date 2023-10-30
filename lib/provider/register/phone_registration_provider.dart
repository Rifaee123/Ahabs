import 'package:ahbas/data/register/phone_registration_service.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/model/register/phone_registration/phone_registration.dart';

import 'package:ahbas/model/register/register_response/register_response.dart';
import 'package:ahbas/provider/register/registration_result.dart';
import 'package:flutter/material.dart';

class PhoneRegistrationProvider extends ChangeNotifier {
  RegistrationResult resultData = RegistrationResult(
    isError: false,
    isLoadng: true,
    phoneNumberAlreadyExisted: false,
    isRegistarationSuccess: false,
  );
  Future registerWithPhone({
    required String gender,
    required String dateOfBirth,
    required String password,
    required String phone,
    required String username,
  }) async {
    RegisterResponse? registerResponse;
    final registerBody = PhoneRegistration(
      dateOfBirth: dateOfBirth,
      gender: gender,
      password: password,
      phone: phone,
      username: username,
    );
    bool isAnyError = false;
    final result =
        await PhoneRegistrationService().registerUsingPhone(registerBody);
    isAnyError = result.fold((l) => true, (r) {
      registerResponse = r;
      return false;
    });
    if (isAnyError == false) {
      if (registerResponse!.status == 'true') {
        final StorageItem newItem =
            StorageItem('AuthToken', registerResponse!.token ??= '');
        StorageService.instance.writeSecureData(newItem);
        resultData = RegistrationResult(
            isError: false, isRegistarationSuccess: true, isLoadng: false);
      } else if (registerResponse != null &&
          registerResponse!.message == "Phone number already exists") {
        resultData = RegistrationResult(
            isError: false,
            isRegistarationSuccess: false,
            isLoadng: false,
            phoneNumberAlreadyExisted: true);
      } else if (registerResponse != null &&
          registerResponse!.message == "username already exists") {
        resultData = RegistrationResult(
            isError: false,
            isRegistarationSuccess: false,
            isLoadng: false,
            userNameAlreadyExisted: true);
      } else {
        resultData = RegistrationResult(
            isError: false, isRegistarationSuccess: false, isLoadng: false);
      }
    } else {
      resultData = RegistrationResult(
          isError: true, isRegistarationSuccess: false, isLoadng: false);
    }

    notifyListeners();
  }
}
