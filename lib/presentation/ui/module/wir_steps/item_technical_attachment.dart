import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/data/responses/main/form/details/transaction_attachments/transaction_attachments.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/local_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/module.dart';
import 'package:teqani/presentation/ui/module/open_file.dart';

class ItemTechnicalAttachment extends StatelessWidget {
  const ItemTechnicalAttachment({super.key, required this.attach});

  final Attachment attach;

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
                child: Text(
                  AppStrings.title,
                  textAlign: TextAlign.center,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
              ),
              Expanded(
                child: Text(
                  AppStrings.createdAt,
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
                child: Text(
                  lang == ENGLISH
                      ? attach.titleEn ?? 'N/A'
                      : attach.titleAr ?? 'N/A',
                  textAlign: TextAlign.center,
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  attach.createdAt ?? 'N/A',
                  textAlign: TextAlign.center,
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  spacing: AppMargin.m4,
                  children: [
                    GestureDetector(
                      onTap: (){
                        print('File path: ${attach.filePath}');
                        if(attach.filePath != null){
                          OpenFile().getBase64File(attach.filePath!);
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

  void _goNext(String filePath) async {
    print('Oping file..');
    await OpenFilex.open(filePath);
  }
}
