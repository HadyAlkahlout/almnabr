import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/module.dart';
import 'package:teqani/presentation/ui/module/open_file.dart';

import '../../../../data/responses/main/form/details/transaction_attachments/transaction_attachments.dart';
import '../../../resources/local_manager.dart';

class ItemAttachment extends StatelessWidget {
  ItemAttachment({super.key, required this.attachment});

  Attachment attachment;

  @override
  Widget build(BuildContext context) {
    String lang = AppPreferences.getAppLanguage();
    return GestureDetector(
      onTap: (){
        _goNext(context);
      },
      child: Module.appCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppMargin.m16,
            children: [
              SvgPicture.asset(IconsAssets.pdfIcon),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang == ENGLISH
                        ? attachment.titleEn ?? 'N/A'
                        : attachment.titleAr ?? 'N/A',
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                    ),
                    Text(
                      attachment.fileExtension ?? 'N/A',
                      style: getRegularStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                AppStrings.view,
                style: getMediumStyle(
                  color: ColorManager.black,
                ),
              ).tr(),
            ],
          ),
        ),
    );
  }

  void _goNext(BuildContext context){
    print('File: ${attachment.filePath}');
    print('File path: ${attachment.filePath}');
    if(attachment.filePath != null){
      OpenFile().getBase64File(attachment.filePath!);
    }
  }
}
