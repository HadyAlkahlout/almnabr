import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teqani/domain/model/main/attachment_data.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/font_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';

class DialogAttachment extends StatefulWidget {
  DialogAttachment({super.key, required this.onSubmit});

  final Function(AttachmentData) onSubmit;

  @override
  State<DialogAttachment> createState() => _DialogAttachmentState();
}

class _DialogAttachmentState extends State<DialogAttachment> {
  final TextEditingController _titleArController = TextEditingController();

  final TextEditingController _titleEnController = TextEditingController();

  bool attach = false;
  File? file;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
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
                  ],
                ),
              ),
              Expanded(
                child: Column(
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
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppMargin.m16,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      AppStrings.file,
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                      textAlign: TextAlign.center,
                    ).tr(),
                    const SizedBox(
                      height: AppMargin.m8,
                    ),
                    GestureDetector(
                      onTap: (){
                        _selectFile();
                      },
                      child: Container(
                        padding: EdgeInsets.all(AppPadding.p8),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(AppSize.s8)),
                        ),
                        child: Row(
                          spacing: AppMargin.m8,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            file == null
                                ? SvgPicture.asset(
                              IconsAssets.fileIcon,
                              color: ColorManager.grey,
                              width: AppSize.s24,
                              height: AppSize.s24,
                            )
                                : SvgPicture.asset(
                              IconsAssets.pdfIcon,
                              width: AppSize.s24,
                              height: AppSize.s24,
                            ),
                            Text(
                              AppStrings.selectFile,
                              textAlign: TextAlign.center,
                              style: getRegularStyle(
                                color: ColorManager.grey,
                              ),
                            ).tr(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      AppStrings.attachWithPdf,
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                      textAlign: TextAlign.center,
                    ).tr(),
                    const SizedBox(
                      height: AppMargin.m16,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          attach = !attach;
                        });
                      },
                      child: Container(
                        width: AppSize.s24,
                        height: AppSize.s24,
                        decoration: BoxDecoration(
                          color: attach ? ColorManager.primary : ColorManager.white,
                          border: Border.all(
                            width: AppSize.s2,
                            color: attach
                                ? ColorManager.primary
                                : ColorManager.lightGrey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
                        ),
                        child: attach
                            ? Center(
                          child: SvgPicture.asset(IconsAssets.checkIcon),
                        )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppMargin.m16,
          ),
          Align(
            alignment: Alignment.center,
            child: OutlinedButton(
              onPressed: () {
                if(_titleArController.text != '' && _titleEnController.text != '' && file != null){
                  widget.onSubmit(createAttachment());
                }
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: ColorManager.primary, width: AppSize.s2), // Change outline color
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

  AttachmentData createAttachment(){
    return AttachmentData(
      titleAr: _titleArController.text,
      titleEn: _titleEnController.text,
      file: file!,
      attach: attach ? 1 : 0,
    );
  }

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
      print('File selected: ${file!.path}');
      setState(() {});
    } else {
      print('User canceled file selection');
    }
  }
}
