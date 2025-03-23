import 'package:easy_localization/easy_localization.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/data/responses/main/dashboard/dashboard_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teqani/data/responses/main/form/previous_versions/previous_versions_response.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/font_manager.dart';
import 'package:teqani/presentation/resources/local_manager.dart';
import 'package:teqani/presentation/resources/routes_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/module.dart';

import '../open_file.dart';

class ItemFormVersion extends StatelessWidget {
  const ItemFormVersion({super.key, required this.version});

  final PreviousVersion version;

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
                      version.units ?? 'N/A',
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
                      version.workLevels ?? 'N/A',
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
                      AppStrings.type,
                      textAlign: TextAlign.center,
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                    ).tr(),
                    Text(
                      version.formType ?? 'N/A',
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ],
                ),
              ),
              if(version.pdf != null)
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
                        onTap: (){
                          print('File: ${version.pdf}');
                          print('File path: ${version.pdf!.filePath}');
                          if(version.pdf!.filePath != null){
                            OpenFile().getBase64File(version.pdf!.filePath!);
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
