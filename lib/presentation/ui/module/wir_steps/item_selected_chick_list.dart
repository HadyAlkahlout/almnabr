import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_filex/open_filex.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/domain/model/main/check_list.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/local_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/module.dart';

class ItemSelectedChickList extends StatefulWidget {
  const ItemSelectedChickList(
      {super.key, required this.checkList, required this.onEdit, required this.onDelete});

  final CheckList checkList;
  final Function(CheckList) onEdit;
  final Function(CheckList) onDelete;

  @override
  State<ItemSelectedChickList> createState() => _ItemSelectedChickListState();
}

class _ItemSelectedChickListState extends State<ItemSelectedChickList> {
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
              Visibility(
                visible: !(widget.checkList.fromApi),
                child: Expanded(
                  child: Text(
                    AppStrings.file,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: ColorManager.black,
                    ),
                  ).tr(),
                ),
              ),
            ],
          ),
          Row(
            spacing: AppMargin.m8,
            children: [
              Expanded(
                child: Text(
                  lang == ENGLISH ? widget.checkList.titleEn : widget.checkList.titleAr,
                  textAlign: TextAlign.center,
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ),
              Visibility(
                visible: !(widget.checkList.fromApi),
                child: Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (widget.checkList.file == null) {
                        _selectFile();
                      } else {
                        _openFile();
                      }
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
                        children: [
                          SvgPicture.asset(
                            widget.checkList.file != null
                                ? IconsAssets.pdfIcon
                                : IconsAssets.fileIcon,
                            color: widget.checkList.file != null ? null : ColorManager.grey,
                            width: AppSize.s24,
                            height: AppSize.s24,
                          ),
                          Text(
                            widget.checkList.file == null
                                ? AppStrings.selectFile
                                : AppStrings.openFile,
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
              ),
            ],
          ),
          Visibility(
            visible: !(widget.checkList.fromApi),
            child: Column(
              spacing: AppMargin.m8,
              children: [
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
                          GestureDetector(
                            onTap: (){
                              widget.checkList.status =
                              widget.checkList.status == '1' ? '0' : '1';
                              widget.onEdit(widget.checkList);
                            },
                            child: Container(
                              width: AppSize.s24,
                              height: AppSize.s24,
                              decoration: BoxDecoration(
                                color: widget.checkList.status == '1'
                                    ? ColorManager.primary
                                    : ColorManager.white,
                                border: Border.all(
                                  width: AppSize.s2,
                                  color: widget.checkList.status == '1'
                                      ? ColorManager.primary
                                      : ColorManager.lightGrey,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(AppSize.s8)),
                              ),
                              child: Center(
                                child: widget.checkList.status == '1'
                                    ? SvgPicture.asset(IconsAssets.checkIcon)
                                    : SvgPicture.asset(
                                        IconsAssets.xIcon,
                                        width: AppSize.s12,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          widget.onDelete(widget.checkList);
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
          Visibility(
            visible: widget.checkList.fromApi,
            child: Column(
              spacing: AppMargin.m8,
              children: [
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
                      child: Column(
                        spacing: AppMargin.m4,
                        children: [
                          GestureDetector(
                            onTap: (){
                              widget.checkList.status =
                              widget.checkList.status == '1' ? '0' : '1';
                              widget.onEdit(widget.checkList);
                            },
                            child: Container(
                              width: AppSize.s24,
                              height: AppSize.s24,
                              decoration: BoxDecoration(
                                color: widget.checkList.status == '1'
                                    ? ColorManager.primary
                                    : ColorManager.white,
                                border: Border.all(
                                  width: AppSize.s2,
                                  color: widget.checkList.status == '1'
                                      ? ColorManager.primary
                                      : ColorManager.lightGrey,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(AppSize.s8)),
                              ),
                              child: Center(
                                child: widget.checkList.status == '1'
                                    ? SvgPicture.asset(IconsAssets.checkIcon)
                                    : SvgPicture.asset(
                                        IconsAssets.xIcon,
                                        width: AppSize.s12,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (widget.checkList.file == null) {
                            _selectFile();
                          } else {
                            _openFile();
                          }
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
                            children: [
                              widget.checkList.file == null
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
                                widget.checkList.file == null
                                    ? AppStrings.selectFile
                                    : AppStrings.openFile,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      widget.checkList.file = File(result.files.single.path!);
      setState(() {});
      print('File selected: ${widget.checkList.file!.path}');
    } else {
      print('User canceled file selection');
    }
  }

  void _openFile() async{
    await OpenFilex.open(widget.checkList.file!.path);
  }
}
