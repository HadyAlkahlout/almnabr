import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:teqani/data/request/auth/login_request.dart';
import 'package:teqani/data/responses/auth/login/login_response.dart';
import 'package:teqani/domain/model/auth/otp_data.dart';
import 'package:teqani/presentation/base/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _mobileStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  LoginRequest loginRequest = LoginRequest();
  OtpData otpData = OtpData();

  @override
  void dispose() {
    print('login view model dispose');
    _mobileStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start(BuildContext context) {
    print('login view model start');
    setCountryCode('sa');
  }

  @override
  Sink get inputMobile => _mobileStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  loginResult(
      Map<String, dynamic> result,
      Function(
        String message,
        bool isError,
      ) onResult) {
    LoginResponse loginData = LoginResponse.fromJson(result);
    if (loginData.userLogin!.status!) {
      print('request done otp code: ${loginData.userLogin!.otp}');
      otpData.otpLength = loginData.userLogin!.otpLength ?? 0;
      onResult(
        loginData.userLogin!.message ?? '',
        false,
      );
    } else {
      print('result has error');
      onResult(
        loginData.userLogin!.message ?? '',
        true,
      );
    }
  }

  @override
  setCountryCode(String countryCode) {
    loginRequest.countryCode = countryCode;
    otpData.countryCode = countryCode;
  }

  @override
  setMobile(String mobile) {
    loginRequest.mobile = mobile;
    inputMobile.add(mobile);
    inputIsAllInputsValid.add(null);
  }

  @override
  Stream<bool> get outputISMobileValid =>
      _mobileStreamController.stream.map((mobile) => _isMobileValid(mobile));

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputValid());

  bool _isMobileValid(String mobile) {
    return mobile.isNotEmpty;
  }

  bool _isAllInputValid() {
    return loginRequest.mobile.isNotEmpty && loginRequest.mobile.length >= 9;
  }
}

abstract mixin class LoginViewModelInputs {
  setMobile(String mobile);

  setCountryCode(String countryCode);

  loginResult(
      Map<String, dynamic> result,
      Function(
        String message,
        bool isError,
      ) onResult);

  Sink get inputMobile;

  Sink get inputIsAllInputsValid;
}

abstract mixin class LoginViewModelOutputs {
  Stream<bool> get outputISMobileValid;

  Stream<bool> get outputIsAllInputsValid;
}
