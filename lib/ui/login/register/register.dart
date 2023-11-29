// ignore_for_file: prefer_const_constructors';, prefer_const_constructors, invalid_use_of_protected_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/data/bloc_state.dart';
import '../../../core/picker_photo/picker_photo.dart';
import '../../../core/single_select/single_select_dialog.dart';
import '../../../di/di.dart';
import '../../../extensions/constants.dart';
import '../../../models/domain/register_domain.dart';
import '../../../resource/colors.dart';
import '../../../resource/showSnackbarMessage.dart';
import '../../../ui/login/register/bloc/remote/remote_check_nik_bloc.dart';
import '../../../ui/login/register/bloc/remote/remote_register_bloc.dart';

class Register extends StatefulWidget {
  static const nameRoute = 'Register';

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final domain = RegisterDomain();
  var _isLoading = false;
  var _isLoadingNik = false;
  var _isVisibleData = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<RemoteRegisterBloc>(
              create: (context) => get()..onEvent(OnLoadRegister())),
          BlocProvider<RemoteCheckNikBloc>(
              create: (context) => get()..onEvent(OnLoadCheckNik())),
        ],
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
        ));
  }

  _buildAppBar() {
    return AppBar(title: Text(varRegister));
  }

  _buildBody() {
    return Builder(
        builder: (context) => BlocBuilder<RemoteRegisterBloc, BaseBlocState>(
              builder: (_, state) {
                if (state is BaseResponseLoading) {
                  _isLoading = true;
                  FocusScope.of(context).unfocus();
                }
                if (state is BaseResponseError) {
                  _isLoading = false;
                  WidgetsBinding.instance.addPostFrameCallback((_) =>
                      showSnackBarMessage(context, TypeMessage.ERROR,
                          state.error.message!, DurationMessage.LENGTH_SHORT));
                }
                if (state is RegisterResponseDone) {
                  _isLoading = false;
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => Navigator.of(context).pop());
                }

                return _buildForm();
              },
            ));
  }

  _buildForm() {
    return Builder(
        builder: (context) =>
            BlocBuilder<RemoteCheckNikBloc, BaseBlocState>(builder: (_, state) {
              if (state is BaseResponseLoading) {
                _isLoadingNik = true;
                FocusScope.of(context).unfocus();
              }
              if (state is BaseResponseError) {
                _isLoadingNik = false;
                _isVisibleData = false;
                WidgetsBinding.instance.addPostFrameCallback((_) =>
                    showSnackBarMessage(context, TypeMessage.ERROR,
                        state.error.message!, DurationMessage.LENGTH_SHORT));
              }
              if (state is CheckNikResponseDone) {
                _isLoadingNik = false;
                _isVisibleData = true;

                domain.nik = state.model.nik;
                domain.name = state.model.name;
                domain.ktp = state.model.idNumber;
                domain.email = state.model.emailAddress;
                domain.phone_1 = state.model.mobilePhone;
                domain.address = state.model.currentAddress;
                domain.tempat_lahir = state.model.birthPlace;
                domain.tgl_lahir = DateFormat('yyyy-MM-dd').format(
                    DateFormat('dd/MM/yyyy')
                        .parse(state.model.dateOfBirth ?? ""));
                domain.cost_center_code = state.model.costCenterCode;
                domain.cost_center_desc = state.model.costCenterDescription;
                domain.jabatan_code = state.model.gradeCode;
                domain.jabatan_desc = state.model.gradeDescription;
                domain.organization_level = state.model.orgLevelDescription;
                domain.organization_level_desc =
                    state.model.orgLevelDescription;
              }

              return SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(children: [
                        Row(children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 5, top: 10, bottom: 5),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    maxLength: 8,
                                    style: TextStyle(fontSize: 15),
                                    validator: (value) {
                                      domain.nik = value;
                                      return null;
                                    },
                                    onChanged: (value) {
                                      domain.nik = value;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "NIK",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: colorPrimary)),
                                        contentPadding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        filled: true,
                                        fillColor: Colors.black12),
                                  ))),
                          ElevatedButton(
                            onPressed: () {
                              if (domain.nik == null ||
                                  (domain.nik?.length ?? 0) < 8) {
                                WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => showSnackBarMessage(
                                        context,
                                        TypeMessage.ERROR,
                                        "NIK tidak lengkap",
                                        DurationMessage.LENGTH_SHORT));
                              } else {
                                BlocProvider.of<RemoteCheckNikBloc>(context,
                                        listen: false)
                                    .add(GetCheckNik(domain.nik!));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(10),
                                backgroundColor: colorPrimary),
                            child: _isLoadingNik
                                ? SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ))
                                : Icon(Icons.search),
                          )
                        ]),
                        Visibility(
                            visible: _isVisibleData,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 5, bottom: 5),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black54),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                child: Column(children: [
                                  Row(children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 10),
                                        child: Text("Foto Profil")),
                                    Expanded(child: Container()),
                                    IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.orangeAccent),
                                        onPressed: () {
                                          pickerPhoto(ImageSource.camera,
                                              (path) {
                                            setState(() {
                                              domain.foto_temp = path;
                                            });
                                          });
                                        }),
                                  ]),
                                  Container(
                                      width: double.infinity,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        image: DecorationImage(
                                            image: FileImage(
                                                File(domain.foto_temp ?? "")),
                                            fit: BoxFit.cover),
                                      ))
                                ]),
                              ),
                            )),
                        Visibility(
                            visible: _isVisibleData,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5),
                                child: TextFormField(
                                  controller: TextEditingController()
                                    ..text = domain.ktp ?? "",
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  readOnly: true,
                                  style: TextStyle(fontSize: 15),
                                  validator: (value) {
                                    domain.ktp = value!;
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "KTP",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: colorPrimary)),
                                      contentPadding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      filled: true,
                                      fillColor: Colors.black12),
                                ))),
                        Visibility(
                            visible: _isVisibleData,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5),
                                child: TextFormField(
                                  controller: TextEditingController()
                                    ..text = domain.name ?? "",
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  readOnly: true,
                                  style: TextStyle(fontSize: 15),
                                  validator: (value) {
                                    domain.name = value!;
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Nama",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: colorPrimary)),
                                      contentPadding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      filled: true,
                                      fillColor: Colors.black12),
                                ))),
                        Visibility(
                            visible: _isVisibleData,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5),
                                child: TextFormField(
                                  controller: TextEditingController()
                                    ..text = domain.email ?? "",
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  readOnly: true,
                                  style: TextStyle(fontSize: 15),
                                  validator: (value) {
                                    domain.email = value!;
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: colorPrimary)),
                                      contentPadding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      filled: true,
                                      fillColor: Colors.black12),
                                ))),
                        Visibility(
                            visible: _isVisibleData,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5),
                                child: TextFormField(
                                  controller: TextEditingController()
                                    ..text = domain.phone_1 ?? "",
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  readOnly: true,
                                  style: TextStyle(fontSize: 15),
                                  validator: (value) {
                                    domain.phone_1 = value!;
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "No. Telpon",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: colorPrimary)),
                                      contentPadding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      filled: true,
                                      fillColor: Colors.black12),
                                ))),
                        Visibility(
                            visible: _isVisibleData,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5),
                                child: TextFormField(
                                  controller: TextEditingController()
                                    ..text = domain.address ?? "",
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  readOnly: true,
                                  style: TextStyle(fontSize: 15),
                                  validator: (value) {
                                    domain.address = value!;
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Alamat",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: colorPrimary)),
                                      contentPadding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      filled: true,
                                      fillColor: Colors.black12),
                                ))),
                        Visibility(
                            visible: _isVisibleData,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5),
                                child: TextFormField(
                                  controller: TextEditingController()
                                    ..text =
                                        "${domain.tempat_lahir}, ${DateFormat("dd-MM-yyyy").format(DateTime.parse(domain.tgl_lahir ?? "${DateTime.now()}"))}",
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  readOnly: true,
                                  style: TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                      hintText: "Tempat, Tanggal Lahir",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: colorPrimary)),
                                      contentPadding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      filled: true,
                                      fillColor: Colors.black12),
                                ))),
                        Visibility(
                            visible: _isVisibleData,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5),
                                child: TextFormField(
                                  controller: TextEditingController()
                                    ..text = domain.cost_center_desc ?? "",
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  readOnly: true,
                                  style: TextStyle(fontSize: 15),
                                  validator: (value) {
                                    domain.cost_center_desc = value!;
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Cost Center",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: colorPrimary)),
                                      contentPadding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      filled: true,
                                      fillColor: Colors.black12),
                                ))),
                        Visibility(
                            visible: _isVisibleData,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5),
                                child: TextFormField(
                                  controller: TextEditingController()
                                    ..text = domain.jabatan_desc ?? "",
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  readOnly: true,
                                  style: TextStyle(fontSize: 15),
                                  validator: (value) {
                                    domain.jabatan_desc = value!;
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Jabatan",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: colorPrimary)),
                                      contentPadding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      filled: true,
                                      fillColor: Colors.black12),
                                ))),
                        Visibility(
                            visible: _isVisibleData,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5),
                                child: TextFormField(
                                  controller: TextEditingController()
                                    ..text =
                                        domain.organization_level_desc ?? "",
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  readOnly: true,
                                  style: TextStyle(fontSize: 15),
                                  validator: (value) {
                                    domain.organization_level_desc = value!;
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Organisasi",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: colorPrimary)),
                                      contentPadding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      filled: true,
                                      fillColor: Colors.black12),
                                ))),
                        Visibility(
                            visible: _isVisibleData,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5),
                                child: TextFormField(
                                  controller: TextEditingController()
                                    ..text = domain.lokasi_desc ?? "",
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  readOnly: true,
                                  style: TextStyle(fontSize: 15),
                                  onTap: () {
                                    dialogSingleSelect(context, listLokasi,
                                        (idIndex, model) {
                                      domain.lokasi = model.codeOrId!;
                                      domain.lokasi_desc = model.message!;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Isian ini masih kosong";
                                    }
                                    domain.lokasi_desc = value;
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Lokasi",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: colorPrimary)),
                                      contentPadding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      filled: true,
                                      fillColor: Colors.black12),
                                ))),
                        Visibility(
                            visible: _isVisibleData,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 10),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (!_isLoading) {
                                          BlocProvider.of<RemoteRegisterBloc>(
                                                  context,
                                                  listen: false)
                                              .add(GetRegister(domain));
                                        }
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
                                                    BorderRadius.circular(
                                                        20)))),
                                    child: _isLoading
                                        ? Padding(
                                            padding: EdgeInsets.all(5),
                                            child: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2,
                                                )))
                                        : Text("S U B M I T",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800)),
                                  ),
                                ))), //Button
                      ])));
            }));
  }
}
