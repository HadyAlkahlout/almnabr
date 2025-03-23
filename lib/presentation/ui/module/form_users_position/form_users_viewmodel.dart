import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:teqani/app/helper.dart';
import 'package:teqani/data/network/app_api.dart';
import 'package:teqani/data/network/app_requests/main_requests.dart';
import 'package:teqani/data/responses/main/positions/positions_response.dart';
import 'package:teqani/data/responses/main/step_users/add_users/add_users_response.dart';
import 'package:teqani/data/responses/main/users/users_response.dart';
import 'package:teqani/domain/model/main/position_users.dart';
import 'package:teqani/presentation/ui/module/module.dart';

class FormUsersViewModel extends Cubit<FormUsersStates> {
  FormUsersViewModel() : super(FormInitialStates());

  static FormUsersViewModel get(context) => BlocProvider.of(context);

  final GraphQLClient _client = AppServiceClient.instance.getAppClient(false);

  final TextEditingController searchController = TextEditingController();
  PositionData selectedPosition = PositionData();

  List<PositionData> positions = [];
  List<UserData> users = [];
  List<UserData> selectedUsers = [];
  bool canAdd = false;
  bool allTransactions = false;
  List<PositionUsers> selectedPositionUsers = [];

  void start() {
    searchController.addListener(() {
      print('Search: ${searchController.text}');
      _getUsers(searchController.text);
    });
    if (positions.isEmpty) {
      _getPositions();
    }
    _getPositions();
  }

  void _getPositions() async {
    final QueryOptions options = QueryOptions(
      document: gql(MainRequests.constructionPositions),
      variables: {"searchKey": ""},
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
    } else {
      print('Positions: ${result.data}');
      PositionsResponse positionsResponse =
          PositionsResponse.fromJson(result.data ?? {});
      if (positionsResponse.positions != null &&
          positionsResponse.positions!.data != null) {
        positions = positionsResponse.positions!.data!;
        emit(FormAddPositionsStates());
      }
    }
  }

  void changeSelectedPosition(PositionData pos) {
    selectedPosition = pos;
    for (var p in positions) {
      p.isSelected = pos.id == p.id;
    }
    changeAddState();
    emit(FormChangePositionStates());
  }

  void _getUsers(String search) async {
    if (search == '') return;
    final QueryOptions options = QueryOptions(
      document: gql(MainRequests.constructionUsers),
      variables: {"searchKey": search},
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
    } else {
      print('Users: ${result.data}');
      UsersResponse usersResponse = UsersResponse.fromJson(result.data ?? {});
      users.clear();
      if (usersResponse.users != null && usersResponse.users!.data != null) {
        print('Users: ${usersResponse.users!.data!.length}');
        for (var user in usersResponse.users!.data!) {
          print("${user.title} added!");
          users.add(user);
        }
        emit(FormAddUsersStates());
      }
    }
  }

  void addUser(UserData user)  {
    searchController.text = '';
    users.remove(user);
    selectedUsers.add(user);
    changeAddState();
    emit(FormAddUserStates());
  }

  void deleteUser(UserData user)  {
    selectedUsers.remove(user);
    emit(FormDeleteUserStates());
  }

  void addPositionUsers(Function(PositionUsers positionUsers)? onAdd) {
    if (selectedPosition.id != null && selectedUsers.isNotEmpty) {
      final user = PositionUsers(
          position: selectedPosition,
          users: List<UserData>.from(selectedUsers),
      );
      if(onAdd != null) {
        onAdd(user);
      }
      selectedPositionUsers
          .add(user);
      emit(FormAddPositionUsersStates());
      selectedUsers.clear();
      changeAddState();
    }
  }

  void changeAddState() {
    canAdd =
        selectedPosition.id != null && selectedUsers.isNotEmpty;
    emit(state);
  }

  void changeAllTransactions() {
    allTransactions = !allTransactions;
    emit(FormFutureFormsStates());
  }

  void deletePositionUsers(PositionUsers positionUsers) {
    selectedPositionUsers.remove(positionUsers);
    emit(FormDeletePositionUsersStates());
  }

  void confirm(int projectId, int transactionId, int step, String? stepName) async {
    emit(FormConfirmLoadingStates());
    print('Confirm');
    print(selectedPositionUsers);
    final QueryOptions options = QueryOptions(
      document: gql(MainRequests.addStepUsers),
      variables: {
        "project_id": '$projectId',
        "transaction_id": allTransactions ? '' : '$transactionId',
        "step": stepName ?? getStepName(step),
        "userData": selectedPositionUsers
            .map((positionUsers) => positionUsers.toMap())
            .toList(),
      },
    );

    final QueryResult result = await _client.query(options);
    print(result.data);

    if (result.hasException) {
      print(result.exception.toString());
      Helper.handleException(result.exception.toString());
      emit(FormConfirmErrorStates());
    } else {
      AddUsersResponse addUsersResponse =
          AddUsersResponse.fromJson(result.data ?? {});
      if (addUsersResponse.assignUsers != null) {
        if (addUsersResponse.assignUsers!.status == true) {
          emit(FormConfirmSuccessStates());
        } else {
          emit(FormConfirmErrorStates());
        }
        Module.showToast(addUsersResponse.assignUsers!.message ?? 'Something went wrong',
            addUsersResponse.assignUsers!.status == false);
      } else {
        emit(FormConfirmErrorStates());
      }
    }
  }

  String getStepName(int step) {
    String name = '';
    switch (step) {
      case 2:
        name = 'contractor_team_approval';
      case 3:
        name = 'contractor_manager_approval';
      case 4:
        name = 'contractor_qaqc_approval';
      case 5:
        name = 'recipient_verification';
      case 6:
        name = 'technical_assistant';
      case 7:
        name = 'soil_test_witness_result';
      case 8:
        name = 'special_approval';
      case 9:
        name = 'authorized_positions_approval';
      case 10:
        name = 'manager_approval';
      case 11:
        name = 'owners_representative';
      case 12:
        name = 'pmc_approval';
      case 13:
        name = 'result_receiving';
    }
    return name;
  }
}

abstract class FormUsersStates {}

class FormInitialStates extends FormUsersStates {}

class FormChangePositionStates extends FormUsersStates {}

class FormAddPositionsStates extends FormUsersStates {}

class FormAddUsersStates extends FormUsersStates {}

class FormAddUserStates extends FormUsersStates {}

class FormDeleteUserStates extends FormUsersStates {}

class FormAddPositionUsersStates extends FormUsersStates {}

class FormDeletePositionUsersStates extends FormUsersStates {}

class FormFutureFormsStates extends FormUsersStates {}

// Confirm API
class FormConfirmLoadingStates extends FormUsersStates {}

class FormConfirmErrorStates extends FormUsersStates {}

class FormConfirmSuccessStates extends FormUsersStates {}
