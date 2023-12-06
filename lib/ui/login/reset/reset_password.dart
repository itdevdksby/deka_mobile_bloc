// ignore_for_file: prefer_const_constructors';, prefer_const_constructors, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/data/bloc_state.dart';
import '../../../di/di.dart';
import '../../../extensions/constants.dart';
import '../../../resource/colors.dart';
import '../../../resource/showSnackbarMessage.dart';
import 'bloc/remote/remote_reset_bloc.dart';

class ResetPassword extends StatefulWidget {
  static const nameRoute = '/ResetPassword';
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  var valueNik = "";
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteResetBloc>(
        create: (context) => get()..onEvent(OnLoad()),
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
        ));
  }

  _buildAppBar() {
    return AppBar(title: Text(varReset));
  }

  _buildBody() {
    return Builder(
        builder: (context) => BlocBuilder<RemoteResetBloc, BaseBlocState>(
              builder: (_, state) {
                if (state is BaseResponseLoading) {
                  _isLoading = true;
                }
                if (state is BaseResponseError) {
                  _isLoading = false;
                  WidgetsBinding.instance.addPostFrameCallback((_) =>
                      showSnackBarMessage(context, TypeMessage.ERROR,
                          state.error.message!, DurationMessage.LENGTH_SHORT));
                }
                if (state is ResetResponseDone) {
                  _isLoading = false;
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => Get.back());
                }

                return SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Column(children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                style: TextStyle(fontSize: 15),
                                validator: (value) {
                                  valueNik = value!;
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "NIK",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            BorderSide(color: colorPrimary)),
                                    contentPadding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    filled: true,
                                    fillColor: Colors.black12),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 20),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (!_isLoading)
                                        BlocProvider.of<RemoteResetBloc>(
                                                context,
                                                listen: false)
                                            .add(GetReset(valueNik));
                                    }
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: _isLoading
                                          ? MaterialStateProperty.all(
                                              Colors.grey)
                                          : MaterialStateProperty.all(
                                              colorPrimaryDark),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)))),
                                  child: _isLoading
                                      ? Padding(
                                          padding: EdgeInsets.all(5),
                                          child: SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              )))
                                      : Text("S U B M I T",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800)),
                                ),
                              )), //Button
                        ])));
              },
            ));
  }
}
