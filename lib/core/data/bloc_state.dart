import '../../models/response/error_model.dart';

abstract class BaseBlocState {}

class BaseResponseDefault extends BaseBlocState {}

class BaseResponseLoading extends BaseBlocState {}

class BaseResponseError extends BaseBlocState {
  final ErrorModel error;

  BaseResponseError(this.error);
}