import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/data_state.dart';
import '../../../../core/data/bloc_state.dart';
import '../../../../models/response/view_cuti_model.dart';
import '../../../../repository/usecases/get_view_cuti.dart';

//Bloc
class RemoteViewCutiBloc extends Bloc<RemoteViewCutiEvent, BaseBlocState> {
  final GetViewCutiUseCase useCase;

  RemoteViewCutiBloc(this.useCase) : super(BaseResponseDefault()) {
    on<GetViewCuti>(onLoad);
  }

  void onLoad(GetViewCuti event, Emitter<BaseBlocState> emit) async {
    emit(BaseResponseLoading());
    final dataState = await useCase.getViewCuti();

    if (dataState is DataSuccess) {
      emit(ViewCutiResponseDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(BaseResponseError(dataState.error!));
    }
  }
}

//Event
abstract class RemoteViewCutiEvent {
  const RemoteViewCutiEvent();
}

class GetViewCuti extends RemoteViewCutiEvent {
  GetViewCuti() : super();
}

//State
class ViewCutiResponseDone extends BaseBlocState {
  final ViewCutiModel model;

  ViewCutiResponseDone(this.model);
}
