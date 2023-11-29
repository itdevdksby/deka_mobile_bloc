
class GeneralModel {
  int? statusCode;
  String? message = "Data tidak ditemukan";

  GeneralModel({
    this.statusCode,
    this.message
  });


  factory GeneralModel.fromJson(dynamic json) {
    return GeneralModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String
    );
  }
}