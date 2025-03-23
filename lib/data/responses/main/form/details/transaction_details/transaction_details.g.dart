// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDetails _$TransactionDetailsFromJson(Map<String, dynamic> json) =>
    TransactionDetails()
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => TransactionData.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TransactionDetailsToJson(TransactionDetails instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

TransactionData _$TransactionDataFromJson(Map<String, dynamic> json) =>
    TransactionData()
      ..id = (json['id'] as num?)?.toInt()
      ..sequenceNumber = (json['sequence_number'] as num?)?.toInt()
      ..formSequenceNumber = (json['form_sequence_number'] as num?)?.toInt()
      ..projectId = (json['project_id'] as num?)?.toInt()
      ..project = json['project'] == null
          ? null
          : Project.fromJson(json['project'] as Map<String, dynamic>)
      ..activityId = (json['activity_id'] as num?)?.toInt()
      ..activity = json['activity'] == null
          ? null
          : Activity.fromJson(json['activity'] as Map<String, dynamic>)
      ..activityRenames = json['activityRenames']
      ..formKey = json['form_key'] as String?
      ..formType = json['form_type'] as String?
      ..transactionFromSub = json['transaction_from_sub']
      ..transactionFromSubCompany = json['transaction_from_sub_company']
      ..transactionFrom = json['transaction_from'] as String?
      ..transactionFromCompany = json['transaction_from_company'] == null
          ? null
          : TransactionFromCompany.fromJson(
              json['transaction_from_company'] as Map<String, dynamic>)
      ..transactionTo = json['transaction_to'] as String?
      ..transactionToCompany = json['transaction_to_company'] == null
          ? null
          : TransactionFromCompany.fromJson(
              json['transaction_to_company'] as Map<String, dynamic>)
      ..langKey = json['lang_key'] as String?
      ..subject = json['subject'] as String?
      ..writer = json['writer'] == null
          ? null
          : Writer.fromJson(json['writer'] as Map<String, dynamic>)
      ..approvalType = json['approval_type'] as String?
      ..lastStepName = json['last_step_name'] as String?
      ..transactionStatus = json['transaction_status'] as String?
      ..submitter = json['submitter']
      ..version = json['version'] as String?
      ..barcodeData = json['barcodeData']
      ..barcodeKey = json['barcodeKey']
      ..units = json['units'] as String?
      ..evaluationResult = json['evaluation_result']
      ..resubmitedTransactionId = json['resubmited_transaction_id']
      ..attachment = json['attachment'];

Map<String, dynamic> _$TransactionDataToJson(TransactionData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sequence_number': instance.sequenceNumber,
      'form_sequence_number': instance.formSequenceNumber,
      'project_id': instance.projectId,
      'project': instance.project,
      'activity_id': instance.activityId,
      'activity': instance.activity,
      'activityRenames': instance.activityRenames,
      'form_key': instance.formKey,
      'form_type': instance.formType,
      'transaction_from_sub': instance.transactionFromSub,
      'transaction_from_sub_company': instance.transactionFromSubCompany,
      'transaction_from': instance.transactionFrom,
      'transaction_from_company': instance.transactionFromCompany,
      'transaction_to': instance.transactionTo,
      'transaction_to_company': instance.transactionToCompany,
      'lang_key': instance.langKey,
      'subject': instance.subject,
      'writer': instance.writer,
      'approval_type': instance.approvalType,
      'last_step_name': instance.lastStepName,
      'transaction_status': instance.transactionStatus,
      'submitter': instance.submitter,
      'version': instance.version,
      'barcodeData': instance.barcodeData,
      'barcodeKey': instance.barcodeKey,
      'units': instance.units,
      'evaluation_result': instance.evaluationResult,
      'resubmited_transaction_id': instance.resubmitedTransactionId,
      'attachment': instance.attachment,
    };

Project _$ProjectFromJson(Map<String, dynamic> json) => Project()
  ..id = json['id'] as String?
  ..name = json['name'] as String?
  ..address = json['address'] as String?
  ..area = (json['area'] as num?)?.toInt()
  ..status = json['status'] as String?;

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'area': instance.area,
      'status': instance.status,
    };

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity()
  ..id = json['id'] as String?
  ..titleEn = json['title_en'] as String?
  ..titleAr = json['title_ar'] as String?
  ..activityCode = json['activity_code'] as String?
  ..activityType = json['activity_type'] == null
      ? null
      : ActivityType.fromJson(json['activity_type'] as Map<String, dynamic>)
  ..activityDivision = json['activityDivision'] == null
      ? null
      : Chapter.fromJson(json['activityDivision'] as Map<String, dynamic>)
  ..activityChapter = json['activityChapter'] == null
      ? null
      : Chapter.fromJson(json['activityChapter'] as Map<String, dynamic>);

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'title_en': instance.titleEn,
      'title_ar': instance.titleAr,
      'activity_code': instance.activityCode,
      'activity_type': instance.activityType,
      'activityDivision': instance.activityDivision,
      'activityChapter': instance.activityChapter,
    };

ActivityType _$ActivityTypeFromJson(Map<String, dynamic> json) => ActivityType()
  ..type = json['type'] as String?
  ..titleEn = json['title_en'] as String?
  ..titleAr = json['title_ar'] as String?;

Map<String, dynamic> _$ActivityTypeToJson(ActivityType instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title_en': instance.titleEn,
      'title_ar': instance.titleAr,
    };

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter()
  ..id = json['id'] as String?
  ..titleEn = json['title_en'] as String?
  ..titleAr = json['title_ar'] as String?
  ..chapterCode = json['chapter_code'] as String?;

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'id': instance.id,
      'title_en': instance.titleEn,
      'title_ar': instance.titleAr,
      'chapter_code': instance.chapterCode,
    };

TransactionFromCompany _$TransactionFromCompanyFromJson(
        Map<String, dynamic> json) =>
    TransactionFromCompany()
      ..id = json['id'] as String?
      ..contractorName = json['contractor_name'] as String?
      ..commercialRegisteration = json['commercial_registeration'] as String?
      ..vatNumber = json['vat_number'] as String?;

Map<String, dynamic> _$TransactionFromCompanyToJson(
        TransactionFromCompany instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contractor_name': instance.contractorName,
      'commercial_registeration': instance.commercialRegisteration,
      'vat_number': instance.vatNumber,
    };

Writer _$WriterFromJson(Map<String, dynamic> json) => Writer()
  ..id = json['id'] as String?
  ..name = json['name'] as String?
  ..email = json['email'] as String?
  ..mobile = json['mobile'] as String?;

Map<String, dynamic> _$WriterToJson(Writer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
    };
