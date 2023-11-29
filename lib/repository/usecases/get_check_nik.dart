import '../../core/data/data_state.dart';
import '../../models/response/employee_model.dart';
import '../login_repository.dart';

abstract class GetCheckNikUseCaseImpl<Type, Params> {
  Future<Type> getCheckNik({Params nik});
}

class GetCheckNikUseCase
    implements GetCheckNikUseCaseImpl<DataState<EmployeeModel>, String> {
  final LoginRepository _repository;
  GetCheckNikUseCase(this._repository);

  @override
  Future<DataState<EmployeeModel>> getCheckNik({String? nik}) {
    return _repository.getCheckNik(nik!);
  }
}
