
class ErrorModel {
  bool? status;
  int? statusCode;
  String? message = "Data tidak ditemukan";

  ErrorModel({
    this.status,
    this.statusCode,
    this.message
  });


  factory ErrorModel.fromJson(dynamic json) {
    return ErrorModel(
      status: json['status'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String
    );
  }

  factory ErrorModel.fromRequest(dynamic data) {
    if(data.toString().contains("Bad Request")){
      return ErrorModel(message: data.toString());
    }else{
      return ErrorModel.fromJson(data ?? ErrorModel(message: data.toString()));
    }
  }
}