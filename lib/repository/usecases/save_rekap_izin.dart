import '../../core/data/data_state.dart';
import '../../models/domain/save_rekap_izin_domain.dart';
import '../rekap_izin_repository.dart';

abstract class SaveRekapIzinUseCaseImpl<Type, Params> {
  Future<Type> saveRekapIzin({Params domain});
}

class SaveRekapIzinUseCase implements SaveRekapIzinUseCaseImpl<DataState<String>, SaveRekapIzinDomain> {
  final RekapIzinRepository _repository;
  SaveRekapIzinUseCase(this._repository);

  @override
  Future<DataState<String>> saveRekapIzin({SaveRekapIzinDomain ? domain}) {
    return _repository.saveRekapIzin(domain!);
  }
}
