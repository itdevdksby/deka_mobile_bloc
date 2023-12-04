import 'dart:convert';

import 'package:deka_mobile/models/entities/master_auth_menu/master_auth_menu.dart';
import 'package:deka_mobile/models/entities/master_pic/master_pic.dart';
import 'package:intl/intl.dart';

import '../config/database_config.dart';
import '../config/service/other/sync_data_master_service.dart';
import '../core/data/data_state.dart';
import '../extensions/constants.dart';
import '../models/entities/master_reason/master_reason.dart';
import '../models/entities/master_reason_type/master_reason_type.dart';
import '../models/entities/profile/profile.dart';
import '../models/mapper/profile_mapper.dart';
import '../models/response/error_model.dart';
import '../models/response/login_model.dart';
import '../models/response/sync_data_master_model.dart';

abstract class SyncDataMasterRepository {
  Future<DataState<ProfileEntity>> getProfile();

  Future<void> deleteProfileAll();

  Future<void> insertProfile(LoginModel model);

  Future<DataState<SyncDataMasterModel>> syncDataMaster();

  Future<DataState<SyncDataMasterModel>> updateMasterReasonType(
      SyncDataMasterModel model);

  Future<DataState<SyncDataMasterModel>> updateMasterReason(
      SyncDataMasterModel model);

  Future<DataState<SyncDataMasterModel>> updateMasterPic(
      SyncDataMasterModel model);

  Future<DataState<SyncDataMasterModel>> updateMasterAuthMenu(
      SyncDataMasterModel model);

  Future<DataState<SyncDataMasterModel>> updateMasterGlobalParameter(
      SyncDataMasterModel model);
}

class SyncDataMasterRepositoryImpl extends SyncDataMasterRepository {
  final SyncDataMasterService _syncDataMasterService;
  final DatabaseConfig _databaseConfig;

  SyncDataMasterRepositoryImpl(
      this._syncDataMasterService, this._databaseConfig);

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
  Future<DataState<SyncDataMasterModel>> syncDataMaster() async {
    try {
      final profile = await getProfile();
      for (final item in listPengaturanAutocode) {
        final pengaturanAutocode = await _databaseConfig
            .pengaturanAutocodeAndroidDao
            .getPengaturanAutocodeAndroidOne(item.code!);
        if (pengaturanAutocode.isEmpty) {
          _databaseConfig.pengaturanAutocodeAndroidDao.insertEntity(item);
        }
      }

      final slugPengaturanAutocodes = await _databaseConfig
          .pengaturanAutocodeAndroidDao
          .getPengaturanAutocodeAndroid();

      final httpResponse = await _syncDataMasterService.syncDataMaster(
          user_id: profile.data!.userId,
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          slug_database: jsonEncode(slugPengaturanAutocodes));

      return DataSuccess(httpResponse.data);
    } on ErrorModel catch (e) {
      throw DataFailed(e);
    }
  }

  @override
  Future<DataState<SyncDataMasterModel>> updateMasterReasonType(
      SyncDataMasterModel model) async {
    model.hcReasonType?.forEach((element) async {
      await _databaseConfig.masterReasonTypeDao
          .insertEntity(MasterReasonTypeEntity(
        id: int.parse(element.id!),
        name: element.name,
      ));

      await updatePengaturanAutocode("last-sync-hc_reason_type", element.updatedAt ?? "0");
    });

    return DataSuccess(model);
  }

  @override
  Future<DataState<SyncDataMasterModel>> updateMasterReason(
      SyncDataMasterModel model) async {
    model.hcReason?.forEach((element) async {
      await _databaseConfig.masterReasonDao.insertEntity(MasterReasonEntity(
        code: element.code,
        name: element.name,
        type: int.parse(element.idType!),
        keterangan: element.keterangan,
        potong_cuti: element.potongCuti,
      ));

      await updatePengaturanAutocode("last-sync-hc_reason", element.updatedAt ?? "0");
    });

    return DataSuccess(model);
  }

  @override
  Future<DataState<SyncDataMasterModel>> updateMasterPic(SyncDataMasterModel model) async {
    await _databaseConfig.masterPicDao.deleteAll();
    model.hcDataPic?.forEach((element) async {
      await _databaseConfig.masterPicDao.insertEntity(MasterPicEntity(
        id: int.parse(element.code!),
        name: element.name,
        whatsapp: element.phone,
      ));
    });

    await updatePengaturanAutocode("last-sync-hc_data_pic", "0");
    return DataSuccess(model);
  }

  @override
  Future<DataState<SyncDataMasterModel>> updateMasterAuthMenu(SyncDataMasterModel model) async {
    await _databaseConfig.masterAuthMenuDao.deleteAll();
    model.androidAuthMenu?.forEach((element) async {
      await _databaseConfig.masterAuthMenuDao.insertEntity(MasterAuthMenuEntity(
        id: int.parse(element.menuId!),
        slug: element.menuSlug,
        name: element.menuName,
        is_read: int.parse(element.isRead!),
        is_update: int.parse(element.isUpdate!),
        is_create: int.parse(element.isCreate!),
        is_delete: int.parse(element.isDelete!),
        is_approval: int.parse(element.isApproval!)
      ));
    });

    await updatePengaturanAutocode("last-sync-android_auth_menu", "0");
    return DataSuccess(model);
  }

  @override
  Future<DataState<SyncDataMasterModel>> updateMasterGlobalParameter(SyncDataMasterModel model) async {
    if(model.hcAddress != null) {
      await updatePengaturanAutocode(model.hcAddress!.last.slug!, model.hcAddress!.last.value!);
    }

    if(model.hcContact != null) {
      await updatePengaturanAutocode(model.hcContact!.last.slug!, model.hcContact!.last.value!);
    }

    return DataSuccess(model);
  }

  Future<void> updatePengaturanAutocode(String code, String updatedAt) async {
    final entities = await _databaseConfig.pengaturanAutocodeAndroidDao
        .getPengaturanAutocodeAndroidOne(code);

    entities.first.value = updatedAt;
    await _databaseConfig.pengaturanAutocodeAndroidDao
        .updateEntity(entities.first);
  }
}
