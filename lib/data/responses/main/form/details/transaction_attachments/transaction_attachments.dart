import 'package:json_annotation/json_annotation.dart';
import 'package:teqani/data/responses/main/form/details/transaction_details/transaction_details.dart';
import 'package:teqani/data/responses/main/page/paging.dart';

part 'transaction_attachments.g.dart';

@JsonSerializable()
class TransactionAttachments {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'paging')
  Paging? paging;
  @JsonKey(name: 'data')
  List<Attachment>? data;

  TransactionAttachments();

  factory TransactionAttachments.fromJson(Map<String, dynamic> json) =>
      _$TransactionAttachmentsFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionAttachmentsToJson(this);
}

@JsonSerializable()
class Attachment {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'transaction_step_name')
  String? transactionStepName;
  @JsonKey(name: 'file_path')
  String? filePath;
  @JsonKey(name: 'file_size')
  String? fileSize;
  @JsonKey(name: 'file_extension')
  String? fileExtension;
  @JsonKey(name: 'title_en')
  String? titleEn;
  @JsonKey(name: 'title_ar')
  String? titleAr;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'writer')
  Writer? writer;

  Attachment();

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}
