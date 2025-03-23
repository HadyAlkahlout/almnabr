import 'package:easy_localization/easy_localization.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/data/responses/main/dashboard/dashboard_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/font_manager.dart';
import 'package:teqani/presentation/resources/local_manager.dart';
import 'package:teqani/presentation/resources/routes_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/module.dart';

class ItemForm extends StatefulWidget {
  const ItemForm({super.key, required this.form});

  final AppForm form;

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  MoreItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    String lang = AppPreferences.getAppLanguage();
    return Column(
      spacing: AppMargin.m8,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.form.id.toString(),
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s14,
                ),
              ),
            ),
            // Container(
            //   width: AppSize.s32,
            //   height: AppSize.s32,
            //   decoration: BoxDecoration(
            //     color: ColorManager.white,
            //     borderRadius: BorderRadius.circular(AppSize.s8),
            //     border: Border.all(
            //       width: AppSize.s1,
            //       color: ColorManager.lightGrey,
            //     ),
            //   ),
            //   child: IconButton(
            //     onPressed: () {},
            //     icon: SvgPicture.asset(IconsAssets.arrowDownIcon),
            //   ),
            // ),
            PopupMenuButton<MoreItem>(
              initialValue: selectedItem,
              icon: SvgPicture.asset(IconsAssets.moreIcon),
              color: ColorManager.white,
              onSelected: (MoreItem item) {
                setState(() {
                  selectedItem = item;
                });
                _goNext(context);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<MoreItem>>[
                PopupMenuItem<MoreItem>(
                  value: MoreItem.view,
                  child: Text(
                    AppStrings.view,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s12,
                    ),
                  ).tr(),
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: (){
            _goNext(context);
          },
          child: Module.appCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.id,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s12,
                        ),
                      ).tr(),
                    ),
                    Expanded(
                      child: Text(
                        AppStrings.activity,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s12,
                        ),
                      ).tr(),
                    ),
                    Expanded(
                      child: Text(
                        AppStrings.units,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s12,
                        ),
                      ).tr(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppMargin.m4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.form.id.toString(),
                        textAlign: TextAlign.center,
                        style: getLightStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.form.activity == null
                            ? ''
                            : lang == LanguageType.ENGLISH.getValue()
                                ? widget.form.activity!.titleEn ?? ''
                                : widget.form.activity!.titleAr ?? '',
                        textAlign: TextAlign.center,
                        style: getLightStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.form.units ?? '',
                        textAlign: TextAlign.center,
                        style: getLightStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppMargin.m8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.lastStep,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s12,
                        ),
                      ).tr(),
                    ),
                    Expanded(
                      child: Text(
                        AppStrings.evaluationResult,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s12,
                        ),
                      ).tr(),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppMargin.m4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.form.lastStepNameLabel ?? '',
                        textAlign: TextAlign.center,
                        style: getLightStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.form.evaluationResult ?? '_',
                        textAlign: TextAlign.center,
                        style: getLightStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _goNext(BuildContext context){
    Navigator.pushNamed(
      context,
      Routes.wirRoute,
      arguments: widget.form,
    );
  }

}

enum MoreItem { view }
