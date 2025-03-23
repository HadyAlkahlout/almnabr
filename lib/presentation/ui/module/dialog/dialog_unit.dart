import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teqani/domain/model/main/unit_data.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/font_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';

class DialogUnit extends StatelessWidget {
  DialogUnit({super.key, required this.onSubmit});

  final Function(UnitData) onSubmit;

  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _workController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

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
                      AppStrings.unitID,
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
                        controller: _unitController,
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
                      AppStrings.workLevel,
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
                        controller: _workController,
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
          Text(
            AppStrings.quantity,
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
              controller: _quantityController,
              maxLines: 1,
              style: getRegularStyle(color: ColorManager.black),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: AppMargin.m16,
          ),
          Align(
            alignment: Alignment.center,
            child: OutlinedButton(
              onPressed: () {
                if(_unitController.text != '' && _workController.text != '' && _quantityController.text != ''){
                  onSubmit(createUnit());
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

  UnitData createUnit(){
    return UnitData(
      workLocation: _unitController.text,
      workLevelName: _workController.text,
      workLevel: _workController.text,
      quantity: double.parse(_quantityController.text),
    );
  }

}
