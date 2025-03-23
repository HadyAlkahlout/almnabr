import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teqani/domain/states/settings_states.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/font_manager.dart';
import 'package:teqani/presentation/resources/local_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/module.dart';

import 'settngs_viewmodel.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SettingsViewModel()..start(),
      child: BlocConsumer<SettingsViewModel, SettingsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final SettingsViewModel viewModel = SettingsViewModel.get(context);
          return _getScreenContent(viewModel);
        },
      ),
    );
  }

  Widget _getScreenContent(SettingsViewModel viewModel){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: AppMargin.m32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.language,
            style: getRegularStyle(
              color: ColorManager.black,
              fontSize: FontSize.s16,
            ),
          ).tr(),
          const SizedBox(
            height: AppMargin.m16,
          ),
          InkWell(
            onTap: () {
              viewModel.changeOptionsState();
            },
            borderRadius: BorderRadius.circular(AppSize.s8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s8),
                border: Border.all(
                  width: AppSize.s05,
                  color: ColorManager.lightGrey,
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p8,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Module.languageItem(
                        viewModel.currentLang == ENGLISH
                            ? viewModel.languages[1]
                            : viewModel.languages[0],
                        false),
                  ),
                  SvgPicture.asset(viewModel.isLangOptionsOpen
                      ? IconsAssets.arrowTopIcon
                      : IconsAssets.arrowDownIcon)
                ],
              ),
            ),
          ),
          const SizedBox(
            height: AppMargin.m8,
          ),
          Visibility(
            visible: viewModel.isLangOptionsOpen,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s8),
                border: Border.all(
                  width: AppSize.s05,
                  color: ColorManager.lightGrey,
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p8,
                vertical: AppPadding.p12,
              ),
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) =>
                    Module.languageItem(
                      viewModel.languages[index],
                      true,
                      onClick: () {
                        viewModel.changeLanguage(
                            context,
                            viewModel.languages[index].name ==
                                AppStrings.arabic
                                ? ARABIC
                                : ENGLISH);
                      },
                    ),
                itemCount: viewModel.languages.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
