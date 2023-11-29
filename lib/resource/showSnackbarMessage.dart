import 'package:flutter/material.dart';

showSnackBarMessage(BuildContext context, TypeMessage typeMessage, String message, DurationMessage duration) {
  var colorTypeMessage = Colors.lightGreen;
  if(typeMessage == TypeMessage.ERROR) {
    colorTypeMessage = Colors.red;
  }else if(typeMessage == TypeMessage.WARNING) {
    colorTypeMessage = Colors.amber;
  }else if(typeMessage == TypeMessage.INFO) {
    colorTypeMessage = Colors.lightBlue;
  }

  var durationMessage = 5;
  if(duration == DurationMessage.LENGTH_LONG){
    durationMessage = 8;
  }else if(duration == DurationMessage.LENGTH_INFINITE){
    durationMessage = 3600;
  }

  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: colorTypeMessage,
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: durationMessage),
    shape:  RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

enum TypeMessage {
  SUCCESS, ERROR, WARNING, INFO
}

enum DurationMessage {
  LENGTH_SHORT, LENGTH_LONG, LENGTH_INFINITE
}