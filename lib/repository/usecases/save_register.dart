import '../../core/data/data_state.dart';
import '../../models/domain/register_domain.dart';
import '../../models/response/general_model.dart';
import '../login_repository.dart';

abstract class SaveRegisterUseCaseImpl<Type, Params> {
  Future<Type> register({Params domain});
}

class SaveRegisterUseCase
    implements
        SaveRegisterUseCaseImpl<DataState<GeneralModel>, RegisterDomain> {
  final LoginRepository _repository;
  SaveRegisterUseCase(this._repository);

  @override
  Future<DataState<GeneralModel>> register({RegisterDomain? domain}) {
    return _repository.register(domain!);
  }
}
