class WirRequests {

  static const String previousVersionsQuery = '''
    query (
      \$lang_key:String,
      \$project_id:Int,
      \$activity_id:Int, 
      \$units:[String],
      \$worklevels:[String]
      ){
      getWIRUnitsPreviousVersions(
          lang_key:\$lang_key,
          project_id:\$project_id,
          activity_id:\$activity_id,
          units: \$units,
          worklevels:\$worklevels
      ) {
          status
          message
          data{
              transaction_id
              form_key
              form_type
              units
              worklevels
              result_code
              resubmited_transaction_id
              unit_wl_version
              tbv_count
              pdf{
                  file_path
                  file_size
                  file_extension
                  title_en
                  title_ar
              }
          }
      }
    }
  ''';

  static const String relatedActivitiesQuery = '''
    query (
      \$lang_key:String,
      \$project_id:Int,
      \$activity_id:Int, 
      \$units:[String],
      \$worklevels:[String]
      ){
      getWIRUnitsRelatedActivities(
          lang_key:\$lang_key,
          project_id:\$project_id,
          activity_id:\$activity_id,
          units: \$units,
          worklevels:\$worklevels
      ) {
          status
          message
          data{
              transaction_id
              form_key
              form_type
              units
              worklevels
              result_code
              resubmited_transaction_id
              unit_wl_version
              tbv_count
              pdf{
                  file_path
                  file_size
                  file_extension
                  title_en
                  title_ar
              }
          }
      }
    }
  ''';

  static const String previewWIR = '''
    query (\$transaction_id: String){
      previewWIRTransaction(transaction_id:\$transaction_id){
          status
          message
          data{
              export_type
              file_name
              mime_type
              content
          }
      }
  }
  ''';

  static const String technicalData = '''
    query(\$transaction_id:String, \$record_type:[String]) {
        getWIRTechnicalAssistanceData(transaction_id:\$transaction_id, record_type:\$record_type) {
            status
            message
            data{
                id
                form_setup_type
                yes_code_result
                no_code_result
                title_en
                title_ar
                description_en
                description_ar
                status
            }
        }
    }
  ''';

  // WIR Form Steps
  static const String setupTeamApproval = '''
    mutation (\$transaction_id: String, \$approval_status:String, \$notes:String, \$userData:[UserRequestData]){
        wirContractorTeamApproval(transaction_id: \$transaction_id, approval_status: \$approval_status, notes: \$notes,userData:\$userData
            ) {
            status
            message
        }
    }
  ''';

  static const String noSetupTeamApproval = '''
    mutation (\$transaction_id: String, \$approval_status:String, \$notes:String, \$userData:[UserRequestData]){
        noSetupWIRContractorTeamApproval(transaction_id: \$transaction_id, approval_status: \$approval_status, notes: \$notes,userData:\$userData
            ) {
            status
            message
        }
    }
  ''';

  static const String setupManagerApproval = '''
    mutation (\$transaction_id: String, \$approval_status:String, \$notes:String,\$send_to_contractor_qaqc_approval:String,\$unitData:[UnitDataForWIR],\$userData:[UserRequestData]){
        wirContractorManagerApproval(transaction_id: \$transaction_id, approval_status: \$approval_status, notes: \$notes,send_to_contractor_qaqc_approval:\$send_to_contractor_qaqc_approval,unitData:\$unitData,userData:\$userData
            ) {
            status
            message
        }
    }
  ''';

  static const String noSetupManagerApproval = '''
    mutation (\$transaction_id: String, \$approval_status:String, \$notes:String,\$send_to_contractor_qaqc_approval:String,\$unitData:[UnitDataForWIR],\$userData:[UserRequestData]){
        noSetupWIRContractorManagerApproval(transaction_id: \$transaction_id, approval_status: \$approval_status, notes: \$notes,send_to_contractor_qaqc_approval:\$send_to_contractor_qaqc_approval,unitData:\$unitData,userData:\$userData
            ) {
            status
            message
        }
    }
  ''';

  static const String setupQAQCApproval = '''
    mutation (\$transaction_id: String, \$approval_status:String, \$notes:String,\$userData:[UserRequestData]){
        wirContractorQAQCApproval(transaction_id: \$transaction_id, approval_status: \$approval_status, notes: \$notes,userData:\$userData
            ) {
            status
            message
        }
    }
  ''';

