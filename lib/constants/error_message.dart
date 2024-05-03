import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../assets/colors/colors.dart';

void showErrorMessage(String errorMessage) {
  Fluttertoast.showToast(
    msg: errorMessage,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: Paleta.vermelhoVibrante,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}