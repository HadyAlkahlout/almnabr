import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/app/constant.dart';
import 'package:teqani/app/helper.dart';
import 'package:teqani/data/network/app_api.dart';
import 'package:teqani/data/network/app_requests/wir_requests.dart';
import 'package:teqani/data/responses/main/form/details/transaction_attachments/transaction_attachments.dart';
import 'package:teqani/data/responses/main/form/details/transaction_stages/transaction_stages.dart';
import 'package:teqani/data/responses/main/form/details/transaction_technical_assistance/transaction_technical_assistance.dart';
import 'package:teqani/data/responses/main/form/details/transaction_units_work_locations/transaction_units_work_locations.dart';
import 'package:teqani/data/responses/main/form/technical_data/technical_data_response.dart';
import 'package:teqani/data/responses/main/form/wir_steps/authorized_position/authorized_position_response.dart';
import 'package:teqani/data/responses/main/form/wir_steps/consultant_manager/consultant_manager_response.dart';
import 'package:teqani/data/responses/main/form/wir_steps/manager_approval/manager_approval_response.dart';
import 'package:teqani/data/responses/main/form/wir_steps/owner_approval/owner_approval_response.dart';
import 'package:teqani/data/responses/main/form/wir_steps/pmc_approval/pmc_approval_response.dart';
import 'package:teqani/data/responses/main/form/wir_steps/qaqc_approval/qaqc_approval_response.dart';
import 'package:teqani/data/responses/main/form/wir_steps/receipient_reservation/receipient_reservation_response.dart';
import 'package:teqani/data/responses/main/form/wir_steps/result_receiving/result_receiving_response.dart';
import 'package:teqani/data/responses/main/form/wir_steps/soil_test/soil_test_response.dart';
import 'package:teqani/data/responses/main/form/wir_steps/special_approval/special_approval_response.dart';
import 'package:teqani/data/responses/main/form/wir_steps/team_approval/team_approval_response.dart';
import 'package:teqani/data/responses/main/form/wir_steps/technical_assistant/technical_assistant_response.dart';
import 'package:teqani/domain/model/main/attachment_data.dart';
import 'package:teqani/domain/model/main/check_list.dart';
import 'package:teqani/domain/model/main/position_users.dart';
import 'package:teqani/domain/model/main/saudi_code.dart';
import 'package:teqani/domain/model/main/unit_data.dart';
import 'package:teqani/domain/states/forms/wir/wir_steps_states.dart';
import 'package:teqani/presentation/resources/local_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/ui/module/module.dart';

class WirStepViewmodel extends Cubit<WirStepsStates> {
  WirStepViewmodel() : super(WirStepsInitialStates());

  static WirStepViewmodel get(context) => BlocProvider.of(context);

  final GraphQLClient _client = AppServiceClient.instance.getAppClient(false);
  List<StageData> stages = [];

  int approvalStatus = 1;
  final TextEditingController noteController = TextEditingController();

  int? step;
  TransactionStages? stageData;
  int? formId;
  int? formType;

  void start(
      int step,
      int formId,
      int formType,
      TransactionStages? transactionStages,
      List<WorkData>? formUnits,
      TransactionTechnicalAssistance? technicalAssistance,
      TransactionAttachments? attachments,
      ) {
    print('Step View Model Starts');
    print('Form Type: $formType');
    this.step = step;
    this.stageData = transactionStages;
    this.formId = formId;
    this.formType = formType;
    if(transactionStages != null){
      stages.clear();
      String stepName = _getStepName();
      for (var stage in transactionStages.data!) {
        if (stage.stepName == stepName) {
          stages.add(stage);
        }
      }
    }
    if (step == 6) {
      if (attachments != null) {
        techAttachments.clear();
        for (var attach in attachments.data!) {
          if (attach.transactionStepName == 'technical_assistant') {
            techAttachments.add(attach);
          }
        }
      }
      if (formType == 1) {
        _getTechnicalEditData(formId);
      }
      _getTechnicalData(technicalAssistance!);
    }
    if(formUnits != null){
      units.clear();
      for (var unit in formUnits) {
        units.add(
            UnitData(
              workLocation: unit.unitId ?? 'N/A',
              workLevelName: AppPreferences.getAppLanguage() == ENGLISH
                  ? unit.worklevel!.titleEn ?? 'N/A' : unit.worklevel!.titleEn ?? 'N/A',
              workLevel: unit.worklevel!.id ?? '0',
              quantity: 0,
            )
        );
      }
    }
  }

