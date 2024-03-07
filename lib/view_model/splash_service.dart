import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utilis/route/route_name.dart';

class SplashService{

  void loading(BuildContext context){
    Timer(const Duration(seconds: 5),() => Navigator.pushNamed(context, RoutesName.home));
  }
}