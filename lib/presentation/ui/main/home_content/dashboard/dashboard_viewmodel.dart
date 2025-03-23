import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:teqani/app/helper.dart';
import 'package:teqani/data/network/app_api.dart';
import 'package:teqani/data/network/app_requests/main_requests.dart';
import 'package:teqani/data/responses/main/dashboard/dashboard_response.dart';
import 'package:teqani/data/responses/main/page/paging.dart';
import 'package:teqani/domain/model/main/dashboard_tap.dart';
import 'package:teqani/domain/states/dashboard_states.dart';
import 'package:teqani/presentation/resources/strings_manager.dart';

class DashboardViewModel extends Cubit<DashboardStates> {
  DashboardViewModel() : super(DashboardInitialStates());

  static DashboardViewModel get(context) => BlocProvider.of(context);
  final GraphQLClient _client = AppServiceClient.instance.getAppClient(false);
  final TextEditingController searchController = TextEditingController();
  int currentTap = 0;
  bool isMore = false;

  List<DashboardTap> taps = [];
  List<AppForm> forms = [];

  Paging? paging;

  void start() {
    taps = [
      DashboardTap(0, AppStrings.workInspection, true),
      DashboardTap(1, AppStrings.materialsDrawing, false),
    ];
    paging = Paging();
    _getDashboardData();
  }

  void changeTap(int id) {
    if (currentTap != id) {
      currentTap = id;
      taps.forEach((tap) {
        tap.isSelected = tap.id == id;
      });
      emit(DashboardChangeTapState());
    }
  }

  void _getDashboardData() async{

    emit(DashboardDataLoadingState());
    final QueryOptions options = QueryOptions(
      document: gql(MainRequests.dashboardQuery),
      fetchPolicy: FetchPolicy.networkOnly,
      variables: _getDashboardArgument(),
    );
    _client.cache.store.reset();
    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      Helper.handleException(result.exception.toString());
      emit(DashboardDataErrorState());
    } else {
      _dashboardResult(result.data ?? {});
    }
  }

  void _dashboardResult(Map<String, dynamic> result) {
    print('The result map: $result');
    DashboardResponse dashboardData = DashboardResponse.fromJson(result);
    if(dashboardData.transactionsCountAndLists != null){
      print(
          'Dashboard request done message: ${dashboardData.transactionsCountAndLists!.message}');
      if (dashboardData.transactionsCountAndLists!.status == true) {
        paging = dashboardData.transactionsCountAndLists!.paging ?? Paging();
        isMore = paging!.currentPage < paging!.lastPage;
        if(paging!.currentPage == 1){
          forms.clear();
        }
        forms.addAll(dashboardData.transactionsCountAndLists!.data ?? []);
        emit(DashboardDataSuccessState());
      } else {
        print('Something wrong in dashboard request');
      }
    } else{
      print('Dashboard transactions lists is null');
    }
  }

  Map<String, dynamic> _getDashboardArgument(){
    print('Geting page no: ${paging!.currentPage}');
    return {
      "page_no": paging!.currentPage,
      "page_size": 10,
      "search_key": searchController.text,
      "search_units": "",
      "divisions": [],
      "chapters": [],
      "activities": [],
      "work_levels": [],
      "forms": _getSelectedForm(),
      "steps": [],
      "results": [],
      "linked_items": [],
      "start_date": "",
      "end_date": "",
      "tags": [],
      "show_completed": "",
      "waiting_for_approval": ""
    };
  }

  void addPage(){
    paging!.currentPage = paging!.currentPage + 1;
    _getDashboardData();
  }

  String _getSelectedForm(){
    String name = "";
    switch(currentTap){
      case 0: {
        name = "wir";
      }
    }
    return name;
  }

  void refresh(){
    _getDashboardData();
  }
}
