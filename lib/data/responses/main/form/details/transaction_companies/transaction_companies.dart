import 'package:json_annotation/json_annotation.dart';

part 'transaction_companies.g.dart';

@JsonSerializable()
class TransactionCompanies {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  List<CompanyData>? data;

  TransactionCompanies();

  factory TransactionCompanies.fromJson(Map<String, dynamic> json) =>
      _$TransactionCompaniesFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionCompaniesToJson(this);
}

@JsonSerializable()
class CompanyData {
  @JsonKey(name: 'company_id')
  String? companyId;
  @JsonKey(name: 'company')
  Company? company;
  @JsonKey(name: 'company_position_id')
  String? companyPositionId;
  @JsonKey(name: 'companyPositions')
  CompanyPositions? companyPositions;

  CompanyData();

  factory CompanyData.fromJson(Map<String, dynamic> json) =>
      _$CompanyDataFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyDataToJson(this);
}

@JsonSerializable()
class Company {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'contractor_name')
  String? contractorName;
  @JsonKey(name: 'commercial_registeration')
  String? commercialRegisteration;
  @JsonKey(name: 'vat_number')
  String? vatNumber;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'mobile')
  String? mobile;
  @JsonKey(name: 'logo')
  String? logo;

  Company();

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}

@JsonSerializable()
class CompanyPositions {
  @JsonKey(name: 'keyword')
  String? keyword;
  @JsonKey(name: 'title_en')
  String? titleEn;
  @JsonKey(name: 'title_ar')
  String? titleAr;

  CompanyPositions();

  factory CompanyPositions.fromJson(Map<String, dynamic> json) =>
      _$CompanyPositionsFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyPositionsToJson(this);
}