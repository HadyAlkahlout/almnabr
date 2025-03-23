import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_filex/open_filex.dart';
import 'package:teqani/domain/model/main/attachment_data.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/module.dart';

class ItemStepAttach extends StatelessWidget {
  const ItemStepAttach({super.key, required this.attachmentData, required this.onDelete});

  final AttachmentData attachmentData;
  final Function(AttachmentData) onDelete;

  @override
  Widget build(BuildContext context) {
    return Module.appCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p8,
        ),
        child: Column(
          spacing: AppMargin.m16,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppStrings.titleAr,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: ColorManager.black,
                    ),
                  ).tr(),
                ),
                Expanded(
                  child: Text(
                    AppStrings.titleEn,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: ColorManager.black,
                    ),
                  ).tr(),
                ),
                Expanded(
                  child: Text(
                    AppStrings.file,
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
                    attachmentData.titleAr,
                    textAlign: TextAlign.center,
                    style: getRegularStyle(
                      color: ColorManager.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    attachmentData.titleEn,
                    textAlign: TextAlign.center,
                    style: getRegularStyle(
                      color: ColorManager.black,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      _openFile();
                    },
                    child: Container(
                      padding: EdgeInsets.all(AppPadding.p8),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
                      ),
                      child: Row(
                        spacing: AppMargin.m8,
                        children: [
                          SvgPicture.asset(
                            IconsAssets.pdfIcon,
                            width: AppSize.s24,
                            height: AppSize.s24,
                          ),
                          Text(
                            AppStrings.openFile,
                            textAlign: TextAlign.center,
                            style: getRegularStyle(
                              color: ColorManager.grey,
                            ),
                          ).tr(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppStrings.attachWithPdf,
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
                    attachmentData.attach.toString(),
                    textAlign: TextAlign.center,
                    style: getRegularStyle(
                      color: ColorManager.black,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      onDelete(attachmentData);
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
    );
  }

  void _openFile() async {
    await OpenFilex.open(attachmentData.file.path);
  }
}
