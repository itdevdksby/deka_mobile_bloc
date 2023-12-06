import 'package:deka_mobile/models/entities/master_reason_type/master_reason_type.dart';
import 'package:deka_mobile/repository/rekap_izin_repository.dart';

import '../../core/data/data_state.dart';
import '../../models/entities/master_reason_hc/master_reason_hc.dart';

abstract class GetMasterReasonTypeUseCaseImpl<Type, Params> {
  Future<Type> getMasterReasonType();
}

class GetMasterReasonTypeUseCase
    implements GetMasterReasonTypeUseCaseImpl<DataState<List<MasterReasonTypeEntity>>, String> {
  final RekapIzinRepository _repository;
  GetMasterReasonTypeUseCase(this._repository);

  @override
  Future<DataState<List<MasterReasonTypeEntity>>> getMasterReasonType() {
    return _repository.getMasterReasonType();
  }
}

abstract class GetMasterReasonUseCaseImpl<Type, Params> {
  Future<Type> getMasterReason({Params type});
}

class GetMasterReasonUseCase
    implements GetMasterReasonUseCaseImpl<DataState<List<MasterReasonHcEntity>>, int> {
  final RekapIzinRepository _repository;
  GetMasterReasonUseCase(this._repository);

  @override
  Future<DataState<List<MasterReasonHcEntity>>> getMasterReason({int? type}) {
    return _repository.getMasterReason(type!);
  }
}
