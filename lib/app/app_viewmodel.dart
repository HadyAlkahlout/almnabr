import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:teqani/app/app_preferances.dart';
import 'package:teqani/data/network/app_api.dart';
import 'package:teqani/domain/states/app_states.dart';

class AppViewModel extends Cubit<AppStates> {
  AppViewModel() : super(AppInitialStates());

  static AppViewModel get(context) => BlocProvider.of(context);

  ValueNotifier<GraphQLClient>? _authClient;
  ValueNotifier<GraphQLClient>? _mainClient;

  bool isAuth = true;

  void changeClientLink(bool isMain) {
    isAuth = !isMain;
    emit(AppChangeClientLinkState());
    if(!isMain){
      if(_authClient != null){
        _authClient!.dispose();
      }
    } else {
      if(_mainClient != null){
        _mainClient!.dispose();
      }
    }
  }

  ValueNotifier<GraphQLClient> getAuthClient(){
    _authClient =
        ValueNotifier(AppServiceClient.instance.getAppClient(true));
    return _authClient!;
  }

  ValueNotifier<GraphQLClient> getMainClient(){
    _mainClient =
        ValueNotifier(AppServiceClient.instance.getAppClient(false));
    return _mainClient!;
  }

}