  void changeApprovalState(int isApprove) {
    if (isApprove != approvalStatus) {
      approvalStatus = isApprove;
      emit(WirStepsChangeStates());
    }
  }

  String _getStepName() {
    String stepName = '';
    print('Step: $step');
    switch (step) {
      case 2:
        stepName = 'contractor_team_approval';
      case 3:
        stepName = 'contractor_manager_approval';
      case 4:
        stepName = 'contractor_qaqc_approval';
      case 5:
        stepName = 'recipient_verification';
      case 6:
        stepName = 'technical_assistant';
      case 7:
        stepName = 'soil_test_witness_result';
      case 8:
        stepName = 'special_approval';
      case 9:
        stepName = 'authorized_positions_approval';
      case 10:
        stepName = 'manager_approval';
      case 11:
        stepName = 'owners_representative';
      case 12:
        stepName = 'pmc_approval';
      case 13:
        stepName = 'result_receiving';
    }
    return stepName;
  }

  void confirmStep(BuildContext context) {
    Module.showAlert(
      context,
      AppStrings.attention,
      AppStrings.stepConfirm,
      () {
        _sendStepRequest();
      },
      null,
    );
  }

  void _sendStepRequest() async {
    if (formId == 0) return;
    String token = AppPreferences.getUserToken();

    emit(WirStepsDataLoadingState());

    if (step == 6) {
      final Uri url = Uri.parse(Constant.mainUrl);
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      String operations = jsonEncode({
        "query": _getRequestQuery(),
        "variables": _getStepVar(),
      });

      Map<String, dynamic> map = {};
      var total = 0;
      for (var i = 0; i < selectedCheckLists.length; i++) {
        map["$i"] = ["variables.checkLists.$i.file"];
        request.files.add(
          await http.MultipartFile.fromPath("$i", selectedCheckLists[i].file!.path),
        );
        total++;
      }
      for (var i = 0; i < stepAttachments.length; i++) {
        map["$total"] = ["variables.fileData.$i.file"];
        request.files.add(
          await http.MultipartFile.fromPath("$total", stepAttachments[i].file.path),
        );
        total++;
      }

      print('File Map: $map');

      request.fields['operations'] = operations;
      request.fields['map'] = jsonEncode(map);

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      print('Response: $responseBody');
      Map<String, dynamic> jsonData = jsonDecode(responseBody);
      _getStepResult(jsonData['data'] ?? {});
    }
    if (step == 7) {
      final Uri url = Uri.parse(Constant.mainUrl);
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      String operations = jsonEncode({
        "query": _getRequestQuery(),
        "variables": _getStepVar(),
      });

      Map<String, dynamic> map = {};
      for (var i = 0; i < stepAttachments.length; i++) {
        map["$i"] = ["variables.fileData.$i.file"];
      }

      request.fields['operations'] = operations;
      request.fields['map'] = jsonEncode(map);

      for (var i = 0; i < stepAttachments.length; i++) {
        request.files.add(
            await http.MultipartFile.fromPath("$i", stepAttachments[i].file.path),
        );
      }

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      print('Response: $responseBody');
      Map<String, dynamic> jsonData = jsonDecode(responseBody);
      _getStepResult(jsonData['data'] ?? {});
    }
    else {
      final MutationOptions options = MutationOptions(
        document: gql(_getRequestQuery()),
        fetchPolicy: FetchPolicy.networkOnly,
        variables: _getStepVar(),
      );

      final QueryResult result = await _client.mutate(options);

      if (result.hasException) {
        print(result.exception.toString());
        Module.showToast(
          result.exception.toString(),
          true,
        );
        Helper.handleException(result.exception.toString());
        emit(WirStepsDataErrorState());
      } else {
        print('Data : ${result.data}');
        _getStepResult(result.data ?? {});
      }
    }

  }

