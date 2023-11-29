import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../extensions/constants.dart';
import '../../../models/response/error_model.dart';
import '../../../models/response/general_model.dart';
import '../../../models/response/rekap_izin_model.dart';
import '../../../models/response/view_cuti_model.dart';

part 'rekap_izin_service_impl.dart';

@RestApi(baseUrl: BASE_URL)
abstract class RekapIzinService {
  factory RekapIzinService(Dio dio) = RekapIzinServiceImpl;

  @FormUrlEncoded()
  @POST('perizinan/list')
  Future<HttpResponse<List<RekapIzinModel>>> getRekapIzin(
      {@Field("nik") String? nik});

  @FormUrlEncoded()
  @POST('perizinan/pengajuan-izin')
  Future<HttpResponse<GeneralModel>> saveRekapIzin(
      {@Field("data") String? data});

  @FormUrlEncoded()
  @POST('perizinan/view-cuti')
  Future<HttpResponse<ViewCutiModel>> getViewCuti({@Field("nik") String? nik});
}
