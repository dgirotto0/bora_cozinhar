import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showErrorMessage(String errorMessage) {
  Fluttertoast.showToast(
    msg: errorMessage,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.yellow[700],
    textColor: Colors.white,
    fontSize: 16.0,
  );
}