  String _getRequestQuery() {
    String query = '';
    switch (step) {
      case 2:
        query = formType == 0
            ? WirRequests.noSetupTeamApproval
            : WirRequests.setupTeamApproval;
      case 3:
        query = formType == 0
            ? WirRequests.noSetupManagerApproval
            : WirRequests.setupManagerApproval;
      case 4:
        query = formType == 0
            ? WirRequests.noSetupQAQCApproval
            : WirRequests.setupQAQCApproval;
      case 5:
        query = formType == 0
            ? WirRequests.noSetupReceipientReservation
            : WirRequests.setupReceipientReservation;
      case 6:
        query = formType == 0
            ? WirRequests.noSetupTechnicalAssistant
            : WirRequests.setupTechnicalAssistant;
      case 7:
        query = formType == 0
            ? WirRequests.noSetupSoilTest
            : WirRequests.setupSoilTest;
      case 8:
        query = formType == 0
            ? WirRequests.noSetupSpecialApproval
            : WirRequests.setupSpecialApproval;
      case 9:
        query = formType == 0
            ? WirRequests.noSetupAuthorizedPositionApproval
            : WirRequests.setupAuthorizedPositionApproval;
      case 10:
        query = formType == 0
            ? WirRequests.noSetupConsultantManagerApproval
            : WirRequests.setupConsultantManagerApproval;
      case 11:
        query = formType == 0
            ? WirRequests.noSetupOwnerApproval
            : WirRequests.setupOwnerApproval;
      case 12:
        query = WirRequests.setupPMCApproval;
      case 13:
        query = formType == 0
            ? WirRequests.noSetupResultReceiving
            : WirRequests.setupResultReceiving;
    }
    return query;
  }

  Map<String, dynamic> _getStepVar() {
    Map<String, dynamic> data = {};
    data["transaction_id"] = "$formId";
    if (step == 9 || step == 10 || step! < 6) {
      data[step == 5 ? "reserve_status" : "approval_status"] =
          "$approvalStatus";
    }
    if (step != 6 && step != 7) {
      data["notes"] = noteController.text;
    }
    if (step == 3) {
      data["send_to_contractor_qaqc_approval"] = requireQAQC ? "1" : "0";
    }
    if (step == 3 || step == 6) {
      data["unitData"] = units.map((unit) => unit.toMap()).toList();
    }
    if(step == 6){
      if(!needCustomCheckList){
        for (var checkList in editCheckLists) {
          selectedCheckLists.add(checkList);
        }
      }

      data["needCustomCheckLists"] = needCustomCheckList ? "1" : "0";
      // data["customCheckLists"] = selectedCheckLists.map((checkList) => checkList.toMap()).toList();
      data["customCheckLists"] = "";
      data["checkLists"] = selectedCheckLists.map((checkList) => checkList.toMap()).toList();
      data["consultantRecomm"] = selectedConsultantSays.map((recommendation) => recommendation.toMap()).toList();
      data["saudiBuildingCodes"] = selectedSaudiBuildings.map((saudiBuildingCode) => saudiBuildingCode.toMap()).toList();
      data["special_approver_required"] = needSpecialApproval ? "1" : "0";
      data["specialUserData"] =  selectedPositionUsers.map((user) => user.toMap()).toList();
    }
    if(step == 7){
      data["soil_witness_test_report_type"] =
          reportType == 'Official' ? 'official' : reportType == 'Draft' ? 'draft' : '';
      data["soil_witness_test_result"] =
          testResult == 'Pass' ? 'P' : testResult == 'Fail' ? 'F' : '';
      data["soil_witness_test_notes"] = soilNoteController.text;
      data["soil_witness_test_report_number"] = reportController.text;
    }
    if(step == 6 || step == 7){
      data["fileData"] = stepAttachments.map((attach) => attach.toMap()).toList();
    }
    if (step == 10) {
      data["send_to_owner_representative"] = sendOwner ? "1" : "0";
    }

    data["userData"] = [];
    print('Data: $data');
    return data;
  }

