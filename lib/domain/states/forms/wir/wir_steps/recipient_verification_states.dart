abstract class RecipientVerificationStates {}

class RecipientVerificationInitialStates extends RecipientVerificationStates {}

//Abi Sates
class RecipientVerificationDataLoadingState extends RecipientVerificationStates {}

class RecipientVerificationDataErrorState extends RecipientVerificationStates {}

class RecipientVerificationDataSuccessState extends RecipientVerificationStates {}
