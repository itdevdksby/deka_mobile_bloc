import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/data_state.dart';
import '../../../../core/data/bloc_state.dart';
import '../../../../models/response/sync_data_master_model.dart';
import '../../../../repository/usecases/get_sync_data_master.dart';

//Bloc
class RemoteSyncDataMasterBloc
    extends Bloc<RemoteSyncDataMasterEvent, BaseBlocState> {
  final SyncDataMasterUseCase useCase;

  RemoteSyncDataMasterBloc(this.useCase) : super(BaseResponseDefault()) {
    on<SyncDataMaster>(onLoad);
  }

  void onLoad(SyncDataMaster event, Emitter<BaseBlocState> emit) async {
    final dataState = await useCase.syncDataMaster();

    if (dataState is DataSuccess) {
      emit(SyncDataMasterResponseDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(BaseResponseError(dataState.error!));
    }
  }
}

//Event
abstract class RemoteSyncDataMasterEvent {
  const RemoteSyncDataMasterEvent();
}

class SyncDataMaster extends RemoteSyncDataMasterEvent {
  SyncDataMaster() : super();
}

//State
class SyncDataMasterResponseDone extends BaseBlocState {
  final SyncDataMasterModel model;

  SyncDataMasterResponseDone(this.model);
}
