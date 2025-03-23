import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/app/app_viewmodel.dart';
import 'package:teqani/domain/model/auth/UserData.dart';
import 'package:teqani/domain/states/home_states.dart';
import 'package:teqani/presentation/resources/routes_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/ui/module/module.dart';

class HomeViewModel extends Cubit<HomeStates> {
  HomeViewModel() : super(HomeInitialStates());

  static HomeViewModel get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  UserData userData = UserData();

  void start(BuildContext context) {
    final AppViewModel appViewModel = AppViewModel.get(context);
    appViewModel.changeClientLink(true);
    getUserData();
  }

  changePageIndex(int index) {
    currentIndex = index;
    emit(HomeChangePageState());
  }

  getUserData() {
    userData.name = AppPreferences.getUserName();
    userData.email = AppPreferences.getUserEmail();
    userData.mobile = AppPreferences.getUserMobile();
  }

  logout(BuildContext context) {
    Module.showAlert(
      context,
      AppStrings.logout,
      AppStrings.alertLogoutMessage,
      () {
        AppPreferences.logout();
        final AppViewModel appViewModel = AppViewModel.get(context);
        appViewModel.changeClientLink(false);
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.loginRoute,
              (_) => false,
        );
      },
      null,
    );
  }
}
