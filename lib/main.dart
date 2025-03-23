import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/local_manager.dart';

import 'app/app.dart';
import 'domain/states/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();


  await EasyLocalization.ensureInitialized();
  await AppPreferences.init();

  Bloc.observer = MyBlocObserver();

  runApp(
    EasyLocalization(
      supportedLocales: [englishLocal, arabicLocal],
      path: TRANSLATION_PATH,
      fallbackLocale: englishLocal,
      child: MyApp(),
    ),
  );
}
