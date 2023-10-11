import 'package:ahbas/data/login/login_service.dart';
import 'package:ahbas/data/services/secure_storage/secure_storage.dart';
import 'package:ahbas/model/login/login/login.dart';
import 'package:ahbas/model/login/login_response/login_response.dart';

import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  LoginResult resultData =
      LoginResult(isError: false, isLoading: true, isPasswordInvalid: false);
  Future login({required String identifier, required String pasword}) async {
    LoginResponse? loginResponse;
    bool isAnyError = false;
    final loginBody = Login(identifier: identifier, password: pasword);
    final result = await LoginService().login(loginBody);
    isAnyError = result.fold((l) => true, (r) {
      loginResponse = r;
      return false;
    });
    if (isAnyError == false) {
      if (loginResponse!.status == 'true') {
        final StorageItem newItem =
            StorageItem('AuthToken', loginResponse!.token ??= '');
        StorageService.instance.writeSecureData(newItem);

        resultData =
            LoginResult(isError: false, isAuthorized: true, isLoading: false);
      } else if (loginResponse!.message == "Invalid password") {
        resultData = LoginResult(
            isError: false,
            isAuthorized: false,
            isLoading: false,
            isPasswordInvalid: true);
      } else {
        resultData =
            LoginResult(isError: false, isAuthorized: false, isLoading: false);
      }
    } else {
      resultData = LoginResult(isError: true, isLoading: false);
    }

    notifyListeners();
  }
}

class LoginResult {
  final bool? isAuthorized;
  final bool? isPasswordInvalid;
  final bool isError;
  final bool isLoading;

  LoginResult(
      {this.isPasswordInvalid,
      this.isAuthorized,
      required this.isError,
      required this.isLoading});
}
