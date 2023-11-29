// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_data_master_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class SyncDataMasterServiceImpl implements SyncDataMasterService {
  SyncDataMasterServiceImpl(this._dio) {
    _dio.options.baseUrl = BASE_URL;
    _dio.options.connectTimeout = BASE_TIMEOUT;
    _dio.options.sendTimeout = BASE_TIMEOUT;
  }

  final Dio _dio;

  @override
  Future<HttpResponse<SyncDataMasterModel>> syncDataMaster({String? user_id, String? date, String? slug_database}) async {
    try {
      final extra = <String, dynamic>{};
      final headers = <String, dynamic>{};
      final params = <String, dynamic>{
        'user_id': user_id,
        'date': date,
      };
      final formData = FormData.fromMap({
        'slug_database': slug_database
      });

      final options = Options(method: 'POST', headers: headers, extra: extra, validateStatus: (status) => true);
      final result = await _dio.request('sync-data-master',
          data: formData,
          queryParameters: params,
          options: options
      );

      if(result.statusCode == HttpStatus.ok) {
        SyncDataMasterModel value = SyncDataMasterModel.fromJson(result.data!['data']);
        return HttpResponse(value, result);
      } else {
        throw ErrorModel.fromRequest(result.data);
      }
    }on DioError catch (e){
      throw ErrorModel(message: e.message.toString());
    }
  }

}
