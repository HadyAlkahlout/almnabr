import 'package:json_annotation/json_annotation.dart';

part 'transaction_details.g.dart';

@JsonSerializable()
class TransactionDetails {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  List<TransactionData>? data;

  TransactionDetails();

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDetailsToJson(this);
}

@JsonSerializable()
class TransactionData {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'sequence_number')
  int? sequenceNumber;
  @JsonKey(name: 'form_sequence_number')
  int? formSequenceNumber;
  @JsonKey(name: 'project_id')
  int? projectId;
  @JsonKey(name: 'project')
  Project? project;
  @JsonKey(name: 'activity_id')
  int? activityId;
  @JsonKey(name: 'activity')
  Activity? activity;
  @JsonKey(name: 'activityRenames')
  dynamic activityRenames;
  @JsonKey(name: 'form_key')
  String? formKey;
  @JsonKey(name: 'form_type')
  String? formType;
  @JsonKey(name: 'transaction_from_sub')
  dynamic transactionFromSub;
  @JsonKey(name: 'transaction_from_sub_company')
  dynamic transactionFromSubCompany;
  @JsonKey(name: 'transaction_from')
  String? transactionFrom;
  @JsonKey(name: 'transaction_from_company')
  TransactionFromCompany? transactionFromCompany;
  @JsonKey(name: 'transaction_to')
  String? transactionTo;
  @JsonKey(name: 'transaction_to_company')
  TransactionFromCompany? transactionToCompany;
  @JsonKey(name: 'lang_key')
  String? langKey;
  @JsonKey(name: 'subject')
  String? subject;
  @JsonKey(name: 'writer')
  Writer? writer;
  @JsonKey(name: 'approval_type')
  String? approvalType;
  @JsonKey(name: 'last_step_name')
  String? lastStepName;
  @JsonKey(name: 'transaction_status')
  String? transactionStatus;
  @JsonKey(name: 'submitter')
  dynamic submitter;
  @JsonKey(name: 'version')
  String? version;
  @JsonKey(name: 'barcodeData')
  dynamic barcodeData;
  @JsonKey(name: 'barcodeKey')
  dynamic barcodeKey;
  @JsonKey(name: 'units')
  String? units;
  @JsonKey(name: 'evaluation_result')
  dynamic evaluationResult;
  @JsonKey(name: 'resubmited_transaction_id')
  dynamic resubmitedTransactionId;
  @JsonKey(name: 'attachment')
  dynamic attachment;

  TransactionData();

  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      _$TransactionDataFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDataToJson(this);
}

@JsonSerializable()
class Project {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'area')
  int? area;
  @JsonKey(name: 'status')
  String? status;

  Project();

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}

@JsonSerializable()
class Activity {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'title_en')
  String? titleEn;
  @JsonKey(name: 'title_ar')
  String? titleAr;
  @JsonKey(name: 'activity_code')
  String? activityCode;
  @JsonKey(name: 'activity_type')
  ActivityType? activityType;
  @JsonKey(name: 'activityDivision')
  Chapter? activityDivision;
  @JsonKey(name: 'activityChapter')
  Chapter? activityChapter;

  Activity();

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}

@JsonSerializable()
class ActivityType {
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'title_en')
  String? titleEn;
  @JsonKey(name: 'title_ar')
  String? titleAr;

  ActivityType();

  factory ActivityType.fromJson(Map<String, dynamic> json) =>
      _$ActivityTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityTypeToJson(this);
}

@JsonSerializable()
class Chapter {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'title_en')
  String? titleEn;
  @JsonKey(name: 'title_ar')
  String? titleAr;
  @JsonKey(name: 'chapter_code')
  String? chapterCode;

  Chapter();

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}

@JsonSerializable()
class TransactionFromCompany {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'contractor_name')
  String? contractorName;
  @JsonKey(name: 'commercial_registeration')
  String? commercialRegisteration;
  @JsonKey(name: 'vat_number')
  String? vatNumber;

  TransactionFromCompany();

  factory TransactionFromCompany.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionFromCompanyToJson(this);
}

@JsonSerializable()
class Writer {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'mobile')
  String? mobile;

  Writer();

  factory Writer.fromJson(Map<String, dynamic> json) =>
      _$WriterFromJson(json);

  Map<String, dynamic> toJson() => _$WriterToJson(this);
}