  void _getStepResult(Map<String, dynamic> result) {
    switch (step) {
      case 2: _teamApprovalResult(result);
      case 3: _managerApprovalResult(result);
      case 4: _qaqcApprovalResult(result);
      case 5: _recipientApprovalResult(result);
      case 6: _technicalAssistantResult(result);
      case 7: _soilTestResult(result);
      case 8: _specialApprovalResult(result);
      case 9: _authorizedApprovalResult(result);
      case 10: _consultantManagerResult(result);
      case 11: _ownersRepresentativeResult(result);
      case 12: _pmcApprovalResult(result);
      case 13: _resultReceivingResult(result);
    }
  }

  // Steps Response
  void _teamApprovalResult(Map<String, dynamic> result) {
    TeamApprovalResponse response = TeamApprovalResponse.fromJson(result);
    if (formType == 0) {
      if (response.noSetupWirContractorTeamApproval == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.noSetupWirContractorTeamApproval!.message ?? '',
          response.noSetupWirContractorTeamApproval!.status == false,
        );
        emit(response.noSetupWirContractorTeamApproval!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    } else {
      if (response.wirContractorTeamApproval == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.wirContractorTeamApproval!.message ?? '',
          response.wirContractorTeamApproval!.status == false,
        );
        emit(response.wirContractorTeamApproval!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    }
  }
  void _managerApprovalResult(Map<String, dynamic> result) {
    ManagerApprovalResponse response = ManagerApprovalResponse.fromJson(result);
    if (formType == 0) {
      if (response.noSetupWirContractorManagerApproval == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.noSetupWirContractorManagerApproval!.message ?? '',
          response.noSetupWirContractorManagerApproval!.status == false,
        );
        emit(response.noSetupWirContractorManagerApproval!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    } else {
      if (response.wirContractorManagerApproval == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.wirContractorManagerApproval!.message ?? '',
          response.wirContractorManagerApproval!.status == false,
        );
        emit(response.wirContractorManagerApproval!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    }
  }
  void _qaqcApprovalResult(Map<String, dynamic> result) {
    QaqcApprovalResponse response = QaqcApprovalResponse.fromJson(result);
    if (formType == 0) {
      if (response.noSetupWirContractorQAQCApproval == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.noSetupWirContractorQAQCApproval!.message ?? '',
          response.noSetupWirContractorQAQCApproval!.status == false,
        );
        emit(response.noSetupWirContractorQAQCApproval!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    } else {
      if (response.wirContractorQAQCApproval == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.wirContractorQAQCApproval!.message ?? '',
          response.wirContractorQAQCApproval!.status == false,
        );
        emit(response.wirContractorQAQCApproval!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    }
  }
  void _recipientApprovalResult(Map<String, dynamic> result) {
    ReceipientReservationResponse response = ReceipientReservationResponse.fromJson(result);
    if (formType == 0) {
      if (response.noSetupWIRReceipientReservation == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.noSetupWIRReceipientReservation!.message ?? '',
          response.noSetupWIRReceipientReservation!.status == false,
        );
        emit(response.noSetupWIRReceipientReservation!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    } else {
      if (response.wirReceipientReservation == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.wirReceipientReservation!.message ?? '',
          response.wirReceipientReservation!.status == false,
        );
        emit(response.wirReceipientReservation!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    }
  }
  void _technicalAssistantResult(Map<String, dynamic> result) {
    TechnicalAssistantResponse response = TechnicalAssistantResponse.fromJson(result);
    if (formType == 0) {
      if (response.noSetupWirTechnicalAssistant == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.noSetupWirTechnicalAssistant!.message ?? '',
          response.noSetupWirTechnicalAssistant!.status == false,
        );
        emit(response.noSetupWirTechnicalAssistant!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    } else {
      if (response.wirTechnicalAssistant == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.wirTechnicalAssistant!.message ?? '',
          response.wirTechnicalAssistant!.status == false,
        );
        emit(response.wirTechnicalAssistant!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    }
  }
  void _soilTestResult(Map<String, dynamic> result) {
    SoilTestResponse response = SoilTestResponse.fromJson(result);
    if (formType == 0) {
      if (response.noSetupWirSoilTest == null) {
        Module.showToast('Something went wrong!', true);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.noSetupWirSoilTest!.message ?? '',
          response.noSetupWirSoilTest!.status == false,
        );
        emit(response.noSetupWirSoilTest!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    } else {
      if (response.wirSoilTest == null) {
        Module.showToast('Something went wrong!', true);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.wirSoilTest!.message ?? '',
          response.wirSoilTest!.status == false,
        );
        emit(response.wirSoilTest!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    }
  }
  void _specialApprovalResult(Map<String, dynamic> result) {
    SpecialApprovalResponse response = SpecialApprovalResponse.fromJson(result);
    if (formType == 0) {
      Module.showToast('Something went wrong!', true,);
      if (response.noSetupWirSpecialApproval == null) {
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.noSetupWirSpecialApproval!.message ?? '',
          response.noSetupWirSpecialApproval!.status == false,
        );
        emit(response.noSetupWirSpecialApproval!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    } else {
      if (response.wirSpecialApproval == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.wirSpecialApproval!.message ?? '',
          response.wirSpecialApproval!.status == false,
        );
        emit(response.wirSpecialApproval!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    }
  }
  void _authorizedApprovalResult(Map<String, dynamic> result) {
    AuthorizedPositionResponse response = AuthorizedPositionResponse.fromJson(result);
    if (formType == 0) {
      if (response.noSetupWirAuthorizedPosition == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.noSetupWirAuthorizedPosition!.message ?? '',
          response.noSetupWirAuthorizedPosition!.status == false,
        );
        emit(response.noSetupWirAuthorizedPosition!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    } else {
      if (response.wirAuthorizedPosition == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.wirAuthorizedPosition!.message ?? '',
          response.wirAuthorizedPosition!.status == false,
        );
        emit(response.wirAuthorizedPosition!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    }
  }
  void _consultantManagerResult(Map<String, dynamic> result) {
    ConsultantManagerResponse response = ConsultantManagerResponse.fromJson(result);
    if (formType == 0) {
      if (response.noSetupWirConsultantManager == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.noSetupWirConsultantManager!.message ?? '',
          response.noSetupWirConsultantManager!.status == false,
        );
        emit(response.noSetupWirConsultantManager!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    } else {
      if (response.wirConsultantManager == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.wirConsultantManager!.message ?? '',
          response.wirConsultantManager!.status == false,
        );
        emit(response.wirConsultantManager!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    }
  }
  void _ownersRepresentativeResult(Map<String, dynamic> result) {
    OwnerApprovalResponse response = OwnerApprovalResponse.fromJson(result);
    if (formType == 0) {
      if (response.noSetupWirOwnerApproval == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.noSetupWirOwnerApproval!.message ?? '',
          response.noSetupWirOwnerApproval!.status == false,
        );
        emit(response.noSetupWirOwnerApproval!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    } else {
      if (response.wirOwnerApproval == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.wirOwnerApproval!.message ?? '',
          response.wirOwnerApproval!.status == false,
        );
        emit(response.wirOwnerApproval!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    }
  }
  void _pmcApprovalResult(Map<String, dynamic> result) {
    PMCApprovalResponse response = PMCApprovalResponse.fromJson(result);
    if (response.wirPMCApproval == null) {
      Module.showToast('Something went wrong!', true,);
      emit(WirStepsDataErrorState());
    } else {
      Module.showToast(
        response.wirPMCApproval!.message ?? '',
        response.wirPMCApproval!.status == false,
      );
      emit(response.wirPMCApproval!.status == true
          ? WirStepsDataSuccessState()
          : WirStepsDataErrorState()
      );
    }
  }
  void _resultReceivingResult(Map<String, dynamic> result) {
    ResultReceivingResponse response = ResultReceivingResponse.fromJson(result);
    if (formType == 0) {
      if (response.noSetupWirResultReceiving == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.noSetupWirResultReceiving!.message ?? '',
          response.noSetupWirResultReceiving!.status == false,
        );
        emit(response.noSetupWirResultReceiving!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    } else {
      if (response.wirResultReceiving == null) {
        Module.showToast('Something went wrong!', true,);
        emit(WirStepsDataErrorState());
      } else {
        Module.showToast(
          response.wirResultReceiving!.message ?? '',
          response.wirResultReceiving!.status == false,
        );
        emit(response.wirResultReceiving!.status == true
            ? WirStepsDataSuccessState()
            : WirStepsDataErrorState()
        );
      }
    }
  }

  // Contractor Manager Approval
  bool requireQAQC = false;
  List<UnitData> units = [];

  void changeRequireQaQc() {
    requireQAQC = !requireQAQC;
    emit(WirManagerQaQcChangeStates());
  }

  void addUnit(UnitData unit) {
    units.add(unit);
    emit(WirManagerAddUnitStates());
  }

  void deleteUnit(UnitData unit) {
    units.remove(unit);
    emit(WirManagerRemoveUnitStates());
  }

  // Attachments
  List<AttachmentData> stepAttachments = [];

  void addAttachment(AttachmentData attach) {
    stepAttachments.add(attach);
    emit(WirAddAttachmentStates());
  }

  void deleteAttachment(AttachmentData attach) {
    stepAttachments.remove(attach);
    emit(WirRemoveAttachmentStates());
  }

  // Technical Assistant
  bool needCustomCheckList = false;
  bool needSpecialApproval = false;
  List<TechnicalAssistantData> checkLists = [];
  List<CheckList> editCheckLists = [];
  List<CheckList> selectedCheckLists = [];
  List<TechnicalAssistantData> saudiBuildings = [];
  List<SaudiCode> selectedSaudiBuildings = [];
  List<TechnicalAssistantData> consultantSays = [];
  List<SaudiCode> selectedConsultantSays = [];
  List<Attachment> techAttachments = [];
  List<TechnicalData>? _formCheckList;

  List<PositionUsers> selectedPositionUsers = [];

  void _getTechnicalData(TransactionTechnicalAssistance technicalAssistance) {
    checkLists.clear();
    saudiBuildings.clear();
    consultantSays.clear();
    for (var technical in technicalAssistance.data!) {
      switch (technical.assistanceType) {
        case 'CL':
          checkLists.add(technical);
        case 'SBC':
          saudiBuildings.add(technical);
        case 'CR':
          consultantSays.add(technical);
      }
    }
  }

  bool isAllCheckListApproved() {
    for (var checkList in checkLists) {
      if (checkList.status != '1') {
        return false;
      }
    }
    return true;
  }

  void _getTechnicalEditData(int id) async {
    emit(WirStepsDataLoadingState());

    final MutationOptions options = MutationOptions(
      document: gql(WirRequests.technicalData),
      fetchPolicy: FetchPolicy.networkOnly,
      variables: {
        "transaction_id": "$id",
        "record_type": ["CL", "SBC", "CR"]
      },
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      print(result.exception.toString());
      emit(WirStepsDataErrorState());
    } else {
      _technicalEditDataResult(result.data ?? {});
    }
  }

  void _technicalEditDataResult(Map<String, dynamic> map) {
    TechDataResponse response = TechDataResponse.fromJson(map);
    print('Tech Data: $map');
    if(response.response != null){
      if (response.response!.status != null && response.response!.status == true) {
        editCheckLists.clear();
        selectedCheckLists.clear();
        selectedSaudiBuildings.clear();
        selectedConsultantSays.clear();
        _formCheckList = [];
        for (var techData in response.response!.data!) {
          switch (techData.formSetupType) {
            case 'CL':
              {
                _formCheckList!.add(techData);
                editCheckLists.add(CheckList(
                  techData.id.toString(),
                  techData.titleEn ?? '',
                  techData.titleAr ?? '',
                  null,
                  techData.status ?? '1',
                  true,
                ));
              }
            case 'SBC': {
              selectedSaudiBuildings.add(SaudiCode(
                techData.id.toString(),
                techData.titleEn ?? '',
                techData.titleAr ?? '',
                techData.status ?? '1',
                true,
              ));
            }
            case 'CR': {
              selectedConsultantSays.add(SaudiCode(
                techData.id.toString(),
                techData.titleEn ?? '',
                techData.titleAr ?? '',
                techData.status ?? '1',
                true,
              ));
            }
          }
        }
      }
      emit(WirStepTechnicalDataSuccessState());
    } else{
      emit(WirStepTechnicalDataErrorState());
    }
  }

  void changeCustomCheckList() {
    needCustomCheckList = !needCustomCheckList;
    emit(WirTechnicalCustomCheckListStates());
  }

  void changeNeedSpecial() {
    needSpecialApproval = !needSpecialApproval;
    emit(WirTechnicalNeedSpecialStates());
  }

  void addCheckList(CheckList attach) {
    selectedCheckLists.add(attach);
    emit(WirTechnicalAddCheckListStates());
  }

  void deleteCheckList(CheckList attach) {
    selectedCheckLists.remove(attach);
    emit(WirTechnicalRemoveCheckListStates());
  }

  void editCheckList(CheckList attach, bool fromApi) {
    if(fromApi){
      for (var e in editCheckLists) {
        if(e.id == attach.id){
          e = attach;
        }
      }
    } else {
      for (var e in editCheckLists) {
        if(e.id == attach.id){
          e = attach;
        }
      }
    }
    emit(WirTechnicalEditCheckListStates());
  }

  void addConsultant(SaudiCode attach) {
    selectedConsultantSays.add(attach);
    emit(WirTechnicalAddConsultantStates());
  }

  void deleteConsultant(SaudiCode attach) {
    selectedConsultantSays.remove(attach);
    emit(WirTechnicalRemoveConsultantStates());
  }

  void editConsultant(SaudiCode attach) {
    for (var e in selectedConsultantSays) {
      if(e.titleEn == attach.titleEn){
        e = attach;
      }
    }
    emit(WirTechnicalEditConsultantStates());
  }

  void addSaudiCode(SaudiCode attach) {
    selectedSaudiBuildings.add(attach);
    emit(WirTechnicalAddSaudiCodeStates());
  }

  void deleteSaudiCode(SaudiCode attach) {
    selectedSaudiBuildings.remove(attach);
    emit(WirTechnicalRemoveSaudiCodeStates());
  }

  void editSaudiCode(SaudiCode attach) {
    for (var e in selectedSaudiBuildings) {
      if(e.titleEn == attach.titleEn){
        e = attach;
      }
    }
    emit(WirTechnicalEditSaudiCodeStates());
  }

  void addPositionUsers(PositionUsers positionUsers) {
    print('Add position Users to WIR: $positionUsers');
    selectedPositionUsers.add(positionUsers);
  }

  void deletePositionUsers(PositionUsers positionUsers) {
    print('Delete position Users from WIR: $positionUsers');
    selectedPositionUsers.remove(positionUsers);
  }

  // Soil Test
  String? reportType;
  String? testResult;
  final TextEditingController soilNoteController = TextEditingController();
  final TextEditingController reportController = TextEditingController();

  List<String> getReportTypes() {
    return ['Official', 'Draft'];
  }

  List<String> getTestResults() {
    return ['Pass', 'Fail'];
  }

  void changeReportType(String type) {
    reportType = type;
    emit(WirSoilChangeTypeStates());
  }

  void changeTestResult(String result) {
    testResult = result;
    emit(WirSoilChangeResultStates());
  }

  // Consultant Manager
  bool sendOwner = false;

  void changeOwnerStatus() {
    sendOwner = !sendOwner;
    emit(WirConsultantOwnerStates());
  }
}
