import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/data/responses/main/form/details/transaction_technical_assistance/transaction_technical_assistance.dart';
import 'package:teqani/domain/model/main/unit_data.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/local_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/module.dart';

class ItemUnit extends StatelessWidget {
  ItemUnit({
    super.key,
    required this.unit,
    required this.formType,
    required this.onDelete,
  });

  final UnitData unit;
  final int formType;
  final Function(UnitData) onDelete;

  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _quantityController.text = unit.quantity.toString();
    _quantityController.addListener((){
      print(_quantityController.text);
      if(_quantityController.text.isNotEmpty){
        unit.quantity = double.parse(_quantityController.text);
      }
    });
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
                    AppStrings.unitID,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: ColorManager.black,
                    ),
                  ).tr(),
                ),
                Expanded(
                  child: Text(
                    AppStrings.workLevel,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: ColorManager.black,
                    ),
                  ).tr(),
                ),
                Expanded(
                  child: Text(
                    AppStrings.quantity,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: ColorManager.black,
                    ),
                  ).tr(),
                ),
                Visibility(
                  visible: formType == 0,
                  child: Expanded(
                    child: Text(
                      AppStrings.actions,
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
              children: [
                Expanded(
                  child: Text(
                    unit.workLocation,
                    textAlign: TextAlign.center,
                    style: getRegularStyle(
                      color: ColorManager.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    unit.workLevelName,
                    textAlign: TextAlign.center,
                    style: getRegularStyle(
                      color: ColorManager.black,
                    ),
                  ),
                ),
                Expanded(
                  child: formType == 1
                      ? Container(
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
                  )
                      : Text(
                    unit.quantity.toString(),
                    textAlign: TextAlign.center,
                    style: getRegularStyle(
                      color: ColorManager.black,
                    ),
                  ),
                ),
                Visibility(
                  visible: formType == 0,
                  child: Expanded(
                    child: GestureDetector(
                      onTap: () {
                        onDelete(unit);
                      },
                      child: SvgPicture.asset(
                        IconsAssets.deleteIcon,
                        color: ColorManager.error,
                      ),
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
}
