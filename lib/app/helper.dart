import 'package:flutter/cupertino.dart';
import 'package:teqani/app/app.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/app/app_viewmodel.dart';
import 'package:teqani/presentation/resources/routes_manager.dart';

class Helper{

  static void handleException(String exception){

    if(exception.contains('Unauthenticated')){
      AppPreferences.logout();
      final AppViewModel appViewModel = AppViewModel.get(appNavigatorKey.currentContext);
      appViewModel.changeClientLink(false);
      Navigator.pushNamedAndRemoveUntil(
        appNavigatorKey.currentContext!,
        Routes.loginRoute,
            (_) => false,
      );
    }

  }

}