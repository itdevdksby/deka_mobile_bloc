import '../../core/data/data_state.dart';
import '../../models/response/view_cuti_model.dart';
import '../rekap_izin_repository.dart';

abstract class GetViewCutiUseCaseImpl<Type, Params> {
  Future<Type> getViewCuti();
}

class GetViewCutiUseCase
    implements GetViewCutiUseCaseImpl<DataState<ViewCutiModel>, String> {
  final RekapIzinRepository _repository;
  GetViewCutiUseCase(this._repository);

  @override
  Future<DataState<ViewCutiModel>> getViewCuti() {
    return _repository.getViewCuti();
  }
}
