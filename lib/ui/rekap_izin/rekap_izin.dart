// ignore_for_file: prefer_const_constructors';, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/data/bloc_state.dart';
import '../../di/di.dart';
import '../../extensions/constants.dart';
import '../../resource/colors.dart';
import 'bloc/remote/remote_rekap_izin_bloc.dart';
import 'input/input_rekap_izin.dart';
import 'item/rekap_izin_tile.dart';

class RekapIzin extends StatefulWidget {
  static const nameRoute = 'RekapIzin';
  const RekapIzin({super.key});

  @override
  State<RekapIzin> createState() => _RekapIzinState();
}

class _RekapIzinState extends State<RekapIzin> {
  final _scrollController = ScrollController();
  var _isShowAdd = true;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isShowAdd) {
          setState(() {
            _isShowAdd = false;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isShowAdd) {
          setState(() {
            _isShowAdd = true;
          });
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteRekapIzinBloc>(
        create: (context) => get()..add(GetRekapIzin()),
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
          floatingActionButton: Visibility(
              visible: _isShowAdd,
              child: Builder(
                  builder: (context) => FloatingActionButton(
                      backgroundColor: colorPrimary,
                      onPressed: () async {
                        await Navigator.of(context)
                            .pushNamed(InputRekapIzin.nameRoute);
                        BlocProvider.of<RemoteRekapIzinBloc>(context)
                            .add(GetRekapIzin());
                      },
                      child: Icon(Icons.add)))),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ));
  }

  _buildAppBar() {
    return AppBar(title: Text(varRekapIzin));
  }

  _buildBody() {
    return Builder(
        builder: (context) => BlocBuilder<RemoteRekapIzinBloc, BaseBlocState>(
              builder: (_, state) {
                if (state is BaseResponseLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                if (state is BaseResponseError) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          height: 200,
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/gif_no_data.gif")),
                      TextButton(
                          child: Text(
                            state.error.message ?? "Tidak Ada Data",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black87),
                          ),
                          onPressed: () {
                            setState(() {
                              BlocProvider.of<RemoteRekapIzinBloc>(context,
                                      listen: false)
                                  .add(GetRekapIzin());
                            });
                          })
                    ],
                  ));
                }
                if (state is RekapIzinDone) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return RekapIzinTile(
                        rekapIzin: state.model[index],
                      );
                    },
                    itemCount: state.model.length,
                  );
                }
                return Container();
              },
            ));
  }
}
