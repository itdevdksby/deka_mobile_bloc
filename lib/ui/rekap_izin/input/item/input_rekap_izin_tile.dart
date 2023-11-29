// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../../resource/colors.dart';

class TipeIzinTile extends StatelessWidget {
  final int ? position;
  final String ? model;
  final void Function(int idIndex, String model) ? onPressed;

  const TipeIzinTile({
    Key ? key,
    this.position,
    this.model,
    this.onPressed,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Padding(padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
              width: double.infinity,
              child: TextButton(
                onPressed: (){
                  _onTap();
                },
                child: Text(model!, style: TextStyle(color: colorText)),
              )
          )
      )
    );
  }

  void _onTap() {
    var idIndex = position;
    switch(model) {
      case "Cuti":
        idIndex = 4;
        break;
      case "Sakit":
        idIndex = 5;
        break;
      case "Menikah":
        idIndex = 6;
        break;
      case "Izin Keluar":
        idIndex = 3;
        break;
      case "Izin Pulang Cepat":
        idIndex = 2;
        break;
      case "Izin Datang Terlambat":
        idIndex = 1;
        break;
      case "Izin Keperluan Mendadak":
        idIndex = 10;
        break;
    }
    onPressed!(idIndex!, model!);
  }
}