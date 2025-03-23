import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/data/responses/main/form/details/transaction_attachments/transaction_attachments.dart';
import 'package:teqani/data/responses/main/form/details/transaction_stages/transaction_stages.dart';
import 'package:teqani/data/responses/main/form/details/transaction_technical_assistance/transaction_technical_assistance.dart';
import 'package:teqani/data/responses/main/form/details/transaction_units_work_locations/transaction_units_work_locations.dart';
import 'package:teqani/domain/model/main/attachment_data.dart';
import 'package:teqani/domain/model/main/check_list.dart';
import 'package:teqani/domain/model/main/saudi_code.dart';
import 'package:teqani/domain/states/forms/wir/wir_steps_states.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/font_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/dialog/dialog_attachment.dart';
import 'package:teqani/presentation/ui/module/dialog/dialog_check_list.dart';
import 'package:teqani/presentation/ui/module/dialog/dialog_saudi_code.dart';
import 'package:teqani/presentation/ui/module/dialog/dialog_unit.dart';
import 'package:teqani/presentation/ui/module/form_users_position/form_users_position.dart';
import 'package:teqani/presentation/ui/module/loading_screen.dart';
import 'package:teqani/presentation/ui/module/view_no_data.dart';
import 'package:teqani/presentation/ui/module/wir_steps/item_chick_list.dart';
import 'package:teqani/presentation/ui/module/wir_steps/item_saudi_building.dart';
import 'package:teqani/presentation/ui/module/wir_steps/item_selected_chick_list.dart';
import 'package:teqani/presentation/ui/module/wir_steps/item_selected_saudi_building.dart';
import 'package:teqani/presentation/ui/module/wir_steps/item_stage_approval.dart';
import 'package:teqani/presentation/ui/module/wir_steps/item_step_attach.dart';
import 'package:teqani/presentation/ui/module/wir_steps/item_technical_attachment.dart';
import 'package:teqani/presentation/ui/module/wir_steps/item_unit.dart';

import 'wir_step_viewmodel.dart';

class WirStepView extends StatelessWidget {
  WirStepView({
    super.key,
    required this.isCurrentUser,
    required this.step,
    required this.stageData,
    required this.projectId,
    required this.formId,
    required this.formType,
    required this.isEdit,
    this.formUnits,
    this.technicalAssistance,
    this.attachments,
    required this.onRefresh,
  });

  final bool isCurrentUser;
  final int step;
  final TransactionStages? stageData;
  final int projectId;
  final int formId;
  final int formType;
  final bool isEdit;
  final Function onRefresh;

  final List<WorkData>? formUnits;

  final TransactionTechnicalAssistance? technicalAssistance;
  final TransactionAttachments? attachments;

