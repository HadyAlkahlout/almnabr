import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/data/responses/main/form/details/transaction_technical_assistance/transaction_technical_assistance.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/local_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/module.dart';
import 'package:teqani/presentation/ui/module/open_file.dart';

class ItemChickList extends StatelessWidget {
  const ItemChickList({super.key, required this.technical});

  final TechnicalAssistantData technical;

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
              Expanded(
                flex: 1,
                child: Text(
                  AppStrings.result,
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
                flex: 2,
                child: Text(lang == ENGLISH
                    ? technical.titleEn ?? 'N/A'
                    : technical.titleAr ?? 'N/A',
                  textAlign: TextAlign.center,
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  technical.result ?? 'N/A',
                  textAlign: TextAlign.center,
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ),
            ],
          ),
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
                child: Column(
                  spacing: AppMargin.m4,
                  children: [
                    Module.approveCard(
                      child: Text(
                        technical.status == '1' ? AppStrings.accepted : AppStrings.rejected,
                        textAlign: TextAlign.center,
                        style: getRegularStyle(
                          color: ColorManager.black,
                        ),
                      ).tr(),
                      isApproved: technical.status == '1',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: AppMargin.m4,
                  children: [
                    GestureDetector(
                      onTap: (){
                        print('File: ${technical.attachment}');
                        print('File path: ${technical.attachment!.filePath}');
                        if(technical.attachment != null){
                          OpenFile().getBase64File(technical.attachment!.filePath!);
                        }
                      },
                      child: SvgPicture.asset(IconsAssets.pdfIcon),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}