import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/view_model/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashService service = SplashService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service.loading(context);
  }
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      body: Container(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
                image: const AssetImage('images/splash_pic.jpg'),
              fit: BoxFit.cover,
              height: height * .5,
            ),
            SizedBox(height: height * 0.04,),
            Text("TOP HEADLINES",style: GoogleFonts.anton(letterSpacing: 0.6, color: Colors.grey.shade700),),
            SizedBox(height: height * 0.04,),
            const SpinKitChasingDots(
              color: Colors.blue,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
