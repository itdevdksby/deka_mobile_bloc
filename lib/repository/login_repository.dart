import 'dart:convert';
import 'dart:io';

import '../config/database_config.dart';
import '../config/service/account/account_service.dart';
import '../core/data/data_state.dart';
import '../core/data/device_info.dart';
import '../models/domain/register_domain.dart';
import '../models/entities/profile/profile.dart';
import '../models/mapper/profile_mapper.dart';
import '../models/response/employee_model.dart';
import '../models/response/error_model.dart';
import '../models/response/general_model.dart';
import '../models/response/login_model.dart';

abstract class LoginRepository {
  Future<DataState<ProfileEntity>> getLogin(String username, String password);

  Future<DataState<ProfileEntity>> getProfile();

  Future<void> deleteProfileAll();

  Future<void> insertProfile(LoginModel model);

  Future<DataState<GeneralModel>> getReset(String nik);

  Future<DataState<EmployeeModel>> getCheckNik(String nik);

  Future<DataState<GeneralModel>> register(RegisterDomain domain);
}

class LoginRepositoryImpl extends LoginRepository {
  final AccountService _accountService;
  final DatabaseConfig _databaseConfig;

  LoginRepositoryImpl(this._accountService, this._databaseConfig);

  @override
  Future<DataState<ProfileEntity>> getLogin(
      String username, String password) async {
    try {
      final httpResponse = await _accountService.getLogin(
          username: username, password: password, firebaseId: "Unknown");

      deleteProfileAll();
      insertProfile(httpResponse.data);

      return getProfile();
    } on ErrorModel catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<ProfileEntity>> getProfile() async {
    try {
      final models = await _databaseConfig.profileDao.getProfile();
      if (models.isEmpty) throw DataFailed(ErrorModel());

      return DataSuccess(models.first);
    } on ErrorModel catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<void> insertProfile(LoginModel model) {
    final profileMapper = ProfileMapper(model);
    return _databaseConfig.profileDao.insertEntity(profileMapper);
  }

  @override
  Future<void> deleteProfileAll() {
    return _databaseConfig.profileDao.deleteAll();
  }

  @override
  Future<DataState<EmployeeModel>> getCheckNik(String nik) async {
    try {
      final httpResponse =
          await _accountService.checkNik(code: "10000", nik: nik);

      return DataSuccess(httpResponse.data);
    } on ErrorModel catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<GeneralModel>> getReset(String nik) async {
    try {
      final httpResponse = await _accountService.getReset(nik: nik);

      return DataSuccess(httpResponse.data);
    } on ErrorModel catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<GeneralModel>> register(RegisterDomain domain) async {
    try {
      final deviceInfo = await getDeviceInfo();
      domain.device_brand = deviceInfo.brand;
      domain.device_type = deviceInfo.model;
      domain.device_id = deviceInfo.deviceId;

      if (domain.foto_temp != null) {
        final imageBytes = await File(domain.foto_temp!).readAsBytes();
        final photoBase64 = base64Encode(imageBytes);

        domain.foto = "data:@file/png;base64,$photoBase64";
      }

      final json = jsonEncode(domain).toString();
      final httpResponse = await _accountService.register(data: json);
      return DataSuccess(httpResponse.data);
    } on ErrorModel catch (e) {
      return DataFailed(e);
    }
  }
}
