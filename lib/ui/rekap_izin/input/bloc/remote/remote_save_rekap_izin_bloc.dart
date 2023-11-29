import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/bloc_state.dart';
import '../../../../../core/data/data_state.dart';
import '../../../../../models/domain/save_rekap_izin_domain.dart';
import '../../../../../repository/usecases/save_rekap_izin.dart';

//Bloc
class RemoteSaveRekapIzinBloc
    extends Bloc<RemoteSaveRekapIzinEvent, BaseBlocState> {
  final SaveRekapIzinUseCase useCase;

  RemoteSaveRekapIzinBloc(this.useCase) : super(BaseResponseDefault()) {
    on<SaveRekapIzin>(onLoad);
  }

  void onLoad(SaveRekapIzin event, Emitter<BaseBlocState> emit) async {
    emit(BaseResponseLoading());
    final dataState = await useCase.saveRekapIzin(domain: event.domain);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(SaveRekapIzinDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(BaseResponseError(dataState.error!));
    }
  }
}

//Event
abstract class RemoteSaveRekapIzinEvent {
  final SaveRekapIzinDomain? domain;
  const RemoteSaveRekapIzinEvent({this.domain});
}

class SaveRekapIzin extends RemoteSaveRekapIzinEvent {
  SaveRekapIzin(SaveRekapIzinDomain domain) : super(domain: domain);
}

class SaveRekapIzinDone extends BaseBlocState {
  String model;

  SaveRekapIzinDone(this.model);
}
