class MainRequests {
  static const String dashboardQuery = '''
    query (
      \$page_no: Int,
      \$page_size: Int,
      \$project_id: Int,
      \$activities: [Int],
      \$search_key: String,
      \$search_units: String,
      \$divisions: [Int],
      \$chapters: [Int],
      \$work_levels: [Int],
      \$companies: [Int],
      \$forms: [String],
      \$steps: [String],
      \$results: [String],
      \$linked_items: [Int],
      \$start_date: String,
      \$end_date: String,
      \$tags: [String],
      \$show_completed: String,
      \$waiting_for_approval: String
  ) {
      transactionsCountAndLists(
          page_no: \$page_no,
          page_size: \$page_size,
          project_id: \$project_id,
          activities: \$activities,
          search_key: \$search_key,
          search_units: \$search_units,
          divisions: \$divisions,
          chapters: \$chapters,
          work_levels: \$work_levels,
          companies: \$companies,
          forms: \$forms,
          steps: \$steps,
          results: \$results,
          linked_items: \$linked_items,
          start_date: \$start_date,
          end_date: \$end_date,
          tags: \$tags,
          show_completed: \$show_completed,
          waiting_for_approval: \$waiting_for_approval
      ) {
          status
          message
          total
          paging {
              total
              currentPage
              lastPage
              from
              to
          }
          data{
              id
              sequence_number
              form_sequence_number
              project_id
              project{
                  id
                  name
                  address
                  area
                  status
              }
              activitytype{
                  type
                  title_en
                  title_ar
              }
              division_id
              division{
                  id
                  title_ar
                  title_en
              }
              chapter_id
              chapter{
                  id
                  chapter_code
                  title_ar
                  title_en
              }
              activity_id
              activity{
                  id
                  title_en
                  title_ar
                  activity_code
                  activityDivision{
                      id
                      title_ar
                      title_en
                  }
                  activityChapter{
                      id
                      chapter_code
                      title_ar
                      title_en
                  }
              }
              activityRenames{
                  title_en
                  title_ar
              }
              form_key
              form_type
              transaction_from
              transaction_from_company{
                  id
                  contractor_name
                  commercial_registeration
                  vat_number
              }
              transaction_to
              transaction_to_company{
                  id
                  contractor_name
                  commercial_registeration
                  vat_number
              }
              lang_key
              subject
              writer{
                  id
                  name
                  email
                  mobile
              }
              approval_type
              last_step_name
              last_step_name_label
              transaction_actual_datetime
              transaction_status
              transaction_created_datetime
              transaction_updated_datetime
              transaction_submitted_datetime
              submitter {
                  id
                  name
                  email
                  mobile
              }
              version
              barcodeData
              barcodeKey
              units
              evaluation_result
              request_color
              resubmited_transaction_id
              attachment{
                  file_path
                  file_size
                  file_extension
                  title_en
                  title_ar
              }
              created_at
              updated_at
          }
      }
  }
  ''';

