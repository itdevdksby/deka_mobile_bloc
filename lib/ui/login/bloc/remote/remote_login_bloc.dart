import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/data_state.dart';
import '../../../../core/data/bloc_state.dart';
import '../../../../models/entities/profile/profile.dart';
import '../../../../repository/usecases/get_login.dart';
import '../../../../repository/usecases/get_sync_data_master.dart';

//Bloc
class RemoteLoginBloc extends Bloc<RemoteLoginEvent, BaseBlocState> {
  final GetLoginUseCase useCase;
  final SyncDataMasterUseCase useCaseSyncDataMaster;

  RemoteLoginBloc(this.useCase, this.useCaseSyncDataMaster)
      : super(BaseResponseDefault()) {
    on<GetLogin>(onLoad);
  }

  void onLoad(GetLogin event, Emitter<BaseBlocState> emit) async {
    emit(BaseResponseLoading());
    final dataState = await useCase.getLogin(
        username: event.username, password: event.password);

    if (dataState is DataSuccess) {
      emit(SyncDataMasterResponse("Sedang Sync Data Master"));
      final syncDataMaster = await useCaseSyncDataMaster.syncDataMaster();

      emit(SyncDataMasterResponse("Sedang Sync Data Reason Type"));
      await useCaseSyncDataMaster.updateMasterReasonType(syncDataMaster.data!);

      emit(SyncDataMasterResponse("Sedang Sync Data Reason"));
      await useCaseSyncDataMaster.updateMasterReason(syncDataMaster.data!).whenComplete(() => emit(LoginResponseDone(dataState.data!)));
    }

    if (dataState is DataFailed) {
      emit(BaseResponseError(dataState.error!));
    }
  }
}

//Event
abstract class RemoteLoginEvent {
  final String? username;
  final String? password;
  const RemoteLoginEvent({this.username, this.password});
}

class GetLogin extends RemoteLoginEvent {
  GetLogin(String username, String password)
      : super(username: username, password: password);
}

//State
class LoginResponseDone extends BaseBlocState {
  final ProfileEntity model;

  LoginResponseDone(this.model);
}

class SyncDataMasterResponse extends BaseBlocState {
  final String model;

  SyncDataMasterResponse(this.model);
}
