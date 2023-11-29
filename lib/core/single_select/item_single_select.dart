// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../resource/colors.dart';
import 'single_select_domain.dart';

class ItemSingleSelect extends StatelessWidget {
  final int? position;
  final SingleSelectDomain? model;
  final void Function(int idIndex, SingleSelectDomain model)? onPressed;

  const ItemSingleSelect({
    Key? key,
    this.position,
    this.model,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _onTap,
        child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    _onTap();
                  },
                  child: Text(model?.message ?? "",
                      style: TextStyle(color: colorText)),
                ))));
  }

  void _onTap() {
    var idIndex = position;
    onPressed!(idIndex!, model!);
  }
}
