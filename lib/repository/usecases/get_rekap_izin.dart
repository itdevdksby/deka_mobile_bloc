import '../../core/data/data_state.dart';
import '../../models/response/rekap_izin_model.dart';
import '../rekap_izin_repository.dart';

abstract class GetRekapIzinUseCaseImpl<Type, Params> {
  Future<Type> getRekapIzin();
}

class GetRekapIzinUseCase
    implements
        GetRekapIzinUseCaseImpl<DataState<List<RekapIzinModel>>, String> {
  final RekapIzinRepository _repository;
  GetRekapIzinUseCase(this._repository);

  @override
  Future<DataState<List<RekapIzinModel>>> getRekapIzin() {
    return _repository.getRekapIzin();
  }
}
