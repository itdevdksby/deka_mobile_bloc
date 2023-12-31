// ignore_for_file: prefer_const_constructors, invalid_use_of_protected_member

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:deka_mobile/core/picker_photo/picker_photo.dart';
import 'package:deka_mobile/models/entities/master_reason_type/master_reason_type.dart';
import 'package:deka_mobile/models/response/rekap_izin_model.dart';
import 'package:deka_mobile/ui/rekap_izin/input/bloc/local/local_get_master_bloc.dart';
import 'package:deka_mobile/ui/rekap_izin/input/bloc/local/local_get_master_type_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/data/bloc_state.dart';
import '../../../di/di.dart';
import '../../../extensions/constants.dart';
import '../../../models/domain/save_rekap_izin_domain.dart';
import '../../../models/entities/master_reason_hc/master_reason_hc.dart';
import '../../../resource/colors.dart';
import '../../../resource/showSnackbarMessage.dart';
import '../../../ui/dashboard/bloc/local/local_profile_bloc.dart';
import '../../../ui/rekap_izin/input/bloc/remote/remote_save_rekap_izin_bloc.dart';
import '../../../ui/rekap_izin/input/item/input_rekap_izin_tile.dart';

class InputRekapIzin extends StatefulWidget {
  static const nameRoute = '/InputRekapIzin';
  static const argRekapIzin = 'argRekapIzin';
  const InputRekapIzin({super.key});

  @override
  State<InputRekapIzin> createState() => _InputRekapIzinState();
}

class _InputRekapIzinState extends State<InputRekapIzin> {
  final saveDomain = SaveRekapIzinDomain();
  final _formKey = GlobalKey<FormState>();
  final List<MasterReasonTypeEntity> listTypeIzin = [];
  final List<MasterReasonHcEntity> listKategoriIzin = [];
  var isEnabled = true;
  var isLoading = false;
  var isKeterangan = false;
  var isJamKembali = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final argModel = Get.arguments?[InputRekapIzin.argRekapIzin] == null
          ? null
          : Get.arguments?[InputRekapIzin.argRekapIzin] as RekapIzinModel;

