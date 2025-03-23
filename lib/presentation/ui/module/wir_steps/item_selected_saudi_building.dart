import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/domain/model/main/saudi_code.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/local_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/module.dart';

class ItemSelectedSaudiBuilding extends StatelessWidget {
  const ItemSelectedSaudiBuilding({
    super.key,
    required this.saudiCode,
    required this.onEdit,
    required this.onDelete,
  });

  final SaudiCode saudiCode;
  final Function(SaudiCode) onEdit;
  final Function(SaudiCode) onDelete;

  @override
  Widget build(BuildContext context) {
    String lang = AppPreferences.getAppLanguage();
    return Module.appCard(
      child: Column(
        spacing: AppMargin.m8,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  AppStrings.title,
                  textAlign: TextAlign.center,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
              ),
              Visibility(
                visible: saudiCode.fromApi,
                child: Expanded(
                  child: Text(
                    AppStrings.status,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: ColorManager.black,
                    ),
                  ).tr(),
                ),
              ),
            ],
          ),
          Row(
            spacing: AppMargin.m8,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  lang == ENGLISH ? saudiCode.titleEn : saudiCode.titleAr,
                  textAlign: TextAlign.center,
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ),
              Visibility(
                visible: saudiCode.fromApi,
                child: Expanded(
                  child: GestureDetector(
                    onTap: (){
                      saudiCode.status =
                      saudiCode.status == '1' ? '0' : '1';
                      onEdit(saudiCode);
                    },
                    child: Column(
                      spacing: AppMargin.m4,
                      children: [
                        Container(
                          width: AppSize.s24,
                          height: AppSize.s24,
                          decoration: BoxDecoration(
                            color: saudiCode.status == '1'
                                ? ColorManager.primary
                                : ColorManager.white,
                            border: Border.all(
                              width: AppSize.s2,
                              color: saudiCode.status == '1'
                                  ? ColorManager.primary
                                  : ColorManager.lightGrey,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.s8)),
                          ),
                          child: Center(
                            child: saudiCode.status == '1'
                                ? SvgPicture.asset(IconsAssets.checkIcon)
                                : SvgPicture.asset(
                              IconsAssets.xIcon,
                              width: AppSize.s12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: !(saudiCode.fromApi),
            child: Column(
              spacing: AppMargin.m8,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.status,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                          color: ColorManager.black,
                        ),
                      ).tr(),
                    ),
                    Expanded(
                      child: Text(
                        AppStrings.actions,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                          color: ColorManager.black,
                        ),
                      ).tr(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          saudiCode.status =
                          saudiCode.status == '1' ? '0' : '1';
                          onEdit(saudiCode);
                        },
                        child: Column(
                          spacing: AppMargin.m4,
                          children: [
                            Container(
                              width: AppSize.s24,
                              height: AppSize.s24,
                              decoration: BoxDecoration(
                                color: saudiCode.status == '1'
                                    ? ColorManager.primary
                                    : ColorManager.white,
                                border: Border.all(
                                  width: AppSize.s2,
                                  color: saudiCode.status == '1'
                                      ? ColorManager.primary
                                      : ColorManager.lightGrey,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(AppSize.s8)),
                              ),
                              child: Center(
                                child: saudiCode.status == '1'
                                    ? SvgPicture.asset(IconsAssets.checkIcon)
                                    : SvgPicture.asset(
                                        IconsAssets.xIcon,
                                        width: AppSize.s12,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          onDelete(saudiCode);
                        },
                        child: SvgPicture.asset(
                          IconsAssets.deleteIcon,
                          color: ColorManager.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _openFile() {}
}
