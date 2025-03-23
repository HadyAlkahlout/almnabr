import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/app/helper.dart';
import 'package:teqani/data/network/app_requests/wir_requests.dart';
import 'package:teqani/data/responses/main/form/details/form_details_response.dart';
import 'package:teqani/data/responses/main/form/details/transaction_attachments/transaction_attachments.dart';
import 'package:teqani/data/responses/main/form/details/transaction_details/transaction_details.dart';
import 'package:teqani/data/responses/main/form/previous_versions/previous_versions_response.dart';
import 'package:teqani/data/responses/main/form/related_activities/related_activities_response.dart';
import 'package:teqani/domain/model/main/dashboard_tap.dart';
import 'package:teqani/presentation/resources/assets_manager.dart';
import 'package:teqani/presentation/resources/color_manager.dart';
import 'package:teqani/presentation/resources/routes_manager.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';
import 'package:teqani/presentation/resources/style_manager.dart';
import 'package:teqani/presentation/resources/value_manager.dart';
import 'package:teqani/presentation/ui/module/wir_steps/item_attachment.dart';
import 'package:teqani/presentation/ui/module/wir_steps/item_form_version.dart';
import 'package:teqani/presentation/ui/module/wir_steps/item_related_forms.dart';
import 'package:teqani/presentation/ui/module/loading_screen.dart';
import 'package:teqani/presentation/ui/module/module.dart';
import 'package:teqani/presentation/ui/module/open_file.dart';
import 'package:teqani/presentation/ui/module/view_no_data.dart';

import 'unit_detail_viewmodel.dart';

class UnitDetails extends StatelessWidget {
  const UnitDetails({super.key, required this.formDetailsResponse});