  late WirStepViewmodel viewModel;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    return stageData == null || stageData!.data == null
        ? ViewNoData()
        : _getScreenContent();
  }

  Widget _getScreenContent() {
    bool firstBuild = true;
    return BlocProvider(
      create: (BuildContext context) => WirStepViewmodel(),
      child: BlocConsumer<WirStepViewmodel, WirStepsStates>(
        listener: (context, state) {
          if (state is WirStepsDataSuccessState) {
            onRefresh();
          }
        },
        builder: (context, state) {
          if (state is WirStepsDataLoadingState) {
            return Column(
              children: [
                LoadingScreen(),
              ],
            );
          }
          if (firstBuild) {
            WirStepViewmodel.get(context).start(step, formId, formType,
                stageData, formUnits, technicalAssistance, attachments);
            firstBuild = false;
          }
          viewModel = WirStepViewmodel.get(context);
          this.context = context;
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _getStepName(),
                        style: getMediumStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s14,
                        ),
                      ).tr(),
                    ),
                    Visibility(
                      visible: isCurrentUser,
                      child: GestureDetector(
                        onTap: () {
                          _showUsersDialog();
                        },
                        child: SvgPicture.asset(IconsAssets.addUserIcon),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppMargin.m16,
                ),
                isEdit ? _getEditContent() : _getViewContent(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _getViewContent() {
    return viewModel.stages.isEmpty
        ? ViewNoData()
        : step == 6
            ? _getTechnicalView()
            : ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) =>
                    ItemStageApproval(
                  stage: viewModel.stages[index],
                ),
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: AppMargin.m16,
                ),
                itemCount: viewModel.stages.length,
              );
  }

  Widget _getEditContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Approve and reject
        step == 9 || step == 10 || step < 6
            ? Column(
                children: [
                  const SizedBox(
                    height: AppMargin.m16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            viewModel.changeApprovalState(1);
                          },
                          child: Row(
                            spacing: AppMargin.m8,
                            children: [
                              Container(
                                width: AppSize.s24,
                                height: AppSize.s24,
                                decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(AppSize.s56)),
                                  border: viewModel.approvalStatus == 1
                                      ? Border.all(
                                          width: AppSize.s4,
                                          color: ColorManager.primary,
                                        )
                                      : Border.all(
                                          width: AppSize.s1,
                                          color: ColorManager.lightGrey,
                                        ),
                                ),
                              ),
                              Text(
                                step == 5
                                    ? AppStrings.reserve
                                    : AppStrings.approve,
                                style: getMediumStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s14,
                                ),
                              ).tr(),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            viewModel.changeApprovalState(0);
                          },
                          child: Row(
                            spacing: AppMargin.m8,
                            children: [
                              Container(
                                width: AppSize.s24,
                                height: AppSize.s24,
                                decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(AppSize.s56)),
                                  border: viewModel.approvalStatus == 0
                                      ? Border.all(
                                          width: AppSize.s4,
                                          color: ColorManager.primary,
                                        )
                                      : Border.all(
                                          width: AppSize.s1,
                                          color: ColorManager.lightGrey,
                                        ),
                                ),
                              ),
                              Text(
                                AppStrings.reject,
                                style: getMediumStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s14,
                                ),
                              ).tr(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : SizedBox(),
        // Note
        viewModel.approvalStatus == 0 || (step > 7 && step != 10 && step != 9)
            ? Column(
                children: [
                  const SizedBox(
                    height: AppMargin.m16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(AppSize.s8)),
                      border: Border.all(
                        width: AppSize.s1,
                        color: ColorManager.lightGrey,
                      ),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: viewModel.noteController,
                      maxLines: 5,
                      style: getRegularStyle(color: ColorManager.black),
                      decoration: InputDecoration(
                        hintText: AppStrings.note.tr(),
                        hintStyle: getRegularStyle(color: ColorManager.grey),
                        border: InputBorder.none,
                        fillColor: ColorManager.white,
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox(),
        // Unit Form
        step == 3
            ? Column(
                children: [
                  const SizedBox(
                    height: AppMargin.m16,
                  ),
                  GestureDetector(
                    onTap: () {
                      viewModel.changeRequireQaQc();
                    },
                    child: Row(
                      spacing: AppMargin.m8,
                      children: [
                        Container(
                          width: AppSize.s24,
                          height: AppSize.s24,
                          decoration: BoxDecoration(
                            color: viewModel.requireQAQC
                                ? ColorManager.primary
                                : ColorManager.white,
                            border: Border.all(
                              width: AppSize.s2,
                              color: viewModel.requireQAQC
                                  ? ColorManager.primary
                                  : ColorManager.lightGrey,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(AppSize.s8)),
                          ),
                          child: viewModel.requireQAQC
                              ? Center(
                                  child:
                                      SvgPicture.asset(IconsAssets.checkIcon),
                                )
                              : null,
                        ),
                        Text(
                          AppStrings.requireQaQc,
                          style: getMediumStyle(
                            color: ColorManager.black,
                          ),
                        ).tr(),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: viewModel.units.isEmpty,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: AppMargin.m16,
                        ),
                        Card(
                          elevation: AppSize.s05,
                          child: DialogUnit(
                            onSubmit: (unit) {
                              viewModel.addUnit(unit);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: viewModel.units.isNotEmpty,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: AppMargin.m16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                AppStrings.locations,
                                style: getMediumStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s14,
                                ),
                              ).tr(),
                            ),
                            Visibility(
                              visible: formType == 0,
                              child: GestureDetector(
                                onTap: () {
                                  _showUnitDialog();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(AppPadding.p8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(AppSize.s80)),
                                      color: ColorManager.primary),
                                  child: SvgPicture.asset(
                                    IconsAssets.addIcon,
                                    color: ColorManager.white,
                                    width: AppSize.s16,
                                    height: AppSize.s16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppMargin.m16,
                  ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) =>
                        ItemUnit(
                      unit: viewModel.units[index],
                      formType: formType,
                      onDelete: (unit) {
                        viewModel.deleteUnit(unit);
                      },
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: AppMargin.m8,
                    ),
                    itemCount: viewModel.units.length,
                  ),
                ],
              )
            : SizedBox(),
        // Require Owner
        step == 10
            ? Column(
                children: [
                  const SizedBox(
                    height: AppMargin.m16,
                  ),
                  GestureDetector(
                    onTap: () {
                      viewModel.changeOwnerStatus();
                    },
                    child: Row(
                      spacing: AppMargin.m8,
                      children: [
                        Container(
                          width: AppSize.s24,
                          height: AppSize.s24,
                          decoration: BoxDecoration(
                            color: viewModel.sendOwner
                                ? ColorManager.primary
                                : ColorManager.white,
                            border: Border.all(
                              width: AppSize.s2,
                              color: viewModel.sendOwner
                                  ? ColorManager.primary
                                  : ColorManager.lightGrey,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(AppSize.s8)),
                          ),
                          child: viewModel.sendOwner
                              ? Center(
                                  child:
                                      SvgPicture.asset(IconsAssets.checkIcon),
                                )
                              : null,
                        ),
                        Text(
                          AppStrings.sendToOwnerRepresentative,
                          style: getMediumStyle(
                            color: ColorManager.black,
                          ),
                        ).tr(),
                      ],
                    ),
                  ),
                ],
              )
            : SizedBox(),
        // Technical Edit View
        step == 6 ? _getTechnicalEdit() : SizedBox(),
        // Soil Test Edit View
        step == 7 ? _getSoilTestEdit() : SizedBox(),
        const SizedBox(
          height: AppMargin.m24,
        ),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              viewModel.confirmStep(context);
            },
            child: Text(
              AppStrings.submit,
              textAlign: TextAlign.center,
              style: getMediumStyle(
                color: ColorManager.white,
                fontSize: FontSize.s14,
              ),
            ).tr(),
          ),
        ),
        const SizedBox(
          height: AppMargin.m24,
        ),
      ],
    );
  }

  Widget _getTechnicalView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.checkLists,
          style: getMediumStyle(
            color: ColorManager.black,
            fontSize: FontSize.s14,
          ),
        ).tr(),
        const SizedBox(
          height: AppMargin.m8,
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => ItemChickList(
            technical: viewModel.checkLists[index],
          ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: AppMargin.m16,
          ),
          itemCount: viewModel.checkLists.length,
        ),
        const SizedBox(
          height: AppMargin.m24,
        ),
        Text(
          AppStrings.saudiBuildingCodes,
          style: getMediumStyle(
            color: ColorManager.black,
            fontSize: FontSize.s14,
          ),
        ).tr(),
        const SizedBox(
          height: AppMargin.m8,
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => ItemSaudiBuilding(
            technical: viewModel.saudiBuildings[index],
          ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: AppMargin.m16,
          ),
          itemCount: viewModel.saudiBuildings.length,
        ),
        const SizedBox(
          height: AppMargin.m24,
        ),
        Text(
          viewModel.isAllCheckListApproved()
              ? AppStrings.consultantRecommendations
              : AppStrings.consultantRemarks,
          style: getMediumStyle(
            color: ColorManager.black,
            fontSize: FontSize.s14,
          ),
        ).tr(),
        const SizedBox(
          height: AppMargin.m8,
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => ItemSaudiBuilding(
            technical: viewModel.consultantSays[index],
          ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: AppMargin.m16,
          ),
          itemCount: viewModel.consultantSays.length,
        ),
        const SizedBox(
          height: AppMargin.m24,
        ),
        Visibility(
          visible:
              attachments != null && viewModel.techAttachments.isNotEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.otherAttachments,
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s14,
                ),
              ).tr(),
              const SizedBox(
                height: AppMargin.m8,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) =>
                    ItemTechnicalAttachment(
                  attach: viewModel.techAttachments[index],
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(
                  height: AppMargin.m16,
                ),
                itemCount: viewModel.techAttachments.length,
              ),
              const SizedBox(
                height: AppMargin.m24,
              ),
            ],
          ),
        ),
        Text(
          AppStrings.technicalAssistant,
          style: getMediumStyle(
            color: ColorManager.black,
            fontSize: FontSize.s14,
          ),
        ).tr(),
        const SizedBox(
          height: AppMargin.m8,
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => ItemStageApproval(
            stage: viewModel.stages[index],
          ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: AppMargin.m16,
          ),
          itemCount: viewModel.stages.length,
        ),
        const SizedBox(
          height: AppMargin.m16,
        ),
      ],
    );
  }

  Widget _getTechnicalEdit() {
    return Column(
      children: [
        const SizedBox(
          height: AppMargin.m16,
        ),
        GestureDetector(
          onTap: () {
            viewModel.changeCustomCheckList();
          },
          child: Row(
            spacing: AppMargin.m8,
            children: [
              Container(
                width: AppSize.s24,
                height: AppSize.s24,
                decoration: BoxDecoration(
                  color: viewModel.needCustomCheckList
                      ? ColorManager.primary
                      : ColorManager.white,
                  border: Border.all(
                    width: AppSize.s2,
                    color: viewModel.needCustomCheckList
                        ? ColorManager.primary
                        : ColorManager.lightGrey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
                ),
                child: viewModel.needCustomCheckList
                    ? Center(
                        child: SvgPicture.asset(IconsAssets.checkIcon),
                      )
                    : null,
              ),
              Text(
                AppStrings.needCustomCheck,
                style: getMediumStyle(
                  color: ColorManager.black,
                ),
              ).tr(),
            ],
          ),
        ),
        const SizedBox(
          height: AppMargin.m16,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.checkLists,
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s14,
                ),
              ).tr(),
            ),
            GestureDetector(
              onTap: () {
                _openCheckListDialog();
              },
              child: Container(
                padding: EdgeInsets.all(AppPadding.p8),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppSize.s80)),
                    color: ColorManager.primary),
                child: SvgPicture.asset(
                  IconsAssets.addIcon,
                  color: ColorManager.white,
                  width: AppSize.s16,
                  height: AppSize.s16,
                ),
              ),
            ),
          ],
        ),
        viewModel.needCustomCheckList
        ? SizedBox()
        : Column(
          children: [
            const SizedBox(
              height: AppMargin.m8,
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) =>
                  ItemSelectedChickList(
                    checkList: viewModel.editCheckLists[index],
                    onEdit: (checkList) {
                      viewModel.editCheckList(checkList, true);
                    },
                    onDelete: (checkList) {
                      viewModel.deleteCheckList(checkList);
                    },
                  ),
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: AppMargin.m8,
              ),
              itemCount: viewModel.editCheckLists.length,
            ),
          ],
        ),
        const SizedBox(
          height: AppMargin.m8,
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) =>
              ItemSelectedChickList(
            checkList: viewModel.selectedCheckLists[index],
            onEdit: (checkList) {
              viewModel.editCheckList(checkList, false);
            },
            onDelete: (checkList) {
              viewModel.deleteCheckList(checkList);
            },
          ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: AppMargin.m8,
          ),
          itemCount: viewModel.selectedCheckLists.length,
        ),
        const SizedBox(
          height: AppMargin.m24,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.saudiBuildingCodes,
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s14,
                ),
              ).tr(),
            ),
            GestureDetector(
              onTap: () {
                _openSaudiCodeDialog(true);
              },
              child: Container(
                padding: EdgeInsets.all(AppPadding.p8),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppSize.s80)),
                    color: ColorManager.primary),
                child: SvgPicture.asset(
                  IconsAssets.addIcon,
                  color: ColorManager.white,
                  width: AppSize.s16,
                  height: AppSize.s16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppMargin.m8,
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) =>
              ItemSelectedSaudiBuilding(
            saudiCode: viewModel.selectedSaudiBuildings[index],
            onEdit: (saudiCode) {
              viewModel.editSaudiCode(saudiCode);
            },
            onDelete: (saudiCode) {
              viewModel.deleteSaudiCode(saudiCode);
            },
          ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: AppMargin.m8,
          ),
          itemCount: viewModel.selectedSaudiBuildings.length,
        ),
        const SizedBox(
          height: AppMargin.m24,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.consultantRecommendations,
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s14,
                ),
              ).tr(),
            ),
            GestureDetector(
              onTap: () {
                _openSaudiCodeDialog(false);
              },
              child: Container(
                padding: EdgeInsets.all(AppPadding.p8),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppSize.s80)),
                    color: ColorManager.primary),
                child: SvgPicture.asset(
                  IconsAssets.addIcon,
                  color: ColorManager.white,
                  width: AppSize.s16,
                  height: AppSize.s16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppMargin.m8,
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) =>
              ItemSelectedSaudiBuilding(
            saudiCode: viewModel.selectedConsultantSays[index],
            onEdit: (consultantSays) {
              viewModel.editConsultant(consultantSays);
            },
            onDelete: (consultantSays) {
              viewModel.deleteConsultant(consultantSays);
            },
          ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: AppMargin.m8,
          ),
          itemCount: viewModel.selectedConsultantSays.length,
        ),
        const SizedBox(
          height: AppMargin.m24,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.locations,
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s14,
                ),
              ).tr(),
            ),
            Visibility(
              visible: formType == 0,
              child: GestureDetector(
                onTap: () {
                  _showUnitDialog();
                },
                child: Container(
                  padding: EdgeInsets.all(AppPadding.p8),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(AppSize.s80)),
                      color: ColorManager.primary),
                  child: SvgPicture.asset(
                    IconsAssets.addIcon,
                    color: ColorManager.white,
                    width: AppSize.s16,
                    height: AppSize.s16,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppMargin.m16,
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => ItemUnit(
            unit: viewModel.units[index],
            formType: formType,
            onDelete: (unit) {
              viewModel.deleteUnit(unit);
            },
          ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: AppMargin.m8,
          ),
          itemCount: viewModel.units.length,
        ),
        _getAttachmentEdit(),
        const SizedBox(
          height: AppMargin.m24,
        ),
        GestureDetector(
          onTap: () {
            viewModel.changeNeedSpecial();
          },
          child: Row(
            spacing: AppMargin.m8,
            children: [
              Container(
                width: AppSize.s24,
                height: AppSize.s24,
                decoration: BoxDecoration(
                  color: viewModel.needSpecialApproval
                      ? ColorManager.primary
                      : ColorManager.white,
                  border: Border.all(
                    width: AppSize.s2,
                    color: viewModel.needSpecialApproval
                        ? ColorManager.primary
                        : ColorManager.lightGrey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
                ),
                child: viewModel.needSpecialApproval
                    ? Center(
                        child: SvgPicture.asset(IconsAssets.checkIcon),
                      )
                    : null,
              ),
              Text(
                AppStrings.specialApproveRequired,
                style: getMediumStyle(
                  color: ColorManager.black,
                ),
              ).tr(),
            ],
          ),
        ),
        viewModel.needSpecialApproval
            ? Column(
                children: [
                  const SizedBox(
                    height: AppMargin.m16,
                  ),
                  FormUsersPosition(
                    projectId: projectId,
                    transactionId: formId,
                    step: step,
                    stepName: null,
                    isTech: true,
                    onAdd: (positionUsers){viewModel.addPositionUsers(positionUsers);},
                    onDelete: (positionUsers){viewModel.addPositionUsers(positionUsers);},
                  ),
                ]
            )
            : SizedBox(),
      ],
    );
  }

  Widget _getSoilTestEdit() {
    return Column(
      spacing: AppMargin.m16,
      children: [
        const SizedBox(),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
            border: Border.all(
              color: ColorManager.lightGrey,
              width: AppSize.s1,
            ),
          ),
          child: PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            icon: Row(
              children: [
                Expanded(
                  child: Text(
                    viewModel.reportType ?? AppStrings.selectReportType,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: viewModel.reportType != null
                        ? getMediumStyle(
                            color: ColorManager.black,
                          )
                        : getRegularStyle(
                            color: ColorManager.grey,
                          ),
                  ).tr(),
                ),
                SvgPicture.asset(IconsAssets.arrowDownIcon),
              ],
            ),
            color: ColorManager.white,
            onSelected: (String type) {
              viewModel.changeReportType(type);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              for (var type in viewModel.getReportTypes())
                PopupMenuItem<String>(
                  value: type,
                  child: Text(
                    type,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s12,
                    ),
                  ).tr(),
                ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
            border: Border.all(
              color: ColorManager.lightGrey,
              width: AppSize.s1,
            ),
          ),
          child: PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            icon: Row(
              children: [
                Expanded(
                  child: Text(
                    viewModel.testResult ?? AppStrings.selectTestResult,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: viewModel.testResult != null
                        ? getMediumStyle(
                            color: ColorManager.black,
                          )
                        : getRegularStyle(
                            color: ColorManager.grey,
                          ),
                  ).tr(),
                ),
                SvgPicture.asset(IconsAssets.arrowDownIcon),
              ],
            ),
            color: ColorManager.white,
            onSelected: (String result) {
              viewModel.changeTestResult(result);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              for (var result in viewModel.getTestResults())
                PopupMenuItem<String>(
                  value: result,
                  child: Text(
                    result,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s12,
                    ),
                  ).tr(),
                ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
            border: Border.all(
              width: AppSize.s1,
              color: ColorManager.lightGrey,
            ),
          ),
          child: TextFormField(
            keyboardType: TextInputType.text,
            controller: viewModel.soilNoteController,
            maxLines: 5,
            style: getRegularStyle(color: ColorManager.black),
            decoration: InputDecoration(
              hintText: AppStrings.note.tr(),
              hintStyle: getRegularStyle(color: ColorManager.grey),
              border: InputBorder.none,
              fillColor: ColorManager.white,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
            border: Border.all(
              width: AppSize.s1,
              color: ColorManager.lightGrey,
            ),
          ),
          child: TextFormField(
            keyboardType: TextInputType.text,
            controller: viewModel.reportController,
            maxLines: 1,
            style: getRegularStyle(color: ColorManager.black),
            decoration: InputDecoration(
              hintText: AppStrings.reportNumber.tr(),
              hintStyle: getRegularStyle(color: ColorManager.grey),
              border: InputBorder.none,
              fillColor: ColorManager.white,
            ),
          ),
        ),
        _getAttachmentEdit()
      ],
    );
  }

  String _getStepName() {
    String name = '';
    switch (step) {
      case 2:
        name = AppStrings.contractorTeamApproval;
      case 3:
        name = AppStrings.contractorManagerApproval;
      case 4:
        name = AppStrings.contractorQAQCApproval;
      case 5:
        name = AppStrings.recipientVerification;
      case 6:
        name = AppStrings.technicalAssistant;
      case 7:
        name = AppStrings.soilTest;
      case 8:
        name = AppStrings.specialApproval;
      case 9:
        name = AppStrings.authorizedPositions;
      case 10:
        name = AppStrings.consultantManager;
      case 11:
        name = AppStrings.ownerRepresentative;
      case 12:
        name = AppStrings.PMCGroup;
      case 13:
        name = AppStrings.resultReceiving;
    }
    return name;
  }

  Widget _getAttachmentEdit() {
    return Column(
      spacing: AppMargin.m16,
      children: [
        const SizedBox(),
        Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.attachments,
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s14,
                ),
              ).tr(),
            ),
            GestureDetector(
              onTap: () {
                _showAttachmentsDialog();
              },
              child: Container(
                padding: EdgeInsets.all(AppPadding.p8),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppSize.s80)),
                    color: ColorManager.primary),
                child: SvgPicture.asset(
                  IconsAssets.addIcon,
                  color: ColorManager.white,
                  width: AppSize.s16,
                  height: AppSize.s16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppMargin.m16,
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => ItemStepAttach(
            attachmentData: viewModel.stepAttachments[index],
            onDelete: (attach) {
              viewModel.deleteAttachment(attach);
            },
          ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: AppMargin.m8,
          ),
          itemCount: viewModel.stepAttachments.length,
        ),
      ],
    );
  }

  void _showAttachmentsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s16),
          ),
          backgroundColor: ColorManager.white,
          child: DialogAttachment(
            onSubmit: (attach) {
              Navigator.pop(context);
              viewModel.addAttachment(attach);
            },
          ),
        );
      },
    );
  }

  void _showUnitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s16),
          ),
          backgroundColor: ColorManager.white,
          child: DialogUnit(
            onSubmit: (unit) {
              Navigator.pop(context);
              viewModel.addUnit(unit);
            },
          ),
        );
      },
    );
  }

  void _showUsersDialog() {
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
            step: step,
            stepName: null,
            isTech: false,
          ),
        );
      },
    );
  }

  void _openCheckListDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s16),
          ),
          backgroundColor: ColorManager.white,
          child: DialogCheckList(
            onSubmit: (checkList) {
              Navigator.pop(context);
              viewModel.addCheckList(checkList);
            },
          ),
        );
      },
    );
  }

  void _openSaudiCodeDialog(bool isSaudi) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s16),
          ),
          backgroundColor: ColorManager.white,
          child: DialogSaudiCode(
            onSubmit: (object) {
              Navigator.pop(context);
              if (isSaudi) {
                viewModel.addSaudiCode(object);
              } else {
                viewModel.addConsultant(object);
              }
            },
          ),
        );
      },
    );
  }
}
