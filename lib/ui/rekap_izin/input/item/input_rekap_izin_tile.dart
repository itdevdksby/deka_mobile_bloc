// ignore_for_file: prefer_const_constructors

import 'package:deka_mobile/models/entities/master_reason_type/master_reason_type.dart';
import 'package:flutter/material.dart';

import '../../../../models/entities/master_reason_hc/master_reason_hc.dart';
import '../../../../resource/colors.dart';

class TipeIzinTile extends StatelessWidget {
  final int ? position;
  final MasterReasonTypeEntity ? model;
  final void Function(int idIndex, MasterReasonTypeEntity model) ? onPressed;

  const TipeIzinTile({
    Key ? key,
    this.position,
    this.model,
    this.onPressed,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(padding: EdgeInsets.only(left: 20, right: 20),
          child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: (){
                  onPressed!(position!, model!);
                },
                child: Text(model!.name!, style: TextStyle(color: colorText)),
              )
          )
      )
    );
  }
}

class KategoriIzinTile extends StatelessWidget {
  final int ? position;
  final MasterReasonHcEntity ? model;
  final void Function(int idIndex, MasterReasonHcEntity model) ? onPressed;

  const KategoriIzinTile({
    Key ? key,
    this.position,
    this.model,
    this.onPressed,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(padding: EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: (){
                    onPressed!(position!, model!);
                  },
                  child: Text(model!.name!, style: TextStyle(color: colorText)),
                )
            )
        )
    );
  }
}