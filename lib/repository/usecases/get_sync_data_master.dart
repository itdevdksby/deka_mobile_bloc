import '../../core/data/data_state.dart';
import '../../models/response/sync_data_master_model.dart';
import '../sync_data_master_repository.dart';

abstract class SyncDataMasterUseCaseImpl<Type, Params> {
  Future<Type> syncDataMaster();
  Future<Type> updateMasterReasonType(SyncDataMasterModel model);
  Future<Type> updateMasterReasonHc(SyncDataMasterModel model);
  Future<Type> updateMasterPic(SyncDataMasterModel model);
  Future<Type> updateMasterAuthMenu(SyncDataMasterModel model);
  Future<Type> updateMasterGlobalParameter(SyncDataMasterModel model);
}

class SyncDataMasterUseCase
    implements
        SyncDataMasterUseCaseImpl<DataState<SyncDataMasterModel>,
            SyncDataMasterModel> {
  final SyncDataMasterRepository _repository;
  SyncDataMasterUseCase(this._repository);

  @override
  Future<DataState<SyncDataMasterModel>> syncDataMaster() {
    return _repository.syncDataMaster();
  }

  @override
  Future<DataState<SyncDataMasterModel>> updateMasterReasonType(
      SyncDataMasterModel model) {
    return _repository.updateMasterReasonType(model);
  }

  @override
  Future<DataState<SyncDataMasterModel>> updateMasterReasonHc(SyncDataMasterModel model) {
    return _repository.updateMasterReasonHc(model);
  }

  @override
  Future<DataState<SyncDataMasterModel>> updateMasterPic(SyncDataMasterModel model) {
    return _repository.updateMasterPic(model);
  }

  @override
  Future<DataState<SyncDataMasterModel>> updateMasterAuthMenu(SyncDataMasterModel model) {
    return _repository.updateMasterAuthMenu(model);
  }

  @override
  Future<DataState<SyncDataMasterModel>> updateMasterGlobalParameter(SyncDataMasterModel model) {
    return _repository.updateMasterGlobalParameter(model);
  }
}
