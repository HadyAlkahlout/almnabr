import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';

class ViewNoData extends StatelessWidget {
  const ViewNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: AppMargin.m8,
        children: [
          Lottie.asset(
            AnimAssets.empty,
            width: AppSize.s240,
            height: AppSize.s240,
          ),
          Text(
            AppStrings.noData,
            style: getRegularStyle(
              color: ColorManager.grey,
            ),
          ).tr(),
        ],
      ),
    );
  }
}
