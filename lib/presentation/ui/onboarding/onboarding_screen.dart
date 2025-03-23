import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/font_manager.dart';
import 'package:teqani/presentation/resources/routes_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage(ImageAssets.onboardingBackground),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            color: ColorManager.primary.withOpacity(0.3),
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            color: ColorManager.white.withOpacity(0.3),
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(
              top: AppMargin.m64,
              start: AppMargin.m32,
              end: AppMargin.m32,
              bottom: AppMargin.m56,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        ImageAssets.logo,
                        width: AppSize.s64,
                        height: AppSize.s64,
                      ),
                      const SizedBox(
                        height: AppMargin.m40,
                      ),
                      Text(
                        AppStrings.onboardingTitleFirst,
                        textAlign: TextAlign.start,
                        style: getMediumStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s30,
                        ),
                      ).tr(),
                      Stack(
                        children: [
                          Container(
                            width: AppSize.s132,
                            height: AppSize.s24,
                            color: ColorManager.primary,
                            margin: const EdgeInsetsDirectional.only(
                              top: AppMargin.m28,
                            ),
                          ),
                          Text(
                            AppStrings.onboardingTitleSecond,
                            textAlign: TextAlign.start,
                            style: getBoldStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s40,
                            ),
                          ).tr(),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      height: AppSize.s48,
                      margin: EdgeInsets.symmetric(
                        horizontal: AppPadding.p24,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          _openNext(context);
                        },
                        child: Text(
                          AppStrings.onboardingButton,
                          textAlign: TextAlign.center,
                          style: getRegularStyle(
                            color: ColorManager.white,
                            fontSize: FontSize.s14,
                          ),
                        ).tr(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openNext(BuildContext context) {
    if (AppPreferences.isUserLoggedIn()) {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.mainRoute, (_) => false);
    } else {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
  }
}
