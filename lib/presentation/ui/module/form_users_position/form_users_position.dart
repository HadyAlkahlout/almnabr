import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:teqani/data/responses/main/positions/positions_response.dart';
import 'package:teqani/data/responses/main/users/users_response.dart';
import 'package:teqani/domain/model/main/position_users.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/font_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/form_users_position/form_users_viewmodel.dart';
import 'package:teqani/presentation/ui/module/loading_screen.dart';
import 'package:teqani/presentation/ui/module/module.dart';

class FormUsersPosition extends StatelessWidget {
  const FormUsersPosition({
    super.key,
    required this.projectId,
    required this.transactionId,
    required this.step,
    required this.stepName,
    required this.isTech,
    this.onAdd,
    this.onDelete,
  });

  final int projectId;
  final int transactionId;
  final int step;
  final String? stepName;
  final bool isTech;

  final Function(PositionUsers positionUsers)? onAdd;
  final Function(PositionUsers positionUsers)? onDelete;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FormUsersViewModel()..start(),
      child: BlocConsumer<FormUsersViewModel, FormUsersStates>(
        listener: (context, state) {
          if (state is FormConfirmSuccessStates) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final FormUsersViewModel viewModel = FormUsersViewModel.get(context);
          if (state is FormConfirmLoadingStates) {
            return LoadingScreen();
          }
          return _getScreenContent(context, state, viewModel);
        },
      ),
    );
  }

  Widget _getScreenContent(BuildContext context, FormUsersStates state,
      FormUsersViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p8,
        vertical: AppPadding.p16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: AppMargin.m4,
            children: [
              isTech ? SizedBox() : Text(
                stepName ?? _getStepName().tr(),
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s14,
                ),
              ),
              Text(
                '(${AppStrings.users.tr()})',
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s14,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppMargin.m16,
          ),
          Card(
            elevation: AppSize.s05,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p8,
              ),
              child: PopupMenuButton<PositionData>(
                padding: EdgeInsets.zero,
                icon: Row(
                  children: [
                    Expanded(
                      child: viewModel.selectedPosition.id != null
                          ? Text(
                              viewModel.selectedPosition.title ?? 'N/A',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: getMediumStyle(
                                color: ColorManager.black,
                              ),
                            )
                          : Text(
                              AppStrings.selectPosition,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: getRegularStyle(
                                color: ColorManager.grey,
                              ),
                            ).tr(),
                    ),
                    SvgPicture.asset(IconsAssets.arrowDownIcon),
                  ],
                ),
                color: ColorManager.white,
                onSelected: (PositionData position) {
                  viewModel.changeSelectedPosition(position);
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<PositionData>>[
                  for (var position in viewModel.positions)
                    PopupMenuItem<PositionData>(
                      value: position,
                      child: Text(
                        position.title ?? '',
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: AppMargin.m16,
          ),
          Row(
            spacing: AppMargin.m4,
            children: [
              Expanded(
                child: Card(
                  elevation: AppSize.s05,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p8,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: viewModel.searchController,
                          maxLines: 1,
                          style: getRegularStyle(color: ColorManager.grey),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: AppStrings.searchUser.tr(),
                            hintStyle: getRegularStyle(
                              color: ColorManager.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppMargin.m8,
                        ),
                        ListView.separated(
                          physics: ClampingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) =>
                              GestureDetector(
                                onTap: (){
                                  viewModel.addUser(viewModel.users[index]);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(AppPadding.p8),
                                  decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          viewModel.users[index].title ?? 'N/A',
                                          style: getMediumStyle(
                                            color: ColorManager.black,
                                          ),
                                        ),
                                      ),
                                      SvgPicture.asset(IconsAssets.addIcon, width: AppSize.s12, height: AppSize.s12,),
                                    ],
                                  ),
                                ),
                              ),
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                                height: AppMargin.m16,
                              ),
                          itemCount: viewModel.users.length,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  viewModel.addPositionUsers(onAdd);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: AppPadding.p8,
                    horizontal: AppPadding.p8,
                  ),
                  decoration: BoxDecoration(
                      color: viewModel.canAdd ? ColorManager.primary : ColorManager.grey,
                      borderRadius:
                          BorderRadius.all(Radius.circular(AppSize.s8))),
                  child: SvgPicture.asset(
                    IconsAssets.addIcon,
                    width: AppSize.s20,
                    color: ColorManager.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppMargin.m4,
          ),
          SizedBox(
            height: AppSize.s32,
            child: ListView.separated(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) =>
                  Container(
                    padding: EdgeInsets.all(AppPadding.p8),
                    decoration: BoxDecoration(
                        color: ColorManager.lightGrey,
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.s8))),
                    child: Row(
                      children: [
                        Text(
                          viewModel.selectedUsers[index].title ?? 'N/A',
                          style: getMediumStyle(
                            color: ColorManager.black,
                          ),
                        ),
                        const SizedBox(
                          width: AppMargin.m8,
                        ),
                        GestureDetector(
                          onTap: (){
                            viewModel.deleteUser(viewModel.selectedUsers[index]);
                          },
                          child: SvgPicture.asset(IconsAssets.xIcon, width: AppSize.s12, height: AppSize.s12,),
                        ),
                      ],
                    ),
                  ),
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(
                    height: AppMargin.m16,
                  ),
              itemCount: viewModel.selectedUsers.length,
            ),
          ),
          const SizedBox(
            height: AppMargin.m16,
          ),
          ListView.separated(
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => ItemPositionUsers(
              positionUsers: viewModel.selectedPositionUsers[index],
              onDelete: (item) {
                if(onDelete != null) onDelete!(item);
                viewModel.deletePositionUsers(item);
              },
            ),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: AppMargin.m16,
            ),
            itemCount: viewModel.selectedPositionUsers.length,
          ),
          isTech
          ? SizedBox()
          : Column(
            children: [
              Visibility(
                visible: stepName == null,
                child: Column(
                  children: [
                    const SizedBox(
                      height: AppMargin.m16,
                    ),
                    GestureDetector(
                      onTap: () {
                        viewModel.changeAllTransactions();
                      },
                      child: Row(
                        spacing: AppMargin.m8,
                        children: [
                          Container(
                            width: AppSize.s24,
                            height: AppSize.s24,
                            decoration: BoxDecoration(
                              color: viewModel.allTransactions
                                  ? ColorManager.primary
                                  : ColorManager.white,
                              border: Border.all(
                                width: AppSize.s2,
                                color: viewModel.allTransactions
                                    ? ColorManager.primary
                                    : ColorManager.lightGrey,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
                            ),
                            child: viewModel.allTransactions
                                ? Center(
                              child: SvgPicture.asset(IconsAssets.checkIcon),
                            )
                                : null,
                          ),
                          Text(
                            AppStrings.assignFutureTransactions,
                            style: getMediumStyle(
                              color: ColorManager.black,
                            ),
                          ).tr(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppMargin.m24,
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: ElevatedButton(
                  onPressed: () {
                    viewModel.confirm(projectId, transactionId, step, stepName);
                  },
                  child: Text(
                    AppStrings.confirm,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: ColorManager.white,
                    ),
                  ).tr(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getStepName() {
    String name = '';
    print(step);
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
}

class ItemPositionUsers extends StatelessWidget {
  const ItemPositionUsers({
    super.key,
    required this.positionUsers,
    required this.onDelete,
  });

  final PositionUsers positionUsers;
  final Function(PositionUsers) onDelete;

  @override
  Widget build(BuildContext context) {
    String names = '';
    positionUsers.users.forEach((user) {
      names = '$names${user.title}, ';
    });
    return Module.appCard(
      child: Column(
        spacing: AppMargin.m8,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.position,
                  textAlign: TextAlign.center,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
              ),
              Expanded(
                child: Text(
                  AppStrings.users,
                  textAlign: TextAlign.center,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
              ),
              Expanded(
                child: Text(
                  AppStrings.actions,
                  textAlign: TextAlign.center,
                  style: getMediumStyle(
                    color: ColorManager.black,
                  ),
                ).tr(),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  positionUsers.position.title ?? 'N/A',
                  textAlign: TextAlign.center,
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  names,
                  textAlign: TextAlign.center,
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  spacing: AppMargin.m4,
                  children: [
                    GestureDetector(
                      onTap: () {
                        onDelete(positionUsers);
                      },
                      child: SvgPicture.asset(
                        IconsAssets.deleteIcon,
                        color: ColorManager.error,
                        width: AppSize.s24,
                        height: AppSize.s24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
