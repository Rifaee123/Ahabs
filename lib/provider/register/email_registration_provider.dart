import 'package:ahbas/controller/getx/auth_controller.dart';
import 'package:ahbas/data/register/email_registration_service.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/model/register/email_registration/email_registration.dart';

import 'package:ahbas/model/register/register_response/register_response.dart';
import 'package:ahbas/provider/register/registration_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailRegistrationProvider extends ChangeNotifier {
  final Authcontrolller authcontrolller = Get.put(Authcontrolller());
  RegistrationResult resultData = RegistrationResult(
      isError: false,
      isLoadng: true,
      emailAlreadyExisted: false,
      userNameAlreadyExisted: false);
  Future registerWithEmail({
    required String gender,
    required String dateOfBirth,
    required String password,
    required String email,
    required String username,
  }) async {
    bool isAnyError = false;
    RegisterResponse? registerResponse;
    final registerBody = EmailRegistration(
      dateOfBirth: dateOfBirth,
      gender: gender,
      password: password,
      email: email,
      username: username,
    );
    final result =
        await EmailRegistrationService().registerUsingEmail(registerBody);
    isAnyError = result.fold((l) => true, (r) {
      registerResponse = r;
      return false;
    });
    if (isAnyError == false) {
      if (registerResponse!.status == 'true') {
        authcontrolller.isRegister.value = true;
        final StorageItem newItem =
            StorageItem('AuthToken', registerResponse!.token ??= '');
        StorageService.instance.writeSecureData(newItem);
        resultData = RegistrationResult(
            isError: false, isRegistarationSuccess: true, isLoadng: false);
      } else if (registerResponse!.message == "Email already exists") {
        resultData = RegistrationResult(
            isError: false,
            isRegistarationSuccess: false,
            isLoadng: false,
            emailAlreadyExisted: true);
      } else if (registerResponse!.message == "username already exists") {
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
