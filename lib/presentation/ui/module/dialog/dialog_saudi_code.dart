import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teqani/domain/model/main/saudi_code.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/font_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';

class DialogSaudiCode extends StatefulWidget {
  DialogSaudiCode({super.key, required this.onSubmit});

  final Function(SaudiCode) onSubmit;

  @override
  State<DialogSaudiCode> createState() => _DialogSaudiCodeState();
}

class _DialogSaudiCodeState extends State<DialogSaudiCode> {
  final TextEditingController _titleArController = TextEditingController();
  final TextEditingController _titleEnController = TextEditingController();

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.titleEn,
            style: getMediumStyle(
              color: ColorManager.black,
            ),
          ).tr(),
          const SizedBox(
            height: AppMargin.m8,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: AppMargin.m24,
            ),
            decoration: BoxDecoration(
              color: ColorManager.white,
              border: Border.all(
                width: AppSize.s1,
                color: ColorManager.lightGrey,
              ),
              borderRadius:
              BorderRadius.all(Radius.circular(AppSize.s8)),
            ),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: _titleEnController,
              maxLines: 1,
              style: getRegularStyle(color: ColorManager.black),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: AppMargin.m8,
          ),
          Text(
            AppStrings.titleAr,
            style: getMediumStyle(
              color: ColorManager.black,
            ),
          ).tr(),
          const SizedBox(
            height: AppMargin.m8,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: AppMargin.m24,
            ),
            decoration: BoxDecoration(
              color: ColorManager.white,
              border: Border.all(
                width: AppSize.s1,
                color: ColorManager.lightGrey,
              ),
              borderRadius:
              BorderRadius.all(Radius.circular(AppSize.s8)),
            ),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: _titleArController,
              maxLines: 1,
              style: getRegularStyle(color: ColorManager.black),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: AppMargin.m16,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                status = !status;
              });
            },
            child: Row(
              spacing: AppMargin.m8,
              children: [
                Text(
                  AppStrings.status,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
                Container(
                  width: AppSize.s24,
                  height: AppSize.s24,
                  decoration: BoxDecoration(
                    color: status ? ColorManager.primary : ColorManager.white,
                    border: Border.all(
                      width: AppSize.s2,
                      color: status
                          ? ColorManager.primary
                          : ColorManager.lightGrey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
                  ),
                  child: status
                      ? Center(
                          child: SvgPicture.asset(IconsAssets.checkIcon),
                        )
                      : null,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: AppMargin.m16,
          ),
          Align(
            alignment: Alignment.center,
            child: OutlinedButton(
              onPressed: () {
                if (_titleEnController.text != ''&&_titleArController.text != '') {
                  widget.onSubmit(createSaudiCode());
                }
              },
              style: OutlinedButton.styleFrom(
                side:
                    BorderSide(color: ColorManager.primary, width: AppSize.s2),
                // Change outline color
                foregroundColor: ColorManager.primary, // Change text/icon color
              ),
              child: Text(
                AppStrings.done,
                textAlign: TextAlign.center,
                style: getMediumStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s14,
                ),
              ).tr(),
            ),
          ),
        ],
      ),
    );
  }

  SaudiCode createSaudiCode() {
    return SaudiCode(
      "",
      _titleEnController.text,
      _titleArController.text,
      status ? '1' : '0',
      false,
    );
  }
}
