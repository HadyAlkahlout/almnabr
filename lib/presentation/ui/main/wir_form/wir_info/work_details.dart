import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/data/responses/main/form/details/form_details_response.dart';
import 'package:teqani/data/responses/main/form/details/transaction_details/transaction_details.dart';
import 'package:teqani/data/responses/main/form/details/transaction_persons/transaction_persons.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/local_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/form_users_position/form_users_position.dart';
import 'package:teqani/presentation/ui/module/module.dart';

class WorkDetails extends StatelessWidget {
  const WorkDetails({super.key, required this.formDetailsResponse});

  final FormDetailsResponse formDetailsResponse;

  @override
  Widget build(BuildContext context) {
    TransactionData data = formDetailsResponse.transactionDetails!.data![0];
    String lang = AppPreferences.getAppLanguage();
    return SingleChildScrollView(
      child: Column(
        spacing: AppMargin.m16,
        children: [
          Module.appCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.m8,
              children: [
                Text(
                  AppStrings.projectTitle,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
                Text(
                  data.project!.name ?? '',
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
          ),
          Module.appCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.m8,
              children: [
                Text(
                  AppStrings.consultant,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
                Text(
                  data.transactionToCompany!.contractorName ?? '',
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
          ),
          Module.appCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.m8,
              children: [
                Text(
                  AppStrings.developer,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
                Text(
                  _getDeveloperName(),
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
          ),
          Module.appCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.m8,
              children: [
                Text(
                  AppStrings.contractor,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
                Text(
                  data.transactionFromCompany!.contractorName ?? '',
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
          ),
          Module.appCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.m8,
              children: [
                Text(
                  AppStrings.subContractors,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
                Text(
                  'N/A',
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
          ),
          Module.appCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.m8,
              children: [
                Text(
                  AppStrings.activityCode,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
                Text(
                  data.activity != null
                      ? data.activity!.activityCode ?? ''
                      : '',
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
          ),
          Module.appCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.m8,
              children: [
                Text(
                  AppStrings.title,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
                Text(
                  data.activity != null
                      ? lang == ARABIC
                          ? data.activity!.titleAr ?? 'N/A'
                          : data.activity!.titleEn ?? 'N/A'
                      : 'N/A',
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
          ),
          Module.appCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.m8,
              children: [
                Text(
                  AppStrings.locations,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
                Text(
                  data.units ?? 'N/A',
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
          ),
          Module.appCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.m8,
              children: [
                Text(
                  AppStrings.division,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
                Text(
                  data.activity != null &&
                          data.activity!.activityDivision != null
                      ? lang == ARABIC
                          ? data.activity!.activityDivision!.titleAr ?? 'N/A'
                          : data.activity!.activityDivision!.titleEn ?? 'N/A'
                      : 'N/A',
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
          ),
          Module.appCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.m8,
              children: [
                Text(
                  AppStrings.chapter,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
                Text(
                  data.activity != null &&
                          data.activity!.activityChapter != null
                      ? lang == ARABIC
                          ? data.activity!.activityChapter!.titleAr ?? 'N/A'
                          : data.activity!.activityChapter!.titleEn ?? 'N/A'
                      : 'N/A',
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
          ),
          Module.appCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.m8,
              children: [
                Text(
                  AppStrings.currentStep,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
                Text(
                  _getStepName(data.lastStepName ?? ''),
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
          ),
          Module.appCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.m8,
              children: [
                Text(
                  AppStrings.currentStepUsers,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
                data.lastStepName == 'completed'
                    ? Text(
                        _getCurrentStepUsers(
                            formDetailsResponse.transactionPersons!.data!),
                        style: getRegularStyle(
                          color: ColorManager.black,
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Text(
                              _getCurrentStepUsers(formDetailsResponse
                                  .transactionPersons!.data!),
                              style: getRegularStyle(
                                color: ColorManager.black,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('edit');
                              _editCurrentUser(
                                context,
                                data.projectId!,
                                data.id!,
                                data.lastStepName ?? '',
                              );
                            },
                            child: SvgPicture.asset(
                              IconsAssets.editIcon,
                              color: ColorManager.primary,
                              width: AppSize.s16,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
          Module.appCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppMargin.m8,
              children: [
                Text(
                  AppStrings.evaluationResult,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
                Text(
                  data.evaluationResult ?? 'N/A',
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(),
        ],
      ),
    );
  }

  String _getDeveloperName() {
    String developer = 'N/A';
    for (var company in formDetailsResponse.transactionCompanies!.data!) {
      if (company.companyPositions != null) {
        if (company.companyPositions!.keyword == 'project_developer') {
          developer = company.company!.contractorName ?? 'N/A';
          return developer;
        }
      }
    }
    return developer;
  }

  String _getStepName(String stepCode) {
    String stepName = 'N/A';
    switch (stepCode) {
      case 'configurations':
        {
          stepName = 'Configurations';
        }
      case 'contractor_team_approval':
        {
          stepName = 'Contractor Team Approval';
        }
      case 'contractor_manager_approval':
        {
          stepName = 'Contractor Manager Approval';
        }
      case 'contractor_qaqc_approval':
        {
          stepName = 'Contractor QAQC Approval';
        }
      case 'recipient_verification':
        {
          stepName = 'Recipient Verification';
        }
      case 'technical_assistant':
        {
          stepName = 'Technical Assistant';
        }
      case 'soil_test_witness_result':
        {
          stepName = 'Soil Test Result';
        }
      case 'special_approval':
        {
          stepName = 'Special Approval';
        }
      case 'authorized_positions_approval':
        {
          stepName = 'Authorized Positions Approval';
        }
      case 'manager_approval':
        {
          stepName = 'Manager Approval';
        }
      case 'owners_representative':
        {
          stepName = 'Owners Representative';
        }
      case 'pmc_approval':
        {
          stepName = 'PMC Approval';
        }
      case 'result_receiving':
        {
          stepName = 'Result Receiving';
        }
    }

    return stepName;
  }

  String _getCurrentStepUsers(List<Person> persons) {
    String users = 'N/A';
    TransactionData data = formDetailsResponse.transactionDetails!.data![0];
    for (var user in persons) {
      if (user.stepName! == (data.lastStepName ?? '')) {
        if (user.approvedStatus == true || user.viewedStatus == true) {
          if (users == 'N/A') {
            users = user.user!.name ?? '';
          } else {
            users = '$users, ${user.user!.name ?? ''}';
          }
        }
      }
    }
    return users;
  }

  void _editCurrentUser(
      BuildContext context, int projectId, int formId, String step) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s16),
          ),
          backgroundColor: ColorManager.white,
          child: FormUsersPosition(
            projectId: projectId,
            transactionId: formId,
            step: 0,
            stepName: step,
            isTech: false,
          ),
        );
      },
    );
  }
}
