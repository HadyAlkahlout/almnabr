abstract class AuthorizedPositionsStates {}

class AuthorizedPositionsInitialStates extends AuthorizedPositionsStates {}

//Abi Sates
class AuthorizedPositionsDataLoadingState extends AuthorizedPositionsStates {}

class AuthorizedPositionsDataErrorState extends AuthorizedPositionsStates {}

class AuthorizedPositionsDataSuccessState extends AuthorizedPositionsStates {}
