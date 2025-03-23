class SaudiCode{
  String id;
  String titleEn;
  String titleAr;
  String status;
  bool fromApi = false;

  SaudiCode(this.id, this.titleEn, this.titleAr, this.status, this.fromApi);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": {"en": titleEn, "ar": titleAr},
      "status": status,
    };
  }
}