import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:teqani/app/helper.dart';
import 'package:teqani/data/network/app_api.dart';
import 'package:teqani/data/network/app_requests/main_requests.dart';
import 'package:teqani/data/responses/main/dashboard/dashboard_response.dart';
import 'package:teqani/data/responses/main/form/details/form_details_response.dart';
import 'package:teqani/data/responses/main/form/details/transaction_wir_action_buttons/transaction_wir_action_buttons.dart';
import 'package:teqani/domain/model/main/dashboard_tap.dart';
import 'package:teqani/domain/states/forms/wir/wir_form_states.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';

class WIRFormViewModel extends Cubit<WIRFormStates> {
  WIRFormViewModel() : super(WIRFormInitialStates());

  static WIRFormViewModel get(context) => BlocProvider.of(context);
  final GraphQLClient _client = AppServiceClient.instance.getAppClient(false);
  FormDetailsResponse? formDetailsResponse;
  final TextEditingController stepsController = TextEditingController();
  AppForm? wirForm;
  int currentTap = 0;
  int formStep = 0;
  String selectedStep = AppStrings.selectStep;
  bool isMore = false;
  int wirFromType = 0;

  List<DashboardTap> taps = [];
  List<DashboardTap> steps = [];

  void start(BuildContext context, AppForm form) {
    wirForm = form;
    taps = [
      DashboardTap(0, AppStrings.workDetails, true),
      DashboardTap(1, AppStrings.unitDetails, false),
    ];
    steps = [
      DashboardTap(2, AppStrings.contractorTeamApproval, false),
      DashboardTap(3, AppStrings.contractorManagerApproval, false),
      DashboardTap(4, AppStrings.contractorQAQCApproval, false),
      DashboardTap(5, AppStrings.recipientVerification, false),
      DashboardTap(6, AppStrings.technicalAssistant, false),
      DashboardTap(7, AppStrings.soilTest, false),
      DashboardTap(8, AppStrings.specialApproval, false),
      DashboardTap(9, AppStrings.authorizedPositions, false),
      DashboardTap(10, AppStrings.consultantManager, false),
      DashboardTap(11, AppStrings.ownerRepresentative, false),
      DashboardTap(12, AppStrings.PMCGroup, false),
      DashboardTap(13, AppStrings.resultReceiving, false),
      DashboardTap(14, AppStrings.notes, false),
      DashboardTap(15, AppStrings.history, false),
    ];
    _getForm(form);
  }

  void changeTap(int id) {
    if (currentTap != id) {
      currentTap = id;
      for (var tap in taps) {
        tap.isSelected = tap.id == id;
        if (tap.id == id) {
          selectedStep = AppStrings.selectStep;
        }
      }
      for (var tap in steps) {
        tap.isSelected = tap.id == id;
        if (tap.id == id) {
          selectedStep = tap.name;
        }
      }
      emit(WIRFormChangeTapState());
    }
  }

  void _openFormStep(String step) {
    switch (step) {
      case 'contractor_team_approval':
        {
          formStep = 2;
          selectedStep = AppStrings.contractorTeamApproval;
          changeTap(2);
        }
      case 'contractor_manager_approval':
        {
          formStep = 3;
          selectedStep = AppStrings.contractorManagerApproval;
          changeTap(3);
        }
      case 'contractor_qaqc_approval':
        {
          formStep = 4;
          selectedStep = AppStrings.contractorQAQCApproval;
          changeTap(4);
        }
      case 'recipient_verification':
        {
          formStep = 5;
          selectedStep = AppStrings.recipientVerification;
          changeTap(5);
        }
      case 'technical_assistant':
        {
          formStep = 6;
          selectedStep = AppStrings.technicalAssistant;
          changeTap(6);
        }
      case 'soil_test_witness_result':
        {
          formStep = 7;
          selectedStep = AppStrings.soilTest;
          changeTap(7);
        }
      case 'special_approval':
        {
          formStep = 8;
          selectedStep = AppStrings.specialApproveRequired;
          changeTap(8);
        }
      case 'authorized_positions_approval':
        {
          formStep = 9;
          selectedStep = AppStrings.authorizedPositions;
          changeTap(9);
        }
      case 'manager_approval':
        {
          formStep = 10;
          selectedStep = AppStrings.consultantManager;
          changeTap(10);
        }
      case 'owners_representative':
        {
          formStep = 11;
          selectedStep = AppStrings.ownerRepresentative;
          changeTap(11);
        }
      case 'pmc_approval':
        {
          formStep = 12;
          selectedStep = AppStrings.PMCGroup;
          changeTap(12);
        }
      case 'result_receiving' || 'completed':
        {
          formStep = 13;
          selectedStep = AppStrings.resultReceiving;
          changeTap(13);
        }
    }
  }

