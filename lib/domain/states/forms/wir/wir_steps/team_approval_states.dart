abstract class TeamApprovalStates {}

class TeamApprovalInitialStates extends TeamApprovalStates {}

class TeamApprovalChangeStates extends TeamApprovalStates {}

//Abi Sates
class TeamApprovalDataLoadingState extends TeamApprovalStates {}

class TeamApprovalDataErrorState extends TeamApprovalStates {}

class TeamApprovalDataSuccessState extends TeamApprovalStates {}