      if(!argModel.isNull) {
        setState(() {
          saveDomain.name = argModel?.name;
          saveDomain.nik = argModel?.nik;
          saveDomain.start_date = argModel?.startDate;
          saveDomain.end_date = argModel?.endDate;
          saveDomain.latitude = argModel?.latitude;
          saveDomain.longitude = argModel?.longitude;
          saveDomain.start_time = argModel?.startTime;
          saveDomain.end_time = argModel?.endTime;
          saveDomain.reason_type = argModel?.reasonType;
          saveDomain.reason_type_name = argModel?.reasonTypeName;
          saveDomain.reason_id = argModel?.reasonId;
          saveDomain.reason_name = argModel?.reasonName;
          saveDomain.keterangan = argModel?.keterangan;
          saveDomain.status_kembali = argModel?.statusKembali;
          saveDomain.photo_1 = argModel?.photo1;

          saveDomain.photo_1_temp = argModel?.photo1;
          saveDomain.start_date_name = DateFormat('dd-MM-yyyy').format(
              DateFormat('yyyy-MM-dd').parse(argModel!.startDate!));
          saveDomain.end_date_name = DateFormat('dd-MM-yyyy').format(
              DateFormat('yyyy-MM-dd').parse(argModel.endDate!));

          isEnabled = false;
          isKeterangan = false;
          isJamKembali = false;
          if(saveDomain.reason_type_name?.toLowerCase() == "full day"){
            isKeterangan = true;
          }else{
            isJamKembali = true;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LocalProfileBloc>(
          create: (context) => get()..add(GetProfile())),
      BlocProvider<RemoteSaveRekapIzinBloc>(
          create: (context) => get()..onEvent(SaveRekapIzin(saveDomain))),
      BlocProvider<LocalGetMasterTypeBloc>(
          create: (context) => get()..add(GetMasterReasonType())),
      BlocProvider<LocalGetMasterBloc>(
          create: (context) => get()..add(GetMasterReason(0))),
    ], child: Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReasonType(),
                _buildReason(),
                _buildBody()
              ]),
        )));
  }

  _buildAppBar() {
    return AppBar(title: Text(varRekapIzin));
  }

  _buildBody() {
    return Builder(
        builder: (context) =>
            BlocBuilder<RemoteSaveRekapIzinBloc, BaseBlocState>(
                builder: (_, state) {
              if (state is BaseResponseLoading) {
                isLoading = true;
              }
              if (state is BaseResponseError) {
                isLoading = false;
                WidgetsBinding.instance.addPostFrameCallback((_) =>
                    showSnackBarMessage(context, TypeMessage.ERROR,
                        state.error.message!, DurationMessage.LENGTH_SHORT));
              }
              if (state is SaveRekapIzinDone) {
                isLoading = false;
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => Get.back());
              }

              return SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<LocalProfileBloc, BaseBlocState>(
                                builder: (_, state) {
                              var textProfile = "";
                              if (state is ProfileResponseDone) {
                                saveDomain.user_id = state.model.userId;
                                saveDomain.nik = state.model.nik;
                                saveDomain.name = state.model.name;

                                textProfile =
                                    "${state.model.nik} - ${state.model.name}";
                              }
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 20, bottom: 10),
                                  child: TextFormField(
                                    controller: TextEditingController()
                                      ..text = textProfile,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(fontSize: 15),
                                    readOnly: true,
                                    enabled: isEnabled,
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
                                      fillColor: Colors.black12,
                                    ),
                                  ));
                            }),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                child: TextFormField(
                                  controller: TextEditingController()
                                    ..text = saveDomain.reason_type_name ?? "",
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(fontSize: 15),
                                  readOnly: true,
                                  enabled: isEnabled,
                                  onTap: () {
                                    _dialogTipeIzin(context);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Isian ini masih kosong";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Tipe Izin",
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
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                child: TextFormField(
                                  controller: TextEditingController()
                                    ..text = saveDomain.reason_name ?? "",
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(fontSize: 15),
                                  readOnly: true,
                                  enabled: isEnabled,
                                  onTap: () {
                                    if (saveDomain.reason_type != null) {
                                      _dialogKategoriIzin(context);
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Isian ini masih kosong";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Kategori Izin",
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
                                )),
                            Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: TextFormField(
                                          controller: TextEditingController()
                                            ..text =
                                                saveDomain.start_date_name ??
                                                    "",
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          style: TextStyle(fontSize: 15),
                                          readOnly: true,
                                          enabled: isEnabled,
                                          onTap: () {
                                            _dialogStartDate(context);
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Isian ini masih kosong";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Tanggal Mulai",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
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
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: TextFormField(
                                          controller: TextEditingController()
                                            ..text =
                                                saveDomain.end_date_name ?? "",
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          style: TextStyle(fontSize: 15),
                                          readOnly: true,
                                          enabled: isEnabled,
                                          onTap: () {
                                            _dialogEndDate(context);
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Isian ini masih kosong";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Tanggal Akhir",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
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
                              ],
                            ),
                            Visibility(visible: isJamKembali, child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: TextFormField(
                                          controller: TextEditingController()
                                            ..text =
                                                saveDomain.start_time ??
                                                    "",
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          style: TextStyle(fontSize: 15),
                                          readOnly: true,
                                          enabled: isEnabled,
                                          onTap: () {
                                            _dialogStartTime(context);
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Isian ini masih kosong";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Jam Mulai",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      30)),
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
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: TextFormField(
                                          controller: TextEditingController()
                                            ..text =
                                                saveDomain.end_time ?? "",
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          style: TextStyle(fontSize: 15),
                                          readOnly: true,
                                          enabled: isEnabled,
                                          onTap: () {
                                            _dialogEndTime(context);
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Isian ini masih kosong";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Jam Kembali",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      30)),
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
                              ],
                            )),
                            Visibility(visible: isKeterangan, child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                child: TextFormField(
                                  controller: TextEditingController()
                                    ..text = saveDomain.keterangan ?? "",
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  enabled: isEnabled,
                                  style: TextStyle(fontSize: 15),
                                  validator: (value) {
                                    saveDomain.keterangan = value;
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Keterangan",
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
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black54),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Column(children: [
                                  Row(children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 10),
                                        child: Text("Foto Ke 1")),
                                    Expanded(child: Container()),
                                    IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.amber),
                                        onPressed: isEnabled == true ? () {
                                          pickerPhoto(ImageSource.camera, (path) {
                                            setState(() {
                                              saveDomain.photo_1_temp = path;
                                            });
                                          });
                                        } : null),
                                    IconButton(
                                        icon: const Icon(Icons.add_rounded,
                                            color: Colors.lightGreen),
                                        onPressed: () {})
                                  ]),
                                  _loadFileFoto(saveDomain.photo_1_temp)
                                ]),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 20, bottom: 20),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: isEnabled == true ? () {
                                      if (_formKey.currentState!.validate()) {
                                        BlocProvider.of<
                                                    RemoteSaveRekapIzinBloc>(
                                                context,
                                                listen: false)
                                            .add(SaveRekapIzin(saveDomain));
                                      }
                                    } : null,
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                isEnabled == true ? colorPrimaryDark : Colors.black12),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20)))),
                                    child: Text("S I M P A N",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800)),
                                  ),
                                )), //Button
                          ])));
            }));
  }

  _buildReasonType() {
    return Builder(builder: (context) =>
        BlocBuilder<LocalGetMasterTypeBloc, BaseBlocState>(
            builder: (_, state) {
              if (state is BaseResponseError) {
                WidgetsBinding.instance.addPostFrameCallback((_) =>
                    showSnackBarMessage(context, TypeMessage.ERROR,
                        state.error.message!, DurationMessage.LENGTH_SHORT));
              }
              if (state is GetMasterReasonTypeDone) {
                listTypeIzin.clear();
                state.model.forEach((element) {
                  listTypeIzin.add(element);
                });
              }

              return Container();
            }
        )
    );
  }
  _dialogTipeIzin(BuildContext context) {
    if (listTypeIzin.isEmpty) {
      return WidgetsBinding.instance.addPostFrameCallback((_) =>
          showSnackBarMessage(context, TypeMessage.ERROR,
              "Data tidak ditemukan", DurationMessage.LENGTH_SHORT));
    }

    return showModalBottomSheet(
        context: context,
        isDismissible: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => Container(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("Pilih Salah Satu Item",
                        style: TextStyle(
                            color: colorText,
                            fontWeight: FontWeight.w800,
                            fontSize: 16))),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TipeIzinTile(
                      position: index,
                      model: listTypeIzin[index],
                      onPressed: (position, model) {
                        setState(() {
                          saveDomain.reason_type = model.id.toString();
                          saveDomain.reason_type_name = model.name;
                          saveDomain.reason_id = null;
                          saveDomain.reason_name = null;

                          isKeterangan = false;
                          isJamKembali = false;
                          if(model.name?.toLowerCase() == "full day"){
                            isKeterangan = true;
                            saveDomain.start_time = null;
                            saveDomain.end_time = null;
                          }else{
                            isJamKembali = true;
                            saveDomain.keterangan = null;
                          }

                          Get.back();
                        });
                      },
                    );
                  },
                  itemCount: listTypeIzin.length,
                )
              ])))
            );
  }

  _buildReason() {
    return Builder(builder: (context) =>
        BlocBuilder<LocalGetMasterBloc, BaseBlocState>(
            builder: (_, state) {
              if (state is BaseResponseError) {
                WidgetsBinding.instance.addPostFrameCallback((_) =>
                    showSnackBarMessage(context, TypeMessage.ERROR,
                        state.error.message!, DurationMessage.LENGTH_SHORT));
              }
              if (state is GetMasterReasonDone) {
                listKategoriIzin.clear();
                state.model.forEach((element) {
                  listKategoriIzin.add(element);
                });
              }

              return Container();
            }
        )
    );
  }
  _dialogKategoriIzin(BuildContext context) {
    final tempList = listKategoriIzin.where(
            (element) => element.type == int.parse(saveDomain.reason_type!)).toList();
    if (tempList.isEmpty) {
      return WidgetsBinding.instance.addPostFrameCallback((_) =>
          showSnackBarMessage(context, TypeMessage.ERROR,
              "Data tidak ditemukan", DurationMessage.LENGTH_SHORT));
    }

    return showModalBottomSheet(
        context: context,
        isDismissible: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => Container(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("Pilih Salah Satu Item",
                        style: TextStyle(
                            color: colorText,
                            fontWeight: FontWeight.w800,
                            fontSize: 16))),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return KategoriIzinTile(
                      position: index,
                      model: tempList[index],
                      onPressed: (position, model) {
                        setState(() {
                          saveDomain.reason_id = model.id.toString();
                          saveDomain.reason_name = model.name;

                          Get.back();
                        });
                      },
                    );
                  },
                  itemCount: tempList.length,
                )
              ])
            )));
  }

  _dialogStartDate(BuildContext context) async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2025));

    if (_picked != null) {
      setState(() {
        saveDomain.start_date = _picked.toString().split(" ")[0];
        saveDomain.start_date_name = DateFormat("dd-MM-yyyy")
            .format(DateTime.parse(_picked.toString().split(" ")[0]));
      });
    }
  }

  _dialogEndDate(BuildContext context) async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2025));

    if (_picked != null) {
      setState(() {
        saveDomain.end_date =
            saveDomain.start_date = _picked.toString().split(" ")[0];
        saveDomain.end_date_name = DateFormat("dd-MM-yyyy")
            .format(DateTime.parse(_picked.toString().split(" ")[0]));
      });
    }
  }

  _dialogStartTime(BuildContext context) async {
    TimeOfDay? _picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      });

    if (_picked != null) {
      setState(() {
        saveDomain.start_time = _picked.format(context);
      });
    }
  }

  _dialogEndTime(BuildContext context) async {
    TimeOfDay? _picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });

    if (_picked != null) {
      setState(() {
        saveDomain.end_time = _picked.format(context);
      });
    }
  }

  _loadFileFoto(String? photoTemp) {
    if(!photoTemp.isNull) {
      if (photoTemp!.contains("https")){
        return CachedNetworkImage(
          imageUrl: photoTemp,
          imageBuilder: (context, imageProvider) => Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover)
            )
          )
        );
      }
      else{
        return Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                    image: FileImage(File(photoTemp)),
                    fit: BoxFit.cover
                )
            )
        );
      }
    }
    return Container(height: 150);
  }
}
