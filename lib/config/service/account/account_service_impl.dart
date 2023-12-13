// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class AccountServiceImpl implements AccountService {
  AccountServiceImpl(this._dio) {
    _dio.options.baseUrl = BASE_URL;
    _dio.options.connectTimeout = Duration(seconds: BASE_TIMEOUT);
    _dio.options.sendTimeout = Duration(seconds: BASE_TIMEOUT);
  }

  final Dio _dio;

  @override
  Future<HttpResponse<LoginModel>> getLogin(
      {username, password, firebaseId}) async {
    try {
      final extra = <String, dynamic>{};
      final headers = <String, dynamic>{};
      final params = <String, dynamic>{};
      final formData = FormData.fromMap({
        'username': username,
        'password': password,
        'firebase_id': firebaseId
      });

      final options = Options(
          method: 'POST',
          headers: headers,
          extra: extra,
          validateStatus: (status) => true);
      final result = await _dio.request('login',
          data: formData, queryParameters: params, options: options);

      if (result.statusCode == HttpStatus.ok) {
        LoginModel value = LoginModel.fromJson(result.data!['data']['profile']);
        return HttpResponse(value, result);
      } else {
        throw ErrorModel.fromRequest(result.data);
      }
    } on DioError catch (e) {
      throw ErrorModel(message: e.message.toString());
    }
  }

  @override
  Future<HttpResponse<GeneralModel>> getReset({nik}) async {
    try {
      final extra = <String, dynamic>{};
      final headers = <String, dynamic>{};
      final params = <String, dynamic>{'nik': nik};
      final formData = FormData.fromMap({});

      final options = Options(
          method: 'GET',
          headers: headers,
          extra: extra,
          validateStatus: (status) => true);
      final result = await _dio.request('reset-password',
          data: formData, queryParameters: params, options: options);

      if (result.statusCode == HttpStatus.ok) {
        GeneralModel value = GeneralModel.fromJson(result.data);
        return HttpResponse(value, result);
      } else {
        throw ErrorModel.fromRequest(result.data);
      }
    } on DioError catch (e) {
      throw ErrorModel(message: e.message.toString());
    }
  }

  @override
  Future<HttpResponse<EmployeeModel>> checkNik({code, nik}) async {
    try {
      final extra = <String, dynamic>{};
      final headers = <String, dynamic>{};
      final params = <String, dynamic>{'code': code, 'nik': nik};
      final formData = FormData.fromMap({});

      final options = Options(
          method: 'GET',
          headers: headers,
          extra: extra,
          validateStatus: (status) => true);
      final result = await _dio.request('sync-data-hris',
          data: formData, queryParameters: params, options: options);

      if (result.statusCode == HttpStatus.ok) {
        EmployeeModel value = EmployeeModel.fromJson(result.data!['data']);
        return HttpResponse(value, result);
      } else {
        throw ErrorModel.fromRequest(result.data);
      }
    } on DioError catch (e) {
      throw ErrorModel(message: e.message.toString());
    }
  }

  @override
  Future<HttpResponse<GeneralModel>> register({data}) async {
    try {
      final extra = <String, dynamic>{};
      final headers = <String, dynamic>{};
      final params = <String, dynamic>{};
      final formData = FormData.fromMap({'data': data});

      final options = Options(
          method: 'POST',
          headers: headers,
          extra: extra,
          validateStatus: (status) => true);
      final result = await _dio.request('register-user',
          data: formData, queryParameters: params, options: options);

      if (result.statusCode == HttpStatus.ok) {
        GeneralModel value = GeneralModel.fromJson(result.data);
        return HttpResponse(value, result);
      } else {
        throw ErrorModel.fromRequest(result.data);
      }
    } on DioError catch (e) {
      throw ErrorModel(message: e.message.toString());
    }
  }
}
