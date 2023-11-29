import '../../core/data/data_state.dart';
import '../../models/response/sync_data_master_model.dart';
import '../sync_data_master_repository.dart';

abstract class SyncDataMasterUseCaseImpl<Type, Params> {
  Future<Type> syncDataMaster();
  Future<Type> updateMasterReasonType(SyncDataMasterModel model);
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

  Future<DataState<SyncDataMasterModel>> updateMasterReason(
      SyncDataMasterModel model) {
    return _repository.updateMasterReason(model);
  }
}
