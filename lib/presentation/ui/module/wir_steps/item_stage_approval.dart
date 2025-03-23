import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/data/responses/main/form/details/transaction_stages/transaction_stages.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/local_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/module.dart';

class ItemStageApproval extends StatelessWidget {
  const ItemStageApproval({super.key, required this.stage});

  final StageData stage;

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
                child: Column(
                  spacing: AppMargin.m4,
                  children: [
                    Text(
                      AppStrings.name,
                      textAlign: TextAlign.center,
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                    ).tr(),
                    Text(
                      stage.writer!.name ?? 'N/A',
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: AppMargin.m4,
                  children: [
                    Text(
                      AppStrings.position,
                      textAlign: TextAlign.center,
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                    ).tr(),
                    Text(
                      lang == ENGLISH
                      ? stage.position!.titleEn ?? 'N/A'
                      : stage.position!.titleAr ?? 'N/A',
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  spacing: AppMargin.m4,
                  children: [
                    Text(
                      AppStrings.signatureDate,
                      textAlign: TextAlign.center,
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                    ).tr(),
                    Text(
                      stage.createAt ?? 'N/A',
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: AppMargin.m4,
                  children: [
                    Text(
                      AppStrings.status,
                      textAlign: TextAlign.center,
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                    ).tr(),
                    Module.approveCard(
                      child: Text(
                        stage.stageType == 'A' ? AppStrings.approved : AppStrings.rejected,
                        textAlign: TextAlign.center,
                        style: getRegularStyle(
                          color: ColorManager.black,
                        ),
                      ).tr(),
                      isApproved: stage.stageType == 'A',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  spacing: AppMargin.m4,
                  children: [
                    Text(
                      AppStrings.comment,
                      textAlign: TextAlign.center,
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                    ).tr(),
                    Text(
                      stage.stageText ?? 'N/A',
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                        color: ColorManager.black,
                      ),
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