  final FormDetailsResponse formDetailsResponse;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      UnitDetailViewModel()..start(formDetailsResponse),
      child: BlocConsumer<UnitDetailViewModel, UnitDetailStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final UnitDetailViewModel viewModel = UnitDetailViewModel.get(context);
          return _getScreenContent(state, viewModel);
        },
      ),
    );
  }

  Widget _getScreenContent(UnitDetailStates state,
      UnitDetailViewModel viewModel) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(AppSize.s16),
            border: Border.all(
              width: AppSize.s1_5,
              color: ColorManager.lightGrey,
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: AppPadding.p8,
            horizontal: AppPadding.p16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppMargin.m4,
            children: [
              Text(
                AppStrings.unitCode,
                style: getMediumStyle(color: ColorManager.black),
              ).tr(),
              DropdownButton<String>(
                value: viewModel.unit,
                padding: EdgeInsets.zero,
                dropdownColor: ColorManager.white,
                style: getRegularStyle(color: ColorManager.black),
                underline: SizedBox(),
                isExpanded: true,
                onChanged: (String? value) {
                  viewModel.changeUnit(value);
                },
                items: viewModel.units.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: getRegularStyle(color: ColorManager.black),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: AppMargin.m8,
        ),
        Row(
          spacing: AppMargin.m8,
          children: [
            Expanded(
              child: Module.appCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppMargin.m8,
                  children: [
                    Text(
                      AppStrings.workLevel,
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                    ).tr(),
                    Text(
                      viewModel.getWorkLevelName(),
                      style: getRegularStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Module.appCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppMargin.m8,
                  children: [
                    Text(
                      AppStrings.quantity,
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                    ).tr(),
                    Text(
                      viewModel.getQuantity(),
                      style: getRegularStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppMargin.m8,
        ),
        GestureDetector(
          onTap: () {
            viewModel.openFile();
          },
          child: Module.appCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppMargin.m16,
              children: [
                SvgPicture.asset(IconsAssets.pdfIcon),
                Expanded(
                  child: Text(
                    AppStrings.previewPdf,
                    style: getMediumStyle(
                      color: ColorManager.black,
                    ),
                  ).tr(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: AppMargin.m16,
        ),
        SizedBox(
          width: double.infinity,
          height: AppSize.s40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => Module.tapItem(
              context,
              viewModel.taps[index],
              (id) {
                viewModel.changeTap(id);
              },
              width: (MediaQuery.of(context).size.width - AppMargin.m48) /
                  viewModel.taps.length,
            ),
            itemCount: viewModel.taps.length,
          ),
        ),
        const SizedBox(
          height: AppMargin.m8,
        ),
        _getTapContent(viewModel),
      ],
    );
  }

  Widget _getTapContent(UnitDetailViewModel viewModel) {
    TransactionData data =
    viewModel.formDetailsResponse!.transactionDetails!.data![0];
    switch (viewModel.currentTap) {
      case 0:
        return AttachmentsTap(
          attachments: viewModel.getAttachments(),
        );
      case 1:
        return FormVersionsTap(
          projectId: data.projectId ?? 0,
          activityId: data.activityId ?? 0,
          unit: viewModel.unit,
          workLevel: viewModel.getWorkLevelID(),
        );
      case 2:
        return RelatedFormsTap(
          projectId: data.projectId ?? 0,
          activityId: data.activityId ?? 0,
          unit: viewModel.unit,
          workLevel: viewModel.getWorkLevelID(),
        );
      default:
        return AttachmentsTap(
          attachments: viewModel.getAttachments(),
        );
    }
  }
}

class AttachmentsTap extends StatelessWidget {
  const AttachmentsTap({super.key, required this.attachments});

  final List<Attachment> attachments;

  @override
  Widget build(BuildContext context) {
    return attachments.isEmpty
        ? ViewNoData()
        : ListView.separated(
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => ItemAttachment(
              attachment: attachments[index],
            ),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: AppMargin.m16,
            ),
            itemCount: attachments.length,
          );
  }
}

class FormVersionsTap extends StatelessWidget {
  const FormVersionsTap({
    super.key,
    required this.projectId,
    required this.activityId,
    required this.unit,
    required this.workLevel,
  });

  final int projectId;
  final int activityId;
  final String unit;
  final String workLevel;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(WirRequests.previousVersionsQuery),
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "lang_key": AppPreferences.getAppLanguage(),
          "project_id": projectId,
          "activity_id": activityId,
          "units": [unit],
          "worklevels": [workLevel],
        },
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.isLoading) {
          return LoadingScreen();
        }

        if (result.hasException) {
          print('Error my : ${result.exception}');
          Helper.handleException(result.exception.toString());
          return ViewNoData();
        }

        print('Versions data: ${result.data}');
        PreviousVersionsResponse response =
            PreviousVersionsResponse.fromJson(result.data ?? {});
        return response.previousVersions == null
            ? ViewNoData()
            : response.previousVersions!.status == true &&
                    response.previousVersions!.data != null &&
                    response.previousVersions!.data!.isNotEmpty
                ? ListView.separated(
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) =>
                        ItemFormVersion(
                      version: response.previousVersions!.data![index],
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: AppMargin.m16,
                    ),
                    itemCount: response.previousVersions!.data!.length,
                  )
                : ViewNoData();
      },
    );
  }
}

class RelatedFormsTap extends StatelessWidget {
  const RelatedFormsTap({
    super.key,
    required this.projectId,
    required this.activityId,
    required this.unit,
    required this.workLevel,
  });

  final int projectId;
  final int activityId;
  final String unit;
  final String workLevel;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(WirRequests.relatedActivitiesQuery),
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "lang_key": AppPreferences.getAppLanguage(),
          "project_id": projectId,
          "activity_id": activityId,
          "units": [unit],
          "worklevels": [workLevel]
        },
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.isLoading) {
          return LoadingScreen();
        }

        if (result.hasException) {
          print(result.exception.toString());
          Helper.handleException(result.exception.toString());
          return ViewNoData();
        }

        print('Related Forms data: ${result.data}');
        RelatedActivitiesResponse response =
            RelatedActivitiesResponse.fromJson(result.data ?? {});
        return response.relatedActivities == null
            ? ViewNoData()
            : response.relatedActivities!.status == true &&
                    response.relatedActivities!.data != null &&
                    response.relatedActivities!.data!.isNotEmpty
                ? ListView.separated(
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) =>
                        ItemRelatedForms(
                      form: response.relatedActivities!.data![index],
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: AppMargin.m16,
                    ),
                    itemCount: response.relatedActivities!.data!.length,
                  )
                : ViewNoData();
      },
    );
  }
}