  static const String formQuery = '''
    query(\$transaction_id:String,\$project_id:String) {
      transactionDetails(transaction_id:\$transaction_id) {
          status
          message
          data{
              id
              sequence_number
              form_sequence_number
              project_id
              project{
                  id
                  name
                  address
                  area
                  status
              }
              activity_id
              activity{
                  id
                  title_en
                  title_ar
                  activity_code
                  activityDivision{
                      id
                      title_ar
                      title_en
                  }
                  activityChapter{
                      id
                      chapter_code
                      title_ar
                      title_en
                  }
              }
              activityRenames{
                  title_en
                  title_ar
              }
              form_key
              form_type
              transaction_from_sub
              transaction_from_sub_company{
                  id
                  contractor_name
                  commercial_registeration
                  vat_number
              }
              transaction_from
              transaction_from_company{
                  id
                  contractor_name
                  commercial_registeration
                  vat_number
              }
              transaction_to
              transaction_to_company{
                  id
                  contractor_name
                  commercial_registeration
                  vat_number
              }
              lang_key
              subject
              writer{
                  id
                  name
                  email
                  mobile
              }
              approval_type
              last_step_name
              transaction_actual_datetime
              transaction_status
              transaction_created_datetime
              transaction_updated_datetime
              transaction_submitted_datetime
              submitter {
                  id
                  name
                  email
                  mobile
              }
              version
              barcodeData
              barcodeKey
              units
              evaluation_result
              resubmited_transaction_id
              attachment{
                  file_path
                  file_size
                  file_extension
                  title_en
                  title_ar
              }
              created_at
              updated_at
          }
      }
      transactionCompanies(transaction_id:\$transaction_id,project_id:\$project_id) {
          status
          message
          data{
              company_id
              company{
                  id
                  contractor_name
                  commercial_registeration
                  vat_number
                  email
                  mobile
                  logo
              }
              company_position_id
              companyPositions{
                  keyword
                  title_en
                  title_ar
              }
          }
      }
      transactionWIRActionButtons(transaction_id:\$transaction_id) {
          status
          message
          view{
              configurations
              contractor_team_approval
              contractor_manager_approval
              contractor_qaqc_approval
              recipient_verification
              technical_assistant
              soil_test_witness_result
              special_approval
              authorized_positions_approval
              manager_approval
              owners_representative
              pmc_approval
              result_receiving
          }
          edit{
              configurations
              contractor_team_approval
              contractor_manager_approval
              contractor_qaqc_approval
              recipient_verification
              technical_assistant
              soil_test_witness_result
              special_approval
              authorized_positions_approval
              manager_approval
              owners_representative
              pmc_approval
              result_receiving
          }
          data_status{
              step_name
              data_status
          }
      }
      transactionAttachments(transaction_id:\$transaction_id,page_no:1,page_size:10,step_name:"") {
          status
          message
          paging {
              total
              currentPage
              lastPage
              from
              to
          }
          data{
              id
              transaction_step_name
              file_path
              file_size
              file_extension
              title_en
              title_ar
              created_at
              updated_at
              writer{
                  id
                  name
                  email
                  mobile
              }
          }
      }
      transactionNotes(transaction_id:\$transaction_id,page_no:1,page_size:10,step_name:"") {
          status
          message
          paging {
              total
              currentPage
              lastPage
              from
              to
          }
          data{
              id
              transaction_step_name
              notes
              created_at
              updated_at
              writer{
                  id
                  name
                  email
                  mobile
              }
          }
      }
      transactionRecords(transaction_id:\$transaction_id,page_no:1,page_size:10,step_name:"") {
          status
          message
          paging {
              total
              currentPage
              lastPage
              from
              to
          }
          data{
              id
              transaction_step_name
              notes
              created_at
              updated_at
              writer{
                  id
                  name
                  email
                  mobile
              }
          }
      }
      transactionPersons(transaction_id:\$transaction_id,page_no:1,page_size:10,step_name:"") {
          status
          message
          paging {
              total
              currentPage
              lastPage
              from
              to
          }
          data{
              id
              position {
                  id
                  title_en
                  title_ar
              }
              user{
                  id
                  name
                  email
                  mobile
              }
              notes{
                  transaction_id
                  writer{
                      id
                      name
                      email
                      mobile
                  }
                  transaction_step_name
                  notes
                  notes_type
                  created_at
                  updated_at
              }
              person_type
              viewed_status
              viewed_datetime
              approved_status
              approved_datetime
              step_name
              created_at
              updated_at
          }
      }
      transactionWIRFormData(transaction_id:\$transaction_id) {
          status
          message
          data{
              id
              transaction_id
              project_id
              activity_id
              template_id
              bill_quantity_item_id
              bills{
                  item_code
                  item_name
                  item_description
                  item_unit
                  item_quantity
                  item_price
                  item_total_price
              }
              send_to_contractor_team
              send_to_contractor_manager
              soil_test_required
              allow_custom_users
              allow_custom_quantities
              special_approver_required
              send_to_authorized_position
              soil_witness_test_result
              soil_witness_test_report_number
              soil_witness_test_report_type
              created_at
              updated_at
          }
      }
      transactionTechnicalAssistance(transaction_id:\$transaction_id,page_no:1,page_size:10,assistance_type:"",old_records:"0") {
          status
          message
          paging {
              total
              currentPage
              lastPage
              from
              to
          }
          data{
              id
              step_name
              assistance_type
              custom_key
              custom_val
              title_en
              title_ar
              status
              result
              attachment{
                  file_path
                  file_size
                  file_extension
                  title_en
                  title_ar
              }
              writer{
                  id
                  name
                  email
                  mobile
              }
              created_at
              updated_at
          }
      }
      transactionUnitsWorkLocations(transaction_id:\$transaction_id,page_no:1,page_size:10) {
          status
          message
          paging {
              total
              currentPage
              lastPage
              from
              to
          }
          data{
              id
              transaction_id
              project_id
              form_type
              activity_id
              activity{
                  id
                  activity_code
                  title_en
                  title_ar
                  activityType{
                      type
                      title_en
                      title_ar
                  }
                  activityDivision{
                      id
                      title_en
                      title_ar
                  }
                  activityChapter{
                      id
                      chapter_code
                      title_en
                      title_ar                
                  }
              }
              template_id
              template{
                  id
                  keyword
                  notes
                  title_en
                  title_ar
              }
              unit_id
              unit{
                  unit_id
                  manual_unit_name
                  unit_custom_number
                  unit_custom_description
                  unit_zone
                  unit_cluster
                  unit_block
                  unitsextra{
                      units_extra_given_title
                      units_extra_key
                      units_extra_value
                  }
                  unitstemplates{
                      id
                      title_en
                      title_ar
                  }
              }
              work_level_id
              worklevel{
                  id
                  title_en
                  title_ar
                  description_en
                  description_ar
              }
              work_level_quantity
              worklevel_price
              worklevel_total_price
              work_level_ratio
              quantities{
                  writer_type
                  work_level_quantity
                  quantity_selected
                  writer{
                      id
                      name
                      email
                      mobile
                  }
              }
              attachment{
                  file_path
                  file_size
                  file_extension
                  title_en
                  title_ar
              }
              created_at
              updated_at
          }
      }
      transactionStages(transaction_id:\$transaction_id,page_no:1,page_size:15){
          status
          message
          paging {
              total
              currentPage
              lastPage
              from
              to
          }
          data{
              id
              position {
                  id
                  title_en
                  title_ar
              }
              writer{
                  id
                  name
                  email
                  mobile
              }
              stage_text
              stage_type
              step_name
              created_at
              updated_at
          }
      }
  }
  ''';

