abstract class WirStepsStates{}

 class WirStepsInitialStates extends WirStepsStates {}

class WirStepsChangeStates extends WirStepsStates {}

// Contractor Manager Approval
class WirManagerQaQcChangeStates extends WirStepsStates {}

class WirManagerAddUnitStates extends WirStepsStates {}

class WirManagerRemoveUnitStates extends WirStepsStates {}

// Attachments

class WirAddAttachmentStates extends WirStepsStates {}

class WirRemoveAttachmentStates extends WirStepsStates {}

// Soil Test
class WirSoilChangeTypeStates extends WirStepsStates {}

class WirSoilChangeResultStates extends WirStepsStates {}

// Technical Assistant

class WirTechnicalCustomCheckListStates extends WirStepsStates {}

class WirTechnicalNeedSpecialStates extends WirStepsStates {}

class WirTechnicalAddCheckListStates extends WirStepsStates {}

class WirTechnicalRemoveCheckListStates extends WirStepsStates {}

class WirTechnicalEditCheckListStates extends WirStepsStates {}

class WirTechnicalAddConsultantStates extends WirStepsStates {}

class WirTechnicalRemoveConsultantStates extends WirStepsStates {}

class WirTechnicalEditConsultantStates extends WirStepsStates {}

class WirTechnicalAddSaudiCodeStates extends WirStepsStates {}

class WirTechnicalRemoveSaudiCodeStates extends WirStepsStates {}

class WirTechnicalEditSaudiCodeStates extends WirStepsStates {}

// Consultant Manager
class WirConsultantOwnerStates extends WirStepsStates {}

// Position Users

class WirAddPositionUsersStates extends WirStepsStates {}

class WirRemovePositionUsersStates extends WirStepsStates {}

//API Sates
class WirStepsDataLoadingState extends WirStepsStates {}

class WirStepsDataErrorState extends WirStepsStates {}

class WirStepsDataSuccessState extends WirStepsStates {}

class WirStepTechnicalDataSuccessState extends WirStepsStates {}

class WirStepTechnicalDataErrorState extends WirStepsStates {}