  static const String noSetupQAQCApproval = '''
    mutation (\$transaction_id: String, \$approval_status:String, \$notes:String,\$userData:[UserRequestData]){
        noSetupWIRContractorQAQCApproval(transaction_id: \$transaction_id, approval_status: \$approval_status, notes: \$notes,userData:\$userData
            ) {
            status
            message
        }
    }
  ''';

  static const String setupReceipientReservation = '''
    mutation (\$transaction_id: String, \$reserve_status:String, \$notes:String,\$userData:[UserRequestData]){
        wirReceipientReservation(transaction_id: \$transaction_id, reserve_status: \$reserve_status, notes: \$notes,userData:\$userData
            ) {
            status
            message
        }
    }
  ''';

  static const String noSetupReceipientReservation = '''
    mutation (\$transaction_id: String, \$reserve_status:String, \$notes:String,\$userData:[UserRequestData]){
        noSetupWIRReceipientReservation(transaction_id: \$transaction_id, reserve_status: \$reserve_status, notes: \$notes,userData:\$userData
            ) {
            status
            message
        }
    }
  ''';

  static const String setupTechnicalAssistant = '''
    mutation(\$transaction_id:String,\$needCustomCheckLists:String,\$customCheckLists:[CheckListsData],\$checkLists:[CheckListsData],\$consultantRecomm:[RecommentationsData],\$saudiBuildingCodes:[SaudiBuildingCodesData],\$unitData:[UnitDataForWIR],\$fileData:[FileRequestData],\$userData:[UserRequestData],\$special_approver_required:String,\$specialUserData:[UserRequestData]) {
        wirTechnicalAssistanceTransaction(
          transaction_id: \$transaction_id,
          needCustomCheckLists: \$needCustomCheckLists,
          customCheckLists: \$customCheckLists,
          checkLists: \$checkLists,
          consultantRecomm: \$consultantRecomm,
          saudiBuildingCodes: \$saudiBuildingCodes,
          unitData: \$unitData,
          fileData: \$fileData,
          userData: \$userData,
          special_approver_required: \$special_approver_required,
          specialUserData: \$specialUserData
        ) {
          message
          status
        }
      }
  ''';

  static const String noSetupTechnicalAssistant = '''
    mutation(
      \$transaction_id:String,
      \$special_approver_required:String,
      \$soil_test_required:String,
      \$send_to_authorized_position:String,
      \$checkLists:[CheckListsData],
      \$saudiBuildingCodes:[SaudiBuildingCodesData],
      \$recommendations:[RecommentationsData],
      \$unitData:[UnitDataForWIR],
      \$fileData:[FileRequestData],
      \$userData:[UserRequestData]
    ){
        noSetupWIRTechnicalAssistanceTransaction(
          transaction_id:\$transaction_id,
          special_approver_required:\$special_approver_required,
          soil_test_required:\$soil_test_required,
          send_to_authorized_position:\$send_to_authorized_position,
          checkLists:\$checkLists,
          saudiBuildingCodes:\$saudiBuildingCodes,
          recommendations:\$recommendations,
          unitData:\$unitData,
          fileData:\$fileData,
          userData:\$userData
        ){
           message 
           status
        }
    }
  ''';

  static const String setupSoilTest = '''
    mutation(\$transaction_id:String,\$soil_witness_test_report_type:String,\$soil_witness_test_result:String,\$soil_witness_test_notes:String,\$soil_witness_test_report_number:String,\$fileData:[FileRequestData],\$userData:[UserRequestData]){
        wirSoilTestTransactionApproval(transaction_id:\$transaction_id,soil_witness_test_report_type:\$soil_witness_test_report_type,soil_witness_test_result:\$soil_witness_test_result,soil_witness_test_notes:\$soil_witness_test_notes,soil_witness_test_report_number:\$soil_witness_test_report_number,fileData:\$fileData,userData:\$userData) 
        {
            message 
            status
        }
    }
  ''';

