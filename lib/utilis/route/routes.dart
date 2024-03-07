import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utilis/route/route_name.dart';
import 'package:news_app/view/category_screen.dart';
import 'package:news_app/view/home_screen.dart';
import 'package:news_app/view/splash_screen.dart';
class Routes{

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashScreen());
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());
      case RoutesName.category:
        return MaterialPageRoute(builder: (BuildContext context) => const CategoryScreen());
      default:
        return MaterialPageRoute(builder: (_){
          return const  Scaffold(
            body: Center(
              child: Text(
                "No route found",
              ),
            ),
          );
        });
    }
  }

}