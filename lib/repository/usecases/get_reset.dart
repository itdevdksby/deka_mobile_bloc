import '../../core/data/data_state.dart';
import '../../models/response/general_model.dart';
import '../login_repository.dart';

abstract class GetResetUseCaseImpl<Type, Params> {
  Future<Type> getReset({Params nik});
}

class GetResetUseCase
    implements GetResetUseCaseImpl<DataState<GeneralModel>, String> {
  final LoginRepository _repository;
  GetResetUseCase(this._repository);

  @override
  Future<DataState<GeneralModel>> getReset({String? nik}) {
    return _repository.getReset(nik!);
  }
}
