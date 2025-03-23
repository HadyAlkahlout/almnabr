import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:teqani/data/network/app_requests/auth_requests.dart';
import 'package:teqani/domain/model/auth/otp_data.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/font_manager.dart';
import 'package:teqani/presentation/resources/routes_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/module.dart';

import 'otp_viewmodel.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.otpData,
  });

  final OtpData otpData;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpViewModel _viewModel = OtpViewModel();

  _bind() {
    print('otp screen bind');
    _viewModel.start(context);
  }

  @override
  void initState() {
    print('otp screen start');
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage(ImageAssets.authBackground),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(
              top: AppMargin.m64,
              start: AppMargin.m32,
              end: AppMargin.m32,
              bottom: AppMargin.m56,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        ImageAssets.logo,
                        width: AppSize.s80,
                        height: AppSize.s80,
                      ),
                      const SizedBox(
                        height: AppMargin.m80,
                      ),
                      Text(
                        _getScreenTitle(4),
                        // _getScreenTitle(otpData.otpLength),
                        textAlign: TextAlign.center,
                        style: getRegularStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppMargin.m64,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Mutation(
                        options: MutationOptions(
                          document: gql(AuthRequests.verifyOtpMutation),
                          onCompleted: (dynamic result) {
                            print('result data is: $result');
                            _viewModel.verifyResult(
                              result,
                                  (message, isError) {
                                Module.showToast(message, isError);
                                if (!isError) {
                                  _goNext(context);
                                }
                              },
                            );
                          },
                        ),
                        builder: (RunMutation runMutation, QueryResult? result) {
                          if (result != null && result.isLoading) {
                            return CircularProgressIndicator(
                              color: ColorManager.primary,
                            );
                          } else {
                            return Column(
                              children: [
                                OtpTextField(
                                  numberOfFields: widget.otpData.otpLength,
                                  focusedBorderColor: ColorManager.primary,
                                  disabledBorderColor: ColorManager.primary,
                                  cursorColor: ColorManager.primary,
                                  showFieldAsBox: false,
                                  onSubmit: (String verificationCode) {
                                    print('code is $verificationCode');
                                    _viewModel.setOtp(
                                      widget.otpData.mobile,
                                      widget.otpData.countryCode,
                                      verificationCode,
                                    );
                                    print('country_dial : ${_viewModel.otpRequest.countryCode}');
                                    runMutation({
                                      'mobile': _viewModel.otpRequest.mobile,
                                      'country_dial':
                                      _viewModel.otpRequest.countryCode,
                                      'otp': _viewModel.otpRequest.otp,
                                      'action_type':
                                      _viewModel.otpRequest.actionType,
                                    });
                                  },
                                  textStyle: getMediumStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s14,
                                  ),
                                ),
                                const SizedBox(
                                  height: AppMargin.m40,
                                ),
                                StreamBuilder<bool>(
                                  stream: _viewModel.outputISOtpValid,
                                  builder: (context, snapshot) {
                                    return SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: snapshot.data ?? false
                                            ? () {
                                          runMutation({
                                            'mobile':
                                            _viewModel.otpRequest.mobile,
                                            'country_dial': _viewModel
                                                .otpRequest.countryCode,
                                            'otp': _viewModel.otpRequest.otp,
                                            'action_type': _viewModel
                                                .otpRequest.actionType,
                                          });
                                        }
                                            : null,
                                        child: Text(
                                          AppStrings.login,
                                          textAlign: TextAlign.center,
                                          style: getRegularStyle(
                                            color: ColorManager.white,
                                            fontSize: FontSize.s14,
                                          ),
                                        ).tr(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: AppMargin.m16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppStrings.doNotReceive,
                              textAlign: TextAlign.center,
                              style: getRegularStyle(
                                fontSize: FontSize.s12,
                                color: ColorManager.black,
                              )).tr(),
                          Mutation(
                            options: MutationOptions(
                              document: gql(AuthRequests.resendOtpMutation),
                              onCompleted: (dynamic result) {
                                print('result data is: $result');
                                _viewModel.resendResult(
                                  result,
                                      (message, isError) {
                                    Module.showToast(message, isError);
                                  },
                                );
                              },
                            ),
                            builder:
                                (RunMutation runMutation, QueryResult? result) {
                              if (result != null && result.isLoading) {
                                return CircularProgressIndicator(
                                  color: ColorManager.primary,
                                );
                              } else {
                                return TextButton(
                                  onPressed: () {
                                    runMutation({
                                      'mobile': widget.otpData.mobile,
                                      'country_dial': widget.otpData.countryCode,
                                      'action_type': 'register',
                                    });
                                  },
                                  child: Text(AppStrings.doNotReceive,
                                      textAlign: TextAlign.center,
                                      style: getBoldStyle(
                                        fontSize: FontSize.s12,
                                        color: ColorManager.black,
                                      )).tr(),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getScreenTitle(int otpLength) {
    String first = tr(AppStrings.otpFirstDetails);
    String last = tr(AppStrings.otpLastDetails);
    return '$first $otpLength $last';
  }

  void _goNext(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, Routes.mainRoute, (_) => false);
  }

  @override
  void dispose() {
    print('otp screen dispose');
    _viewModel.dispose();
    super.dispose();
  }
}
