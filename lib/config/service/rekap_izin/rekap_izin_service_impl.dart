// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rekap_izin_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class RekapIzinServiceImpl implements RekapIzinService {
  RekapIzinServiceImpl(this._dio) {
    _dio.options.baseUrl = BASE_URL;
    _dio.options.connectTimeout = BASE_TIMEOUT;
    _dio.options.sendTimeout = BASE_TIMEOUT;
  }

  final Dio _dio;

  @override
  Future<HttpResponse<List<RekapIzinModel>>> getRekapIzin({nik}) async {
    try {
      final extra = <String, dynamic>{};
      final headers = <String, dynamic>{};
      final params = <String, dynamic>{};
      final formData = FormData.fromMap({
        'nik': nik
      });

      final options = Options(method: 'POST', headers: headers, extra: extra, validateStatus: (status) => true);
      final result = await _dio.request('perizinan/list',
          data: formData,
          queryParameters: params,
          options: options
      );

      if(result.statusCode == HttpStatus.ok) {
        List<RekapIzinModel> value = result.data!['data']
            .map<RekapIzinModel>((dynamic i) => RekapIzinModel.fromJson(i as Map<String, dynamic>))
            .toList();
        return HttpResponse(value, result);
      } else {
        throw ErrorModel.fromRequest(result.data);
      }
    }on DioError catch (e){
      throw ErrorModel(message: e.message.toString());
    }
  }

  @override
  Future<HttpResponse<ViewCutiModel>> getViewCuti({nik}) async {
    try {
      final extra = <String, dynamic>{};
      final headers = <String, dynamic>{};
      final params = <String, dynamic>{};
      final formData = FormData.fromMap({
        'nik': nik
      });

      final options = Options(method: 'POST', headers: headers, extra: extra, validateStatus: (status) => true);
      final result = await _dio.request('perizinan/view-cuti',
          data: formData,
          queryParameters: params,
          options: options
      );

      if(result.statusCode == HttpStatus.ok) {
        ViewCutiModel value = ViewCutiModel.fromJson(result.data!['data']);
        return HttpResponse(value, result);
      } else {
        throw ErrorModel.fromRequest(result.data);
      }
    }on DioError catch (e){
      throw ErrorModel(message: e.message.toString());
    }
  }

  @override
  Future<HttpResponse<GeneralModel>> saveRekapIzin({data}) async {
    try {
      final extra = <String, dynamic>{};
      final headers = <String, dynamic>{};
      final params = <String, dynamic>{};
      final formData = FormData.fromMap({
        'data': data
      });

      final options = Options(method: 'POST', headers: headers, extra: extra, validateStatus: (status) => true);
      final result = await _dio.request('perizinan/pengajuan-izin',
          data: formData,
          queryParameters: params,
          options: options
      );

      if(result.statusCode == HttpStatus.ok) {
        GeneralModel value = GeneralModel.fromJson(result.data);
        return HttpResponse(value, result);
      } else {
        throw ErrorModel.fromRequest(result.data);
      }
    }on DioError catch (e){
      throw ErrorModel(message: e.message.toString());
    }
  }

}
