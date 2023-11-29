import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/data_state.dart';
import '../../../../core/data/bloc_state.dart';
import '../../../../models/entities/profile/profile.dart';
import '../../../../repository/usecases/get_login.dart';

//Bloc
class LocalProfileBloc extends Bloc<LocalProfileEvent, BaseBlocState> {
  final GetLoginUseCase useCase;

  LocalProfileBloc(this.useCase) : super(BaseResponseDefault()) {
    on<GetProfile>(onLoad);
  }

  void onLoad(GetProfile event, Emitter<BaseBlocState> emit) async {
    final dataState = await useCase.getProfile();

    if (dataState is DataSuccess) {
      emit(ProfileResponseDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(BaseResponseError(dataState.error!));
    }
  }
}

//Event
abstract class LocalProfileEvent {}

class GetProfile extends LocalProfileEvent {
  GetProfile() : super();
}

//State
class ProfileResponseDone extends BaseBlocState {
  final ProfileEntity model;

  ProfileResponseDone(this.model);
}
