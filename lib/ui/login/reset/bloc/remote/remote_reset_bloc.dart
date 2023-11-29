import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/bloc_state.dart';
import '../../../../../core/data/data_state.dart';
import '../../../../../models/response/general_model.dart';
import '../../../../../repository/usecases/get_reset.dart';

//Bloc
class RemoteResetBloc extends Bloc<RemoteResetEvent, BaseBlocState> {
  final GetResetUseCase useCase;

  RemoteResetBloc(this.useCase) : super(BaseResponseDefault()) {
    on<GetReset>(onLoad);
  }

  void onLoad(GetReset event, Emitter<BaseBlocState> emit) async {
    emit(BaseResponseLoading());
    final dataState = await useCase.getReset(nik: event.nik);

    if (dataState is DataSuccess) {
      emit(ResetResponseDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(BaseResponseError(dataState.error!));
    }
  }
}

//Event
abstract class RemoteResetEvent {
  final String? nik;
  const RemoteResetEvent({this.nik});
}

class OnLoad extends RemoteResetEvent {
  OnLoad() : super();
}

class GetReset extends RemoteResetEvent {
  GetReset(String nik) : super(nik: nik);
}

//State
class ResetResponseDone extends BaseBlocState {
  final GeneralModel model;

  ResetResponseDone(this.model);
}
