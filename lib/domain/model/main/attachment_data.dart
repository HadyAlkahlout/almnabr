import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';

class AttachmentData {
  String titleAr;
  String titleEn;
  File file;
  int attach;

  AttachmentData({
    required this.titleAr,
    required this.titleEn,
    required this.file,
    required this.attach,
  });

  Map<String, dynamic> toMap()  {
    // Uint8List fileBytes = await file.readAsBytes();
    //
    // MultipartFile multipartFile = MultipartFile.fromBytes(
    //   'file', // Key must match the API requirement
    //   fileBytes,
    //   filename: titleEn,
    // );

    return {
      "title": {"en": titleEn, "ar": titleAr},
      "file": null,
      "attach_with_pdf": attach,
    };
  }

}
