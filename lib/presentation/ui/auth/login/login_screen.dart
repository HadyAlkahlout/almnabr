import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:teqani/data/network/app_requests/auth_requests.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/font_manager.dart';
import 'package:teqani/presentation/resources/routes_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/auth/login/login_viewmodel.dart';
import 'package:teqani/presentation/ui/module/module.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel _viewModel = LoginViewModel();

  final TextEditingController _mobileController = TextEditingController();

  _bind() {
    print('login screen bind');
    _viewModel.start(context);
    _mobileController.addListener(() {
      _viewModel.otpData.mobile = _mobileController.text;
      _viewModel.setMobile(_mobileController.text);
    });
  }

  @override
  void initState(){
    print('login screen start');
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
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
                        AppStrings.login,
                        textAlign: TextAlign.center,
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s20,
                        ),
                      ).tr(),
                      const SizedBox(
                        height: AppMargin.m8,
                      ),
                      Text(
                        AppStrings.loginDetails,
                        textAlign: TextAlign.center,
                        style: getRegularStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s14,
                        ),
                      ).tr(),
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
                      Row(
                        children: [
                          CountryCodePicker(
                            onChanged: (countryCode) {
                              _viewModel
                                  .setCountryCode(countryCode.code ?? '');
                            },
                            initialSelection: 'SA',
                            favorite: ['+966', '+972', '+20'],
                            hideMainText: false,
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                            textStyle: getRegularStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s14,
                            ),
                          ),
                          Expanded(
                            child: StreamBuilder<bool>(
                              stream: _viewModel.outputISMobileValid,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _mobileController,
                                  style: getRegularStyle(color: ColorManager.black,),
                                  decoration: InputDecoration(
                                      hintText: AppStrings.mobile.tr(),
                                      errorText: (snapshot.data ?? true)
                                          ? null
                                          : AppStrings.mobileError.tr()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppMargin.m80,
                      ),
                      Mutation(
                        options: MutationOptions(
                          document: gql(AuthRequests.loginMutation),
                          onCompleted: (dynamic result) {
                            print('result data is: $result');
                            _viewModel.loginResult(result, (message, isError) {
                              Module.showToast(message, isError);
                              if (!isError) {
                                _goNext(context);
                              }
                            });
                          },
                        ),
                        builder: (RunMutation runMutation, QueryResult? result){
                          if (result != null && result.isLoading){
                            return CircularProgressIndicator(
                              color: ColorManager.primary,
                            );
                          } else {
                            return StreamBuilder<bool>(
                              stream: _viewModel.outputIsAllInputsValid,
                              builder: (context, snapshot) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: snapshot.data ?? false
                                        ? () {
                                      runMutation({
                                        'mobile':
                                        _viewModel.loginRequest.mobile,
                                        'country_dial': _viewModel
                                            .loginRequest.countryCode,
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
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppMargin.m16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _goNext(BuildContext context){
    Navigator.pushNamed(
      context,
      Routes.otpRoute,
      arguments: _viewModel.otpData,
    );
  }

  @override
  void dispose() {
    print('login screen dispose');
    _viewModel.dispose();
    super.dispose();
  }
}
