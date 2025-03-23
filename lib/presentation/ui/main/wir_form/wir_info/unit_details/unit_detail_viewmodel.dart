import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/data/responses/main/form/details/form_details_response.dart';
import 'package:teqani/data/responses/main/form/details/transaction_attachments/transaction_attachments.dart';
import 'package:teqani/domain/model/main/dashboard_tap.dart';
import 'package:teqani/presentation/resources/local_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/ui/module/open_file.dart';

class UnitDetailViewModel extends Cubit<UnitDetailStates> {
  UnitDetailViewModel() : super(UnitDetailInitialStates());

  static UnitDetailViewModel get(context) => BlocProvider.of(context);

  FormDetailsResponse? formDetailsResponse;
  String _lang = '';
  List<String> units = [];
  List<DashboardTap> taps = [];
  String unit = '';
  int currentTap = 0;

  void start(FormDetailsResponse formDetails) {
    _lang = AppPreferences.getAppLanguage();
    formDetailsResponse = formDetails;
    if (formDetailsResponse!.transactionUnitsWorkLocations!.data != null) {
      print('lengh: ${formDetailsResponse!.transactionUnitsWorkLocations!.data!.length}');
      for (var unit in formDetailsResponse!.transactionUnitsWorkLocations!.data!) {
        units.add(unit.unitId ?? '');
      }
    }
    taps = [
      DashboardTap(0, AppStrings.attachments, true),
      DashboardTap(1, AppStrings.formVersions, false),
      DashboardTap(2, AppStrings.relatedForms, false),
    ];
    unit = units.isEmpty ? '' : units.first;
  }

  void changeTap(int id) {
    if (currentTap != id) {
      currentTap = id;
      for (var tap in taps) {
        tap.isSelected = tap.id == id;
      }
      emit(UnitDetailChangeTapStates());
    }
  }

  void changeUnit(String? uId) {
    if (uId != null && unit != uId) {
      unit = uId;
      emit(UnitDetailChangeUnitStates());
    }
  }

  void openFile() {
    OpenFile().openFile(
        formDetailsResponse!.transactionDetails!.data![0].id.toString());
  }

  String getWorkLevelName(){
    for (var unit in formDetailsResponse!.transactionUnitsWorkLocations!.data!){
      if(unit.unitId == this.unit){
        return _lang == ENGLISH
            ? unit.worklevel!.titleEn ?? 'N/A'
            : unit.worklevel!.titleAr ?? 'N/A';
      }
    }
    return 'N/A';
  }

  String getWorkLevelID(){
    for (var unit in formDetailsResponse!.transactionUnitsWorkLocations!.data!){
      if(unit.unitId == this.unit){
        return unit.workLevelId?? '0';
      }
    }
    return '0';
  }

  String getQuantity(){
    for (var unit in formDetailsResponse!.transactionUnitsWorkLocations!.data!){
      if(unit.unitId == this.unit){
        return unit.workLevelQuantity ?? 'N/A';
      }
    }
    return 'N/A';
  }

  List<Attachment> getAttachments(){
    for (var unit in formDetailsResponse!.transactionUnitsWorkLocations!.data!){
      if(unit.unitId == this.unit){
        return unit.attachment ?? [];
      }
    }
    return [];
  }
}

abstract class UnitDetailStates {}

class UnitDetailInitialStates extends UnitDetailStates {}

class UnitDetailChangeTapStates extends UnitDetailStates {}

class UnitDetailChangeUnitStates extends UnitDetailStates {}
