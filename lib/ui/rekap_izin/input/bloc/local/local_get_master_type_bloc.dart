import 'package:deka_mobile/models/entities/master_reason_type/master_reason_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/bloc_state.dart';
import '../../../../../core/data/data_state.dart';
import '../../../../../repository/usecases/get_master_reason.dart';

//Bloc
class LocalGetMasterTypeBloc
    extends Bloc<LocalGetMasterTypeEvent, BaseBlocState> {
  final GetMasterReasonTypeUseCase useCase;

  LocalGetMasterTypeBloc(this.useCase) : super(BaseResponseDefault()) {
    on<GetMasterReasonType>(onLoad);
  }

  void onLoad(GetMasterReasonType event, Emitter<BaseBlocState> emit) async {
    emit(BaseResponseLoading());
    final dataState = await useCase.getMasterReasonType();

    if (dataState is DataSuccess) {
      emit(GetMasterReasonTypeDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(BaseResponseError(dataState.error!));
    }
  }
}

//Event
abstract class LocalGetMasterTypeEvent {
  const LocalGetMasterTypeEvent();
}

class GetMasterReasonType extends LocalGetMasterTypeEvent {
  GetMasterReasonType() : super();
}

class GetMasterReasonTypeDone extends BaseBlocState {
  List<MasterReasonTypeEntity> model;

  GetMasterReasonTypeDone(this.model);
}
