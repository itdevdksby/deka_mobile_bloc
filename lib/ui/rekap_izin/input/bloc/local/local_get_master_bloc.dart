import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/bloc_state.dart';
import '../../../../../core/data/data_state.dart';
import '../../../../../models/entities/master_reason_hc/master_reason_hc.dart';
import '../../../../../repository/usecases/get_master_reason.dart';

//Bloc
class LocalGetMasterBloc
    extends Bloc<LocalGetMasterEvent, BaseBlocState> {
  final GetMasterReasonUseCase useCase;

  LocalGetMasterBloc(this.useCase) : super(BaseResponseDefault()) {
    on<GetMasterReason>(onLoad);
  }

  void onLoad(GetMasterReason event, Emitter<BaseBlocState> emit) async {
    emit(BaseResponseLoading());
    final dataState = await useCase.getMasterReason(type: event.type);

    if (dataState is DataSuccess) {
      emit(GetMasterReasonDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(BaseResponseError(dataState.error!));
    }
  }
}

//Event
abstract class LocalGetMasterEvent {
  final int? type;
  const LocalGetMasterEvent({this.type});
}

class GetMasterReason extends LocalGetMasterEvent {
  GetMasterReason(int type) : super(type: type);
}

class GetMasterReasonDone extends BaseBlocState {
  List<MasterReasonHcEntity> model;

  GetMasterReasonDone(this.model);
}
