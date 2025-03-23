import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teqani/data/responses/main/form/previous_versions/previous_versions_response.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/module.dart';
import 'package:teqani/presentation/ui/module/open_file.dart';

class ItemRelatedForms extends StatelessWidget {
  const ItemRelatedForms({super.key, required this.form});

  final PreviousVersion form;

  @override
  Widget build(BuildContext context) {
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
                      AppStrings.units,
                      textAlign: TextAlign.center,
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                    ).tr(),
                    Text(
                      form.units ?? 'N/A',
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
                      AppStrings.workLevel,
                      textAlign: TextAlign.center,
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                    ).tr(),
                    Text(
                      form.workLevels ?? 'N/A',
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
                      AppStrings.result,
                      textAlign: TextAlign.center,
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                    ).tr(),
                    Text(
                      form.resultCode ?? 'N/A',
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ],
                ),
              ),
              if(form.pdf != null)
                Expanded(
                  child: Column(
                    spacing: AppMargin.m4,
                    children: [
                      Text(
                        AppStrings.actions,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                          color: ColorManager.black,
                        ),
                      ).tr(),
                      GestureDetector(
                        onTap: (){print('File: ${form.pdf}');
                        print('File path: ${form.pdf!.filePath}');
                        if(form.pdf!.filePath != null){
                          OpenFile().getBase64File(form.pdf!.filePath!);
                        }},
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
