import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {

  static void toastErrorMessage(String message) {
    Fluttertoast.showToast(
        backgroundColor: Colors.black,
        textColor: Colors.white,
        msg: message
    );
  }
}