import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/bloc_state.dart';
import '../../../../../core/data/data_state.dart';
import '../../../../../models/response/employee_model.dart';
import '../../../../../models/response/error_model.dart';
import '../../../../../repository/usecases/get_check_nik.dart';

//Bloc
class RemoteCheckNikBloc extends Bloc<RemoteCheckNikEvent, BaseBlocState> {
  final GetCheckNikUseCase useCase;

  RemoteCheckNikBloc(this.useCase) : super(BaseResponseDefault()) {
    on<GetCheckNik>(onLoad);
  }

  void onLoad(GetCheckNik event, Emitter<BaseBlocState> emit) async {
    emit(BaseResponseLoading());
    final dataState = await useCase.getCheckNik(nik: event.nik);

    if (dataState is DataSuccess) {
      if (dataState.data?.status == "ACTIVE") {
        emit(CheckNikResponseDone(dataState.data!));
        return;
      }
      emit(BaseResponseError(
          ErrorModel(message: "Data User Sudah Tidak Aktif")));
    }

    if (dataState is DataFailed) {
      emit(BaseResponseError(dataState.error!));
    }
  }
}

//Event
abstract class RemoteCheckNikEvent {
  final String? nik;
  const RemoteCheckNikEvent({this.nik});
}

class OnLoadCheckNik extends RemoteCheckNikEvent {
  OnLoadCheckNik() : super();
}

class GetCheckNik extends RemoteCheckNikEvent {
  GetCheckNik(String nik) : super(nik: nik);
}

//State
class CheckNikResponseDone extends BaseBlocState {
  final EmployeeModel model;

  CheckNikResponseDone(this.model);
}
