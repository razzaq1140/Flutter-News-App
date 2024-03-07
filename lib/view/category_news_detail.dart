import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/view_model/news_view_model.dart';

class CategoryNewsDetailScreen extends StatefulWidget {
  final String image,title, source,description;
  final DateTime dateFormat;
  const CategoryNewsDetailScreen({super.key,
    required this.image,
    required this.title,
    required this.source,
    required this.description,
    required this.dateFormat

  });

  @override
  State<CategoryNewsDetailScreen> createState() => _CategoryNewsDetailScreenState();
}

class _CategoryNewsDetailScreenState extends State<CategoryNewsDetailScreen> {

  NewsViewModel newsViewModel = NewsViewModel();

  String name = 'general';

  @override
  Widget build(BuildContext context) {

    final format = DateFormat('MMMM dd, yyyy');
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      appBar: AppBar(
        title: Text("News Detail",style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: height * .45,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
              child: CachedNetworkImage(
                imageUrl: widget.image,
                fit: BoxFit.cover,
                placeholder: (context, ulr) => Center(child: SpinKitCircle(color: Colors.blue,),),
              ),
            ),
          ),
          Container(
            height: height * .6,
            padding: EdgeInsets.only(top: 20,right: 20,left: 20),
            margin: EdgeInsets.only(top: height * .4),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
            ),
            child: ListView(
              children: [
                SizedBox(height:  height * .02,),
                Text(widget.title,textAlign: TextAlign.center,style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.w700)),
                SizedBox(height:  height * 0.04,),
                Text(widget.description,textAlign: TextAlign.center,style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w700)),
                SizedBox(height:  height * 0.1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.source,style: GoogleFonts.poppins(fontSize: 12 ,fontWeight: FontWeight.w600)),
                    Text(format.format(widget.dateFormat),style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w500))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

