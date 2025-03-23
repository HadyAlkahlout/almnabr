import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/domain/states/dashboard_states.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/item_form.dart';
import 'package:teqani/presentation/ui/module/loading_screen.dart';
import 'package:teqani/presentation/ui/module/module.dart';
import 'package:teqani/presentation/ui/module/view_no_data.dart';

import 'dashboard_viewmodel.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DashboardViewModel()..start(),
      child: BlocConsumer<DashboardViewModel, DashboardStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final DashboardViewModel viewModel = DashboardViewModel.get(context);
          return _getScreenContent(context, viewModel, state);
        },
      ),
    );
  }

  Widget _getScreenContent(BuildContext context, DashboardViewModel viewModel,
      DashboardStates state) {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: AppMargin.m32,
        ),
        child: Column(
          children: [
            Row(
              spacing: AppMargin.m8,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p8,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(AppSize.s56),
                      border: Border.all(
                        width: AppSize.s1,
                        color: ColorManager.lightGrey,
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          IconsAssets.searchIcon,
                          width: AppSize.s16,
                          height: AppSize.s16,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: viewModel.searchController,
                            style: getRegularStyle(color: ColorManager.black),
                            decoration: InputDecoration(
                              hintText: AppStrings.search.tr(),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(
                    AppPadding.p12,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(AppSize.s56),
                    border: Border.all(
                      width: AppSize.s1,
                      color: ColorManager.lightGrey,
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      IconsAssets.filterIcon,
                      width: AppSize.s20,
                      height: AppSize.s20,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    viewModel.refresh();
                  },
                  child: Container(
                    padding: EdgeInsets.all(
                      AppPadding.p12,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(AppSize.s56),
                      border: Border.all(
                        width: AppSize.s1,
                        color: ColorManager.lightGrey,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        IconsAssets.refreshIcon,
                        width: AppSize.s20,
                        height: AppSize.s20,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppMargin.m16,
            ),
            SizedBox(
              width: double.infinity,
              height: AppSize.s40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) =>
                    Module.tapItem(
                  context,
                  viewModel.taps[index],
                  (id) {
                    // viewModel.changeTap(id);
                  },
                  tapsCount: viewModel.taps.length,
                ),
                itemCount: viewModel.taps.length,
              ),
            ),
            state is DashboardDataLoadingState
                ? LoadingScreen()
                : state is DashboardDataErrorState
                    ? ViewNoData()
                    : viewModel.forms.isEmpty
                        ? ViewNoData()
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            ItemForm(
                                      form: viewModel.forms[index],
                                    ),
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            SizedBox(
                                      height: AppMargin.m16,
                                    ),
                                    itemCount: viewModel.forms.length,
                                  ),
                                  const SizedBox(
                                    height: AppMargin.m8,
                                  ),
                                  Visibility(
                                    visible: viewModel.isMore,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        viewModel.addPage();
                                      },
                                      child: Text(
                                        AppStrings.showMore,
                                        style: getRegularStyle(
                                          color: ColorManager.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppMargin.m16,
                                  ),
                                ],
                              ),
                            ),
                          ),
          ],
        ),
      ),
    );
  }
}
