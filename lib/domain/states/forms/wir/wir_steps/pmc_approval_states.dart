abstract class PmcApprovalStates {}

class PmcApprovalInitialStates extends PmcApprovalStates {}

//Abi Sates
class PmcApprovalDataLoadingState extends PmcApprovalStates {}

class PmcApprovalDataErrorState extends PmcApprovalStates {}

class PmcApprovalDataSuccessState extends PmcApprovalStates {}
