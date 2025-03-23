import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teqani/domain/model/main/dashboard_tap.dart';
import 'package:teqani/domain/model/main/language.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/font_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';

class Module {
  static Widget appCard({required Widget child}){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s16),
          gradient: LinearGradient(
            colors: [
              ColorManager.cardStartColor,
              ColorManager.cardEndColor,
            ],
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
          )),
      child: child,
    );
  }

  static Widget approveCard({required Widget child, required bool isApproved}){
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: AppPadding.p8,
          horizontal: AppPadding.p16,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s16),
          color: isApproved ? ColorManager.approvedColor : ColorManager.rejectedColor,
      ),
      child: child,
    );
  }

  static void showAlert(
    BuildContext context,
    String? title,
    String? message,
    Function onOk,
    Function? onCancel,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorManager.white,
          title: Text(
            title ?? AppStrings.confirmAction,
            style: getMediumStyle(
              color: ColorManager.black,
              fontSize: FontSize.s16,
            ),
          ).tr(),
          content: Text(
            message ?? AppStrings.alertMessage,
            style: getRegularStyle(
              color: ColorManager.black,
              fontSize: FontSize.s14,
            ),
          ).tr(),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onCancel != null) {
                  onCancel();
                }
              },
              child: Text(
                AppStrings.cancel,
                style: getRegularStyle(
                  color: ColorManager.grey,
                  fontSize: FontSize.s14,
                ),
              ).tr(),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onOk();
              },
              child: Text(
                AppStrings.ok,
                style: getRegularStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s14,
                ),
              ).tr(),
            ),
          ],
        );
      },
    );
  }

  static void showToast(String message, bool isError) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: isError ? ColorManager.errorOpacity15 : ColorManager.successOpacity15,
      textColor: ColorManager.white,
      fontSize: FontSize.s14,
    );
  }

  static Widget languageItem(Language lang, bool isOption,
      {Function? onClick}) {
    return InkWell(
      onTap: isOption
          ? () {
              onClick!();
            }
          : null,
      borderRadius: BorderRadius.circular(AppSize.s16),
      child: Container(
        height: AppSize.s56,
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        decoration: isOption
            ? lang.isSelected
                ? BoxDecoration(
                    color: ColorManager.selectColor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppSize.s12)),
                  )
                : null
            : null,
        child: Row(
          spacing: AppMargin.m8,
          children: [
            SizedBox(
              width: AppSize.s32,
              child: SvgPicture.asset(lang.icon),
            ),
            Text(
              lang.name,
              style: isOption
                  ? getRegularStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s12,
                    )
                  : getMediumStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s16,
                    ),
            ).tr(),
          ],
        ),
      ),
    );
  }

  static Widget tapItem(
    BuildContext context,
    DashboardTap tap,
    Function(int id) onClick,
    {int? tapsCount, double? width}
  ) {
    return GestureDetector(
      onTap: () {
        onClick(tap.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppMargin.m16,
        children: [
          Text(
            tap.name,
            style: tap.isSelected
                ? getMediumStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s14,
                  )
                : getRegularStyle(
                    color: ColorManager.grey,
                    fontSize: FontSize.s14,
                  ),
          ).tr(),
          Container(
            height: AppSize.s1,
            width: width ??
                (MediaQuery.of(context).size.width - AppMargin.m64) / tapsCount!,
            color: tap.isSelected ? ColorManager.black : ColorManager.grey,
          ),
        ],
      ),
    );
  }

}
