import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/domain/model/main/language.dart';
import 'package:teqani/domain/states/settings_states.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/local_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';

class SettingsViewModel extends Cubit<SettingsStates> {
  SettingsViewModel() : super(SettingsInitialStates());

  static SettingsViewModel get(context) => BlocProvider.of(context);
  String currentLang = '';
  List<Language> languages = [];
  bool isLangOptionsOpen = false;

  void start() {
    languages = [
      Language(IconsAssets.arabicIcon, AppStrings.arabic, false),
      Language(IconsAssets.englishIcon, AppStrings.english, true),
    ];
    getAppLanguage();
  }

  void changeOptionsState() {
    isLangOptionsOpen = !isLangOptionsOpen;
    emit(SettingsChangeOptionsState());
  }

  void changeLanguage(BuildContext context, String lang) {
    if(lang != currentLang){
      context.setLocale(Locale(lang));
      AppPreferences.setLanguageChanged();
      getAppLanguage();
      emit(SettingsChangeLanguageState());
    }
  }

  void getAppLanguage() {
    String lang = AppPreferences.getAppLanguage();
    currentLang = lang;
    languages[lang == ARABIC ? 0 : 1].isSelected = true;
    languages[lang == ARABIC ? 1 : 0].isSelected = false;
    emit(state);
  }

}
