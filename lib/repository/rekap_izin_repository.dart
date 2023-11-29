// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import '../config/database_config.dart';
import '../config/service/rekap_izin/rekap_izin_service.dart';
import '../core/data/data_state.dart';
import '../models/domain/save_rekap_izin_domain.dart';
import '../models/entities/profile/profile.dart';
import '../models/response/error_model.dart';
import '../models/response/rekap_izin_model.dart';
import '../models/response/view_cuti_model.dart';

//domain - repository
abstract class RekapIzinRepository {
  Future<DataState<ProfileEntity>> getProfile();

  Future<DataState<ViewCutiModel>> getViewCuti();

  Future<DataState<List<RekapIzinModel>>> getRekapIzin();

  Future<DataState<String>> saveRekapIzin(SaveRekapIzinDomain domain);
}

//data - repository
class RekapIzinRepositoryImpl extends RekapIzinRepository {
  final RekapIzinService _rekapIzinService;
  final DatabaseConfig _databaseConfig;

  RekapIzinRepositoryImpl(this._rekapIzinService, this._databaseConfig);

  @override
  Future<DataState<ProfileEntity>> getProfile() async {
    final models = await _databaseConfig.profileDao.getProfile();
    if (models.isEmpty) throw DataFailed(ErrorModel());

    return DataSuccess(models.first);
  }

  @override
  Future<DataState<ViewCutiModel>> getViewCuti() async {
    try {
      final profile = await getProfile();
      final httpResponse =
          await _rekapIzinService.getViewCuti(nik: profile.data?.nik);

      final totalWaiting =
          int.tryParse(httpResponse.data.totalWaiting ?? "0") ?? 0;
      final totalApproved =
          int.tryParse(httpResponse.data.totalApproved ?? "0") ?? 0;
      final totalRejected =
          int.tryParse(httpResponse.data.totalReject ?? "0") ?? 0;
      final totalIzin = totalWaiting + totalApproved + totalRejected;
      httpResponse.data.totalIzin = totalIzin.toString();

      return DataSuccess(httpResponse.data);
    } on ErrorModel catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<RekapIzinModel>>> getRekapIzin() async {
    try {
      final profile = await getProfile();
      final httpResponse =
          await _rekapIzinService.getRekapIzin(nik: profile.data?.nik);
      return DataSuccess(httpResponse.data);
    } on ErrorModel catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> saveRekapIzin(SaveRekapIzinDomain domain) async {
    try {
      if (domain.photo_1_temp != null) {
        final imageBytes = await File(domain.photo_1_temp!).readAsBytes();
        final photoBase64 = base64Encode(imageBytes);

        domain.photo_1 = "data:@file/png;base64,$photoBase64";
      }
      domain.latitude = "37.4219983";
      domain.longitude = "-122.084";

      final data = jsonEncode(domain);
      final httpResponse =
          await _rekapIzinService.saveRekapIzin(data: data.toString());

      return DataSuccess(httpResponse.data.message!);
    } on ErrorModel catch (e) {
      return DataFailed(e);
    }
  }
}
