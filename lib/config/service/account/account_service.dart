import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../extensions/constants.dart';
import '../../../models/response/employee_model.dart';
import '../../../models/response/error_model.dart';
import '../../../models/response/general_model.dart';
import '../../../models/response/login_model.dart';

part 'account_service_impl.dart';

@RestApi(baseUrl: BASE_URL)
abstract class AccountService {
  factory AccountService(Dio dio) = AccountServiceImpl;

  @FormUrlEncoded()
  @POST('login')
  Future<HttpResponse<LoginModel>> getLogin(
      {@Field("username") String? username,
      @Field("password") String? password,
      @Field("firebase_id") String? firebaseId});

  @GET('reset-password')
  Future<HttpResponse<GeneralModel>> getReset({@Query("nik") String? nik});

  @GET('sync-data-hris')
  Future<HttpResponse<EmployeeModel>> checkNik(
      {@Query("code") String? code, @Query("nik") String? nik});

  @FormUrlEncoded()
  @POST('register-user')
  Future<HttpResponse<GeneralModel>> register({@Field("data") String? data});
}
