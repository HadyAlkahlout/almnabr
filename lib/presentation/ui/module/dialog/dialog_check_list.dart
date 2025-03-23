import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teqani/domain/model/main/check_list.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/font_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';

class DialogCheckList extends StatefulWidget {
  const DialogCheckList({super.key, required this.onSubmit});

  final Function(CheckList) onSubmit;

  @override
  State<DialogCheckList> createState() => _DialogCheckListState();
}

class _DialogCheckListState extends State<DialogCheckList> {
  final TextEditingController _titleArController = TextEditingController();
  final TextEditingController _titleEnController = TextEditingController();

  bool status = false;

  File? file;

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
            height: AppSize.s48,
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
              maxLines: 3,
              style: getRegularStyle(color: ColorManager.black),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: AppMargin.m16,
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
            height: AppSize.s48,
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
              maxLines: 3,
              style: getRegularStyle(color: ColorManager.black),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: AppMargin.m16,
          ),
          Row(
            spacing: AppMargin.m16,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      AppStrings.file,
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                    ).tr(),
                    const SizedBox(
                      height: AppMargin.m8,
                    ),
                    GestureDetector(
                      onTap: (){_selectFile();},
                      child: Container(
                        padding: EdgeInsets.all(AppPadding.p8),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(AppSize.s8)),
                          border: Border.all(
                            width: AppSize.s1,
                            color: ColorManager.lightGrey,
                          ),
                        ),
                        child: Row(
                          spacing: AppMargin.m8,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              file != null
                                  ? IconsAssets.pdfIcon
                                  : IconsAssets.fileIcon,
                              color: file != null ? null : ColorManager.grey,
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
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      status = !status;
                    });
                  },
                  child: Row(
                    spacing: AppMargin.m8,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                if (_titleEnController.text != ''&&_titleArController.text != '') {
                  widget.onSubmit(createCheckList());
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

  CheckList createCheckList() {
    return CheckList(
      "",
      _titleEnController.text,
      _titleArController.text,
      file,
      status ? '1' : '0',
      false,
    );
  }

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
      setState(() {});
      print('File selected: ${file!.path}');
    } else {
      print('User canceled file selection');
    }
  }
}
