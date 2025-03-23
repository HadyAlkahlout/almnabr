import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:teqani/domain/states/home_states.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/font_manager.dart';
import 'package:teqani/presentation/resources/routes_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/main/home/home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeViewModel()..start(context),
      child: BlocConsumer<HomeViewModel, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final HomeViewModel viewModel = HomeViewModel.get(context);
          return _getScreenContent(context, viewModel);
        },
      ),
    );
  }

  Widget _getScreenContent(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorManager.white,
      drawer: _getMainDrawer(context, viewModel),
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          top: AppPadding.p64,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Builder(builder: (context) {
                  return IconButton(
                    padding: EdgeInsetsDirectional.only(
                      start: AppPadding.p32,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: SvgPicture.asset(IconsAssets.menuIcon),
                  );
                }),
                Expanded(
                  child: Text(
                    _getScreenTitle(viewModel.currentIndex),
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s18,
                    ),
                  ).tr(),
                ),
              ],
            ),
            const SizedBox(
              height: AppMargin.m16,
            ),
            RouteGenerator.getMainScreen(viewModel.currentIndex),
          ],
        ),
      ),
    );
  }

  Widget _getMainDrawer(BuildContext context, HomeViewModel viewModel) {
    return Container(
      height: double.infinity,
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(AppSize.s16),
          bottomEnd: Radius.circular(AppSize.s16),
        ),
      ),
      padding: EdgeInsetsDirectional.only(
        top: AppPadding.p64,
        bottom: AppPadding.p56,
        start: AppPadding.p24,
        end: AppPadding.p24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ImageAssets.logo,
            width: AppSize.s80,
            height: AppSize.s80,
          ),
          const SizedBox(
            height: AppMargin.m32,
          ),
          Row(
            spacing: AppMargin.m16,
            children: [
              CircleAvatar(
                radius: AppSize.s32,
                backgroundColor: ColorManager.grey,
                foregroundImage: AssetImage(ImageAssets.avatarPlaceholder),
              ),
              Text(
                viewModel.userData.name,
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s14,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppMargin.m40,
          ),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Text(
              AppStrings.contacts,
              style: getBoldStyle(
                color: ColorManager.black,
                fontSize: FontSize.s14,
              ),
            ).tr(),
          ),
          const SizedBox(
            height: AppMargin.m16,
          ),
          Row(
            spacing: AppMargin.m8,
            children: [
              const SizedBox(
                width: AppMargin.m4,
              ),
              SvgPicture.asset(IconsAssets.phoneIcon),
              Text(
                viewModel.userData.mobile,
                style: getRegularStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s12,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppMargin.m12,
          ),
          Row(
            spacing: AppMargin.m8,
            children: [
              const SizedBox(
                width: AppMargin.m4,
              ),
              SvgPicture.asset(IconsAssets.mailIcon),
              Text(
                viewModel.userData.email,
                style: getRegularStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s12,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppMargin.m40,
          ),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Text(
              AppStrings.pages,
              style: getBoldStyle(
                color: ColorManager.black,
                fontSize: FontSize.s14,
              ),
            ).tr(),
          ),
          const SizedBox(
            height: AppMargin.m16,
          ),
          Builder(builder: (context) {
            return InkWell(
              onTap: () {
                if (viewModel.currentIndex != Routes.dashboardIndex) {
                  viewModel.changePageIndex(Routes.dashboardIndex);
                  Scaffold.of(context).closeDrawer();
                }
              },
              child: Container(
                padding: EdgeInsets.all(AppPadding.p8),
                decoration: viewModel.currentIndex == Routes.dashboardIndex
                    ? BoxDecoration(
                        color: ColorManager.primaryOpacity15,
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.s8)),
                      )
                    : null,
                child: Row(
                  spacing: AppMargin.m8,
                  children: [
                    SvgPicture.asset(IconsAssets.homeIcon),
                    Text(
                      AppStrings.dashboard,
                      style: getRegularStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s12,
                      ),
                    ).tr(),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(
            height: AppMargin.m4,
          ),
          Builder(builder: (context) {
            return InkWell(
              onTap: () {
                if (viewModel.currentIndex != Routes.settingIndex) {
                  viewModel.changePageIndex(Routes.settingIndex);
                  Scaffold.of(context).closeDrawer();
                }
              },
              child: Container(
                padding: EdgeInsets.all(AppPadding.p8),
                decoration: viewModel.currentIndex == Routes.settingIndex
                    ? BoxDecoration(
                        color: ColorManager.primaryOpacity15,
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.s8)),
                      )
                    : null,
                child: Row(
                  spacing: AppMargin.m8,
                  children: [
                    SvgPicture.asset(IconsAssets.settingIcon),
                    Text(
                      AppStrings.settings,
                      style: getRegularStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s12,
                      ),
                    ).tr(),
                  ],
                ),
              ),
            );
          }),
          Spacer(),
          Builder(builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).closeDrawer();
                _getOut(viewModel);
              },
              child: Row(
                spacing: AppMargin.m8,
                children: [
                  SvgPicture.asset(IconsAssets.logoutIcon),
                  Text(
                    AppStrings.logout,
                    style: getMediumStyle(
                      color: ColorManager.error,
                      fontSize: FontSize.s14,
                    ),
                  ).tr(),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _getScreenTitle(int index) {
    switch (index) {
      case Routes.dashboardIndex:
        return AppStrings.dashboard;
      case Routes.settingIndex:
        return AppStrings.settings;
      default:
        return AppStrings.dashboard;
    }
  }

  void _getOut(HomeViewModel viewModel) {
    viewModel.logout(_scaffoldKey.currentContext!);
  }
}
