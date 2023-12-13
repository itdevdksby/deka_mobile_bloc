// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resource/colors.dart';
import 'item_single_select.dart';
import 'single_select_domain.dart';

dialogSingleSelect(BuildContext context, List<SingleSelectDomain> listItem,
    final void Function(int idIndex, SingleSelectDomain model) onPressed) {
  return showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SizedBox(
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
                return ItemSingleSelect(
                  position: index,
                  model: listItem[index],
                  onPressed: (position, model) {
                    onPressed(position, model);
                    Get.back();
                  },
                );
              },
              itemCount: listItem.length,
            )
          ])));
}
