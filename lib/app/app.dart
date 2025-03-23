import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:teqani/app/app_viewmodel.dart';
import 'package:teqani/domain/states/app_states.dart';
import 'package:teqani/presentation/resources/routes_manager.dart';
import 'package:teqani/presentation/resources/theme_manager.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp._internal(); // Private named constructor

  static const MyApp instance =
      MyApp._internal(); // Single instance -- Singleton

  factory MyApp() => instance; // Factory for the class instance

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppViewModel(),
      child: BlocConsumer<AppViewModel, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final AppViewModel viewModel = AppViewModel.get(context);
          return GraphQLProvider(
            client: viewModel.isAuth
                ? viewModel.getAuthClient()
                : viewModel.getMainClient(),
            child: MaterialApp(
              navigatorKey: appNavigatorKey,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              onGenerateRoute: RouteGenerator.getRoute,
              initialRoute: Routes.splashRoute,
              theme: getApplicationTheme(),
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}