  void _getForm(AppForm form) async {
    emit(WIRFormLoadingState());
    final QueryOptions options = QueryOptions(
      document: gql(MainRequests.formQuery),
      fetchPolicy: FetchPolicy.networkOnly,
      variables: {
        "transaction_id": "${form.id}",
        "project_id": "${form.projectId}"
      },
    );

    _client.cache.store.reset();
    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      Helper.handleException(result.exception.toString());
      emit(WIRFormErrorState());
    } else {
      print(result.data);
      _formResult(result.data ?? {});
      emit(WIRFormSuccessState());
    }
  }

  void _formResult(Map<String, dynamic> result) {
    formDetailsResponse = FormDetailsResponse.fromJson(result);
    if (formDetailsResponse!.transactionDetails != null) {
      print('Last Step: ${formDetailsResponse!.transactionDetails!.data![0].lastStepName}');
      _openFormStep(
          formDetailsResponse!.transactionDetails!.data![0].lastStepName ?? '');
      String formType =
          formDetailsResponse!.transactionDetails!.data![0].formType ?? '';
      for (var data
          in formDetailsResponse!.transactionWIRActionButtons!.dataStatus!) {
        print('Hdhd Step name: ${data.stepName}');
        print('Hdhd Data status: ${data.dataStatus}');
        // _addStep(data);
      }
      switch (formType) {
        case 'NOSETUPWIR':
          wirFromType = 0;
        case 'DEFAULT':
          wirFromType = 1;
      }
    } else {
      print('Form Details is null');
    }
  }

  void _addStep(DataStatus step) {
    switch(step.stepName){
      case 'contractor_team_approval':
        {
          print('Hdhd Data status: ${step.dataStatus} for team');
          if(step.dataStatus == true){
            print('Adding Team');
            steps.add(DashboardTap(2, AppStrings.contractorTeamApproval, false));
          }
        }
      case 'contractor_manager_approval':
        {
          if(step.dataStatus == true){
            steps.add(DashboardTap(3, AppStrings.contractorManagerApproval, false));
          }
        }
      case 'contractor_qaqc_approval':
        {
          if(step.dataStatus == true){
            steps.add(DashboardTap(4, AppStrings.contractorQAQCApproval, false));
          }
        }
      case 'recipient_verification':
        {
          if(step.dataStatus == true){
            steps.add(DashboardTap(5, AppStrings.recipientVerification, false));
          }
        }
      case 'technical_assistant':
        {
          if(step.dataStatus == true){
            steps.add(DashboardTap(6, AppStrings.technicalAssistant, false));
          }
        }
      case 'soil_test_witness_result':
        {
          if(step.dataStatus == true){
            steps.add(DashboardTap(7, AppStrings.soilTest, false));
          }
        }
      case 'special_approval':
        {
          if(step.dataStatus == true){
            steps.add(DashboardTap(8, AppStrings.specialApproval, false));
          }
        }
      case 'authorized_positions_approval':
        {
          if(step.dataStatus == true){
            steps.add(DashboardTap(9, AppStrings.authorizedPositions, false));
          }
        }
      case 'manager_approval':
        {
          if(step.dataStatus == true){
            steps.add(DashboardTap(10, AppStrings.consultantManager, false));
          }
        }
      case 'owners_representative':
        {
          if(step.dataStatus == true){
            steps.add(DashboardTap(11, AppStrings.ownerRepresentative, false));
          }
        }
      case 'pmc_approval':
        {
          if(step.dataStatus == true){
            steps.add(DashboardTap(12, AppStrings.PMCGroup, false));
          }
        }
      case 'result_receiving':
        {
          if(step.dataStatus == true){
            steps.add(DashboardTap(13, AppStrings.resultReceiving, false));
          }
          steps.add(DashboardTap(14, AppStrings.notes, false));
          steps.add(DashboardTap(15, AppStrings.history, false));
        }
    }
    emit(WIRFormAddStepState());
  }

  bool getStageStatus(int stage) {
    switch (stage) {
      case 2:
        return _getStatus('contractor_team_approval');
      case 3:
        return _getStatus('contractor_manager_approval');
      case 4:
        return _getStatus('contractor_qaqc_approval');
      case 5:
        return _getStatus('recipient_verification');
      case 6:
        return _getStatus('technical_assistant');
      case 7:
        return _getStatus('soil_test_witness_result');
      case 8:
        return _getStatus('special_approval');
      case 9:
        return _getStatus('authorized_positions_approval');
      case 10:
        return _getStatus('manager_approval');
      case 11:
        return _getStatus('owners_representative');
      case 12:
        return _getStatus('pmc_approval');
      case 13:
        return _getStatus('result_receiving');
      default:
        return false;
    }
  }

  bool _getStatus(String stageName) {
    if (formDetailsResponse != null) {
      for (var stage in formDetailsResponse!.transactionStages!.data!) {
        if (stage.stepName == stageName) {
          return true;
        }
      }
    }
    return false;
  }

  void refreshForm() {
    _getForm(wirForm!);
  }
}
