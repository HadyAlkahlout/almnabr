class UnitData {
  String workLocation;
  String workLevelName;
  String workLevel;
  double quantity;

  UnitData({
    required this.workLocation,
    required this.workLevelName,
    required this.workLevel,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      "work_location": workLocation,
      "work_level": workLevel,
      "quantities": quantity,
    };
  }

}
