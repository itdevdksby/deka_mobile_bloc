// ignore_for_file: prefer_const_constructors, invalid_use_of_protected_member

import 'dart:io';
import '../../../core/data/bloc_state.dart';
import '../../../extensions/constants.dart';
import '../../../ui/dashboard/bloc/local/local_profile_bloc.dart';
import '../../../ui/rekap_izin/input/bloc/remote/remote_save_rekap_izin_bloc.dart';
import '../../../ui/rekap_izin/input/item/input_rekap_izin_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../di/di.dart';
import '../../../models/domain/save_rekap_izin_domain.dart';
import '../../../resource/colors.dart';
import '../../../resource/showSnackbarMessage.dart';

class InputRekapIzin extends StatefulWidget {
  static const nameRoute = 'InputRekapIzin';
  const InputRekapIzin({super.key});

  @override
  State<InputRekapIzin> createState() => _InputRekapIzinState();
}

class _InputRekapIzinState extends State<InputRekapIzin> {
  final saveDomain = SaveRekapIzinDomain();
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LocalProfileBloc>(
          create: (context) => get()..add(GetProfile())),
      BlocProvider<RemoteSaveRekapIzinBloc>(
          create: (context) => get()..onEvent(SaveRekapIzin(saveDomain))),
    ], child: Scaffold(appBar: _buildAppBar(), body: _buildBody()));
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
                    .addPostFrameCallback((_) => Navigator.of(context).pop());
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
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                child: TextFormField(
                                  controller: TextEditingController()
                                    ..text = saveDomain.keterangan ?? "",
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
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
                                )),
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
                                        onPressed: () {
                                          _dialogPhoto();
                                        }),
                                    IconButton(
                                        icon: const Icon(Icons.add_rounded,
                                            color: Colors.lightGreen),
                                        onPressed: () {})
                                  ]),
                                  Container(
                                      width: double.infinity,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        image: DecorationImage(
                                            image: FileImage(
                                                selectedImage ?? File("")),
                                            fit: BoxFit.cover),
                                      ))
                                ]),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 20, bottom: 20),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        BlocProvider.of<
                                                    RemoteSaveRekapIzinBloc>(
                                                context,
                                                listen: false)
                                            .add(SaveRekapIzin(saveDomain));
                                      }
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                colorPrimaryDark),
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

  _dialogTipeIzin(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isDismissible: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => Container(
            height: double.infinity,
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
                    model: listTipeIzin[index],
                    onPressed: (position, model) {
                      setState(() {
                        saveDomain.reason_type = (position + 1).toString();
                        saveDomain.reason_type_name = model;
                        saveDomain.reason_id = null;
                        saveDomain.reason_name = null;

                        Navigator.pop(context);
                      });
                    },
                  );
                },
                itemCount: listTipeIzin.length,
              )
            ])));
  }

  _dialogKategoriIzin(BuildContext context) {
    var list = listKategoriIzin1;
    if (saveDomain.reason_type == "2") {
      list = listKategoriIzin2;
    }
    return showModalBottomSheet(
        context: context,
        isDismissible: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => Container(
            height: double.infinity,
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
                    model: list[index],
                    onPressed: (position, model) {
                      setState(() {
                        saveDomain.reason_id = position.toString();
                        saveDomain.reason_name = model;

                        Navigator.pop(context);
                      });
                    },
                  );
                },
                itemCount: list.length,
              )
            ])));
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

  Future<void> _dialogPhoto() async {
    final picked = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 70);
    if (picked == null) return;

    setState(() {
      saveDomain.photo_1_temp = picked.path;
      selectedImage = File(picked.path);
    });
  }
}