  static const String noSetupSoilTest = '''
    mutation(\$transaction_id:String,\$soil_witness_test_report_type:String,\$soil_witness_test_result:String,\$soil_witness_test_notes:String,\$soil_witness_test_report_number:String,\$fileData:[FileRequestData],\$userData:[UserRequestData]){
        noSetupWIRSoilTestTransactionApproval(transaction_id:\$transaction_id,soil_witness_test_report_type:\$soil_witness_test_report_type,soil_witness_test_result:\$soil_witness_test_result,soil_witness_test_notes:\$soil_witness_test_notes,soil_witness_test_report_number:\$soil_witness_test_report_number,fileData:\$fileData,userData:\$userData) 
        {
            message 
            status
        }
    }
  ''';

  static const String setupSpecialApproval = '''
    mutation (\$transaction_id: String, \$notes:String,\$userData:[UserRequestData]){
        wirSpecialApproval(transaction_id: \$transaction_id, notes: \$notes,userData:\$userData
            ) {
            status
            message
        }
    }
  ''';

  static const String noSetupSpecialApproval = '''
    mutation (\$transaction_id: String, \$notes:String,\$userData:[UserRequestData]){
        noSetupWIRSpecialApproval(transaction_id: \$transaction_id, notes: \$notes,userData:\$userData
            ) {
            status
            message
        }
    }
  ''';

  static const String setupAuthorizedPositionApproval = '''
    mutation (\$transaction_id: String, \$approval_status: String, \$notes:String,\$userData:[UserRequestData]){
        wirAuthorizedPositionApproval(transaction_id: \$transaction_id, approval_status: \$approval_status, notes: \$notes, userData:\$userData
            ) {
            status
            message
        }
    }
  ''';

  static const String noSetupAuthorizedPositionApproval = '''
    mutation (\$transaction_id: String, \$approval_status: String, \$notes:String,\$userData:[UserRequestData]){
        noSetupWIRAuthorizedPositionApproval(transaction_id: \$transaction_id, approval_status: \$approval_status, notes: \$notes,userData:\$userData
            ) {
            status
            message
        }
    }
  ''';

  static const String setupConsultantManagerApproval = '''
    mutation (\$transaction_id: String, \$approval_status:String, \$notes:String,\$send_to_owner_representative:String,\$userData:[UserRequestData]){
        wirConsultantManagerApproval(transaction_id: \$transaction_id, approval_status: \$approval_status, notes: \$notes,send_to_owner_representative:\$send_to_owner_representative,userData:\$userData
            ) {
            status
            message
        }
    }
  ''';

  static const String noSetupConsultantManagerApproval = '''
    mutation (\$transaction_id: String, \$approval_status:String, \$notes:String, \$send_to_owner_representative:String, \$userData:[UserRequestData]){
        noSetupWIRConsultantManagerApproval(transaction_id: \$transaction_id, approval_status: \$approval_status, notes: \$notes,send_to_owner_representative:\$send_to_owner_representative,userData:\$userData
            ) {
            status
            message
        }
    }
  ''';

  static const String setupOwnerApproval = '''
    mutation (\$transaction_id: String, \$notes:String){
        wirOwnerApproval(transaction_id: \$transaction_id, notes: \$notes
            ) {
            status
            message
        }
    }
  ''';

  static const String noSetupOwnerApproval = '''
    mutation (\$transaction_id: String, \$notes:String){
        noSetupWIROwnerApproval(transaction_id: \$transaction_id, notes: \$notes
            ) {
            status
            message
        }
    }
  ''';

  static const String setupPMCApproval = '''
    mutation (\$transaction_id: String, \$notes:String){
        wirPMCApproval(transaction_id: \$transaction_id, notes: \$notes
            ) {
            status
            message
        }
    }
  ''';

  static const String setupResultReceiving = '''
    mutation (\$transaction_id: String, \$notes:String){
        wirResultReceiving(transaction_id: \$transaction_id, notes: \$notes
            ) {
            status
            message
        }
    }
  ''';

  static const String noSetupResultReceiving = '''
    mutation (\$transaction_id: String, \$notes:String){
        noSetupWIRResultReceiving(transaction_id: \$transaction_id, notes: \$notes
            ) {
            status
            message
        }
    }
  ''';
}