  static const String constructionPositions = '''
    query (\$searchKey: String){
        searchPositionsOnConstruction(searchKey: \$searchKey) {
            status
            message
            data{
                id
                title
            }
        }
    }    
  ''';

  static const String constructionUsers = '''
    query (\$searchKey: String){
        searchUsersOnConstruction(searchKey: \$searchKey) {
            status
            message
            data{
                id
                title
                email
                mobile
                photo
            }
        }
    }
  ''';

  static const String getStepUsers = '''
    query (
        \$project_id:String, 
        \$transaction_id: String,
        \$step:String) {
        getStepUsersBySteps(
            project_id:\$project_id,
            transaction_id: \$transaction_id,
            step:\$step) {
            status
            message
            assign_manual_user
            current_step
            current_step_name
            users{
                id
                user_id
                name    
                mobile
                email
                custom_user
                position
                position_title_en
                position_title_ar
            }
            system_users{
                user_id
                name
                mobile
                email
                position
                position_title_en
                position_title_ar
            }
            custom_users{
                id
                user_id
                name
                mobile
                email
                custom_user
                position
                position_title_en
                position_title_ar
            }
        }
    }
  ''';

  static const String addStepUsers = '''
    mutation (
    \$project_id:String, 
    \$transaction_id: String, 
    \$step:String, 
    \$userData:[UserRequestData]
    ) {
        assignTransactionStepUsers(
            project_id:\$project_id, 
            transaction_id: \$transaction_id, 
            step:\$step, 
            userData:\$userData
            ) {
            status
            message
        }
    }
  ''';
}