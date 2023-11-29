// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../core/data/bloc_state.dart';
import '../../di/di.dart';
import '../../extensions/constants.dart';
import '../../models/response/view_cuti_model.dart';
import '../../resource/colors.dart';
import '../../resource/showSnackbarMessage.dart';
import '../../ui/dashboard/bloc/local/local_profile_bloc.dart';
import '../../ui/dashboard/bloc/remote/remote_sync_data_master_bloc.dart';
import '../../ui/dashboard/bloc/remote/remote_view_cuti_bloc.dart';
import '../../ui/rekap_izin/rekap_izin.dart';

class Dashboard extends StatefulWidget {
  static const nameRoute = 'Dashboard';

  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var data = ViewCutiModel();
  var isShowData = true;
  var messageError = "Error Unknown";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<RemoteSyncDataMasterBloc>(
              create: (context) => get()..add(SyncDataMaster())),
          BlocProvider<LocalProfileBloc>(
              create: (context) => get()..add(GetProfile())),
          BlocProvider<RemoteViewCutiBloc>(
              create: (context) => get()..add(GetViewCuti())),
        ],
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSyncDataMaster(),
                _buildGreeting(),
                _buildBody()
              ],
            ),
          ),
        ));
  }

  _buildSyncDataMaster() {
    return BlocBuilder<RemoteSyncDataMasterBloc, BaseBlocState>(
        builder: (_, state) {
      if (state is BaseResponseError) {
        messageError = state.error.message!;

        WidgetsBinding.instance.addPostFrameCallback((_) => showSnackBarMessage(
            context,
            TypeMessage.ERROR,
            messageError,
            DurationMessage.LENGTH_SHORT));
      }
      if (state is SyncDataMasterResponseDone) {
        print(state.model.hcAddress);
      }

      return Container();
    });
  }

  _buildGreeting() {
    return BlocBuilder<LocalProfileBloc, BaseBlocState>(builder: (_, state) {
      String? photo;
      if (state is BaseResponseError) {
        messageError = state.error.message!;

        WidgetsBinding.instance.addPostFrameCallback((_) => showSnackBarMessage(
            context,
            TypeMessage.ERROR,
            messageError,
            DurationMessage.LENGTH_SHORT));
      }
      if (state is ProfileResponseDone) {
        photo = state.model.photo;
      }

      final hour = int.tryParse(DateFormat('HH').format(DateTime.now()));
      var textGreeting = "Selamat Malam";
      if (hour! >= 4 && hour <= 10) textGreeting = "Selamat Pagi";
      if (hour >= 11 && hour <= 14) textGreeting = "Selamat Siang";
      if (hour >= 15 && hour <= 17) textGreeting = "Selamat Sore";
      return Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: colorPrimary,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          image: DecorationImage(
            image: AssetImage("assets/images/img_background_factory.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                colorPrimary.withOpacity(0.6), BlendMode.multiply),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10, top: 35, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 10),
                      child: CachedNetworkImage(
                        imageUrl: photo ??
                            "https://webfuzo.duakelinci.id:9393/img/duakelinci-transparant.png",
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error_rounded),
                        imageBuilder: (context, imageProvider) => Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                        ),
                      )),
                  Expanded(child: Container()),
                  Container(
                    padding: EdgeInsets.zero,
                    child: IconButton(
                        icon:
                            const Icon(Icons.menu_rounded, color: Colors.amber),
                        onPressed: () {}),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 10, top: 20),
                child: Text(textGreeting,
                    style: TextStyle(
                        color: colorOnPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 20)),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(varGreeting,
                    style: TextStyle(
                        color: colorOnPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 14)),
              ),
            ],
          ),
        ),
      );
    });
  }

  _buildBody() {
    return BlocBuilder<RemoteViewCutiBloc, BaseBlocState>(builder: (_, state) {
      if (state is BaseResponseError) {
        isShowData = true;
        messageError = state.error.message!;

        WidgetsBinding.instance.addPostFrameCallback((_) => showSnackBarMessage(
            context,
            TypeMessage.ERROR,
            messageError,
            DurationMessage.LENGTH_SHORT));
      }
      if (state is ViewCutiResponseDone) {
        isShowData = true;
        data = state.model;
      }

      return Column(
        children: [
          _buildErrorData(),
          _buildCountIzin(),
          _buildRekapIzin(),
        ],
      );
    });
  }

  _buildErrorData() {
    return Visibility(
        visible: !isShowData,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                height: 200,
                fit: BoxFit.cover,
                image: AssetImage("assets/images/gif_no_data.gif")),
            TextButton(
                child: Text(
                  messageError,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black87),
                ),
                onPressed: () {
                  setState(() {
                    BlocProvider.of<RemoteViewCutiBloc>(context, listen: false)
                        .add(GetViewCuti());
                  });
                })
          ],
        )));
  }

  _buildCountIzin() {
    return Visibility(
        visible: isShowData,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 10),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: colorRed100,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text(data.jumlahAlpha ?? "-",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20)),
                            Text(varTotalAlpha,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12)),
                          ],
                        ),
                      )),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: colorGreen100,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text(
                                "${data.jumlahSisaCuti ?? "-"} / ${data.jumlahCuti ?? "-"}",
                                style: TextStyle(
                                    color: colorText,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20)),
                            Text(varSisaCuti,
                                style:
                                    TextStyle(color: colorText, fontSize: 12)),
                          ],
                        ),
                      )),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: colorBlue100,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text(data.totalIzin ?? "-",
                                style: TextStyle(
                                    color: colorText,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20)),
                            Text(varTotalIzin,
                                style:
                                    TextStyle(color: colorText, fontSize: 12)),
                          ],
                        ),
                      )),
                ))
          ],
        ));
  }

  _buildRekapIzin() {
    return Visibility(
        visible: isShowData,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 2,
              color: colorOnPrimary,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(varRekapIzin,
                                    style: TextStyle(
                                        color: colorPrimary,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16))),
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 25,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(RekapIzin.nameRoute);
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
                                    child: Text("Detail",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                        )),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Padding(
                              padding:
                                  EdgeInsets.only(left: 15, top: 15, right: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(varIzinBelumDisetujui,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: colorOnPrimary,
                                              fontSize: 15))),
                                  Expanded(
                                      flex: 1,
                                      child: Text(data.totalWaiting ?? "-",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: colorOnPrimary,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(varIzinDisetujui,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: colorOnPrimary,
                                              fontSize: 15))),
                                  Expanded(
                                      flex: 1,
                                      child: Text(data.totalApproved ?? "-",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: colorOnPrimary,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(varIzinDitolak,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: colorOnPrimary,
                                              fontSize: 15))),
                                  Expanded(
                                      flex: 1,
                                      child: Text(data.totalReject ?? "-",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: colorOnPrimary,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15))),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ]),
            )));
  }
}
