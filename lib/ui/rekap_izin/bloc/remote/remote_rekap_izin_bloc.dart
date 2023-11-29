import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/data_state.dart';
import '../../../../../repository/usecases/get_rekap_izin.dart';
import '../../../../core/data/bloc_state.dart';
import '../../../../models/response/rekap_izin_model.dart';

//Bloc
class RemoteRekapIzinBloc extends Bloc<RemoteRekapIzinEvent, BaseBlocState> {
  final GetRekapIzinUseCase useCase;

  RemoteRekapIzinBloc(this.useCase) : super(BaseResponseDefault()) {
    on<GetRekapIzin>(onRekapIzin);
  }

  void onRekapIzin(GetRekapIzin event, Emitter<BaseBlocState> emit) async {
    emit(BaseResponseLoading());
    final dataState = await useCase.getRekapIzin();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RekapIzinDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(BaseResponseError(dataState.error!));
    }
  }
}

//Event
abstract class RemoteRekapIzinEvent {
  const RemoteRekapIzinEvent();
}

class GetRekapIzin extends RemoteRekapIzinEvent {
  GetRekapIzin() : super();
}

class RekapIzinDone extends BaseBlocState {
  List<RekapIzinModel> model;

  RekapIzinDone(this.model);
}
