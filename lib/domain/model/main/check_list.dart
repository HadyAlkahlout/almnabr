import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';

class CheckList{
  String id;
  String titleEn;
  String titleAr;
  File? file;
  String status;
  bool fromApi = false;

  CheckList(this.id, this.titleEn, this.titleAr, this.file, this.status, this.fromApi);

  Map<String, dynamic> toMap() {
    // Uint8List fileBytes = await file!.readAsBytes();
    //
    // MultipartFile multipartFile = MultipartFile.fromBytes(
    //   'file', // Key must match the API requirement
    //   fileBytes,
    //   filename: titleEn,
    // );

    return {
      "id": id,
      "title": {"en": titleEn, "ar": titleAr},
      "file": null,
      "status": status,
      "from_openai": "0",
    };
  }
}