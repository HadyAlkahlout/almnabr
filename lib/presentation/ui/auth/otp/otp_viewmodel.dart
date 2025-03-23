import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/data/request/auth/otp_request.dart';
import 'package:teqani/data/responses/auth/otp/resend/resend_response.dart';
import 'package:teqani/data/responses/auth/otp/verify/otp_response.dart';
import 'package:teqani/presentation/base/base_viewmodel.dart';

class OtpViewModel extends BaseViewModel
    with OtpViewModelInputs, OtpViewModelOutputs {
  final StreamController _codeStreamController =
      StreamController<String>.broadcast();

  OtpRequest otpRequest = OtpRequest();

  @override
  void dispose() {
    print('otp view model dispose');
    _codeStreamController.close();
  }

  @override
  void start(BuildContext context) {
    print('otp view model start');
  }

  @override
  Sink get inputOtp => _codeStreamController.sink;

  @override
  verifyResult(Map<String, dynamic> result,
      Function(String message, bool isError) onResult) {
    OtpResponse otpData = OtpResponse.fromJson(result);
    if (otpData.verifyOtp!.status!) {
      print('request done token: ${otpData.verifyOtp!.token}');
      AppPreferences.setUserToken(otpData.verifyOtp!.token ?? '');
      AppPreferences.setUserData(
        otpData.verifyOtp!.userData!.name ?? '',
        otpData.verifyOtp!.userData!.email ?? '',
        otpData.verifyOtp!.userData!.mobile ?? '',
      );
      AppPreferences.setIsUserLoggedIn();
      onResult(otpData.verifyOtp!.message ?? '', false);
    } else {
      print('result has error');
      onResult(otpData.verifyOtp!.message ?? '', true);
    }
  }

  @override
  resendResult(Map<String, dynamic> result,
      Function(String message, bool isError) onResult) {
    ResendResponse resendData = ResendResponse.fromJson(result);
    if (resendData.userResend!.status!) {
      print('request done OTP resent: ${resendData.userResend!.otp}');
      onResult(resendData.userResend!.message ?? '', false);
    } else {
      print('result has error');
      onResult(resendData.userResend!.message ?? '', true);
    }
  }

  @override
  setOtp(String mobile, String countryCode, String code) {
    otpRequest.mobile = mobile;
    otpRequest.countryCode = countryCode;
    otpRequest.otp = code;
    otpRequest.actionType = 'login';
    inputOtp.add(code);
  }

  @override
  Stream<bool> get outputISOtpValid =>
      _codeStreamController.stream.map((code) => _isOtpValid(code));

  bool _isOtpValid(String code) {
    return code.isNotEmpty;
  }
}

abstract mixin class OtpViewModelInputs {
  setOtp(String mobile, String countryCode, String code);

  verifyResult(Map<String, dynamic> result,
      Function(String message, bool isError) onResult);

  resendResult(Map<String, dynamic> result,
      Function(String message, bool isError) onResult);

  Sink get inputOtp;
}

abstract mixin class OtpViewModelOutputs {
  Stream<bool> get outputISOtpValid;
}
