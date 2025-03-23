import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/data/responses/main/dashboard/dashboard_response.dart';
import 'package:teqani/domain/model/main/dashboard_tap.dart';
import 'package:teqani/domain/states/forms/wir/wir_form_states.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/font_manager.dart';
import 'package:teqani/presentation/resources/local_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/main/wir_form/wir_form_viewmodel.dart';
import 'package:teqani/presentation/ui/module/loading_screen.dart';
import 'package:teqani/presentation/ui/module/module.dart';
import 'package:teqani/presentation/ui/module/view_no_data.dart';

import 'wir_info/history.dart';
import 'wir_info/notes.dart';
import 'wir_info/unit_details/unit_details.dart';
import 'wir_info/work_details.dart';
import 'wir_step/wir_step_view.dart';

class WIRFormScreen extends StatelessWidget {
  const WIRFormScreen({super.key, required this.form});

  final AppForm form;

  @override
  Widget build(BuildContext context) {
    print("Project Id: ${form.projectId}, form id: ${form.id}");
    print("Token: ${AppPreferences.getUserToken()}");
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: BlocProvider(
        create: (BuildContext context) =>
            WIRFormViewModel()..start(context, form),
        child: BlocConsumer<WIRFormViewModel, WIRFormStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is WIRFormLoadingState) {
              return Column(
                children: [
                  LoadingScreen(),
                ],
              );
            } else {
              final WIRFormViewModel viewModel = WIRFormViewModel.get(context);
              return _getScreenContent(context, state, viewModel);
            }
          },
        ),
      ),
    );
  }

  Widget _getScreenContent(
      BuildContext context, WIRFormStates state, WIRFormViewModel viewModel) {
    String lang = AppPreferences.getAppLanguage();
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppPadding.p64,
        start: AppPadding.p24,
        end: AppPadding.p24,
      ),
      child: Column(
        children: [
          Row(
            spacing: AppMargin.m8,
            children: [
              Container(
                width: AppSize.s32,
                height: AppSize.s32,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppSize.s8),
                  border: Border.all(
                    width: AppSize.s1_5,
                    color: ColorManager.lightGrey,
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(IconsAssets.backIcon),
                ),
              ),
              Expanded(
                child: form.activity == null
                    ? Text(
                        form.id.toString(),
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s18,
                        ),
                      )
                    : Row(
                        spacing: AppMargin.m8,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            form.activity!.activityCode ?? '',
                            style: getMediumStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s18,
                            ),
                          ),
                          Container(
                            width: AppSize.s1_5,
                            height: AppSize.s16,
                            decoration: BoxDecoration(
                              color: ColorManager.lightGrey,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              lang == LanguageType.ENGLISH.getValue()
                                  ? form.activity!.titleEn ?? ''
                                  : form.activity!.titleAr ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: getMediumStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s18,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
          state is WIRFormErrorState
              ? ViewNoData()
              : Expanded(
                child: Column(
                    children: [
                      const SizedBox(
                        height: AppMargin.m16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: ClampingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) =>
                                  Module.tapItem(
                                context,
                                viewModel.taps[index],
                                (id) {
                                  viewModel.changeTap(id);
                                },
                                width: (MediaQuery.of(context).size.width -
                                        AppMargin.m48) /
                                    (viewModel.taps.length + 1),
                              ),
                              itemCount: viewModel.taps.length,
                            ),
                            viewModel.steps.isNotEmpty
                                ? Expanded(
                                    child: PopupMenuButton<DashboardTap>(
                                      padding: EdgeInsets.zero,
                                      icon: Column(
                                        spacing: AppMargin.m16,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  viewModel.selectedStep,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: viewModel.currentTap > 1
                                                      ? getMediumStyle(
                                                          color:
                                                              ColorManager.black,
                                                          fontSize: FontSize.s14,
                                                        )
                                                      : getRegularStyle(
                                                          color:
                                                              ColorManager.grey,
                                                          fontSize: FontSize.s14,
                                                        ),
                                                ).tr(),
                                              ),
                                              SvgPicture.asset(
                                                  IconsAssets.arrowDownIcon),
                                            ],
                                          ),
                                          Container(
                                            height: AppSize.s1,
                                            color: viewModel.currentTap > 1
                                                ? ColorManager.black
                                                : ColorManager.grey,
                                          ),
                                        ],
                                      ),
                                      color: ColorManager.white,
                                      onSelected: (DashboardTap tap) {
                                        viewModel.changeTap(tap.id);
                                      },
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<DashboardTap>>[
                                        for (var tap in viewModel.steps)
                                          PopupMenuItem<DashboardTap>(
                                            value: tap,
                                            child: Row(
                                              spacing: AppPadding.p8,
                                              children: [
                                                if (tap.id < 14)
                                                  SvgPicture.asset(viewModel
                                                              .formStep ==
                                                          tap.id
                                                      ? IconsAssets.currentIcon
                                                      : viewModel.getStageStatus(
                                                              tap.id)
                                                          ? IconsAssets.doneIcon
                                                          : viewModel.formStep >
                                                                  tap.id
                                                              ? IconsAssets
                                                                  .restrictIcon
                                                              : IconsAssets
                                                                  .waitingIcon),
                                                Text(
                                                  tap.name,
                                                  textAlign: TextAlign.center,
                                                  style: getMediumStyle(
                                                    color: ColorManager.black,
                                                    fontSize: FontSize.s12,
                                                  ),
                                                ).tr(),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: AppMargin.m16,
                      ),
                      Expanded(
                        child: _getStep(viewModel),
                      ),
                    ],
                  ),
              )
        ],
      ),
    );
  }

  Widget _getStep(WIRFormViewModel viewModel) {
    switch (viewModel.currentTap) {
      case 0:
        return WorkDetails(
          formDetailsResponse: viewModel.formDetailsResponse!,
        );
      case 1:
        return UnitDetails(
          formDetailsResponse: viewModel.formDetailsResponse!,
        );
      case 14:
        return Notes(
          notes: viewModel.formDetailsResponse!.transactionNotes!.data ?? [],
        );
      case 15:
        return History(
          history:
              viewModel.formDetailsResponse!.transactionRecords!.data ?? [],
        );
      default:
        return WirStepView(
          isCurrentUser: _isCurrentUser(viewModel),
          step: viewModel.currentTap,
          stageData: viewModel.formDetailsResponse!.transactionStages,
          projectId: form.projectId ?? 0,
          formId: form.id ?? 0,
          formType: viewModel.wirFromType,
          isEdit: _getStepEdit(viewModel),
          formUnits: viewModel
              .formDetailsResponse!.transactionUnitsWorkLocations!.data,
          technicalAssistance:
              viewModel.formDetailsResponse!.transactionTechnicalAssistance,
          attachments: viewModel.formDetailsResponse!.transactionAttachments,
          onRefresh: () {
            viewModel.refreshForm();
          },
        );
    }
  }

  bool _getStepEdit(WIRFormViewModel viewModel) {
    switch (viewModel.currentTap) {
      case 2:
        return viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .contractorTeamApproval ??
            false;
      case 3:
        return viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .contractorManagerApproval ??
            false;
      case 4:
        return viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .contractorQaqcApproval ??
            false;
      case 5:
        return viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .recipientVerification ??
            false;
      case 6:
        return viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .technicalAssistant ??
            false;
      case 7:
        return viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .soilTestWitnessResult ??
            false;
      case 8:
        return viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .specialApproval ??
            false;
      case 9:
        return viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .authorizedPositionsApproval ??
            false;
      case 10:
        return viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .managerApproval ??
            false;
      case 11:
        return viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .ownersRepresentative ??
            false;
      case 12:
        return viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .pmcApproval ??
            false;
      case 13:
        return viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .resultReceiving ??
            false;
    }
    return false;
  }

  bool _isCurrentUser(WIRFormViewModel viewModel) {
    if (viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!.contractorTeamApproval == true ||
        viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .contractorManagerApproval ==
            true ||
        viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .contractorQaqcApproval ==
            true ||
        viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .recipientVerification ==
            true ||
        viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .technicalAssistant ==
            true ||
        viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .soilTestWitnessResult ==
            true ||
        viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!.specialApproval ==
            true ||
        viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .authorizedPositionsApproval ==
            true ||
        viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .managerApproval ==
            true ||
        viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .ownersRepresentative ==
            true ||
        viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .pmcApproval ==
            true ||
        viewModel.formDetailsResponse!.transactionWIRActionButtons!.edit!
                .resultReceiving ==
            true) {
      return true;
    }
    return false;
  }
}
