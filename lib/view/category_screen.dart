import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/view/category_news_detail.dart';
import 'package:news_app/view_model/news_view_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  NewsViewModel newsViewModel = NewsViewModel();

  String categoryName = 'General';

  final List<String> categoryList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];

  @override
  Widget build(BuildContext context) {

    final format = DateFormat('MMMM dd, yyyy');
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    categoryName = categoryList[index];
                    setState(() {

                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: categoryName == categoryList[index] ?Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(child: Text(categoryList[index].toString(),style: GoogleFonts.poppins(fontSize: 13,color: Colors.white,fontWeight: FontWeight.w500),)),
                    ),
                  ),
                );
              },),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi(categoryName),
                builder: (BuildContext context,  snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: SpinKitCircle(color: Colors.blue,size: 40,),);
                  }else{
                    return ListView.builder(
                      itemCount:  snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryNewsDetailScreen(
                                      image: snapshot.data!.articles![index].urlToImage.toString(),
                                     title: snapshot.data!.articles![index].title.toString(),
                                      source: snapshot.data!.articles![index].source!.name.toString(),
                                     dateFormat: dateTime,
                                     description: snapshot.data!.articles![index].description.toString(),
                                    ),));
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    height: height * .18,
                                    width: width * .3,
                                    placeholder: (context, url) => const Center(child: SpinKitCircle(color: Colors.blue,size: 40,),),
                                    errorWidget: (context, url, error) => const Icon(Icons.error,color: Colors.red,),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                   height: height * .18,
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      Text(snapshot.data!.articles![index].title.toString(),
                                      maxLines: 3,
                                      style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700),
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(snapshot.data!.articles![index].source!.name.toString(),style: GoogleFonts.poppins(fontSize: 10 ,fontWeight: FontWeight.w500)),
                                          Text(format.format(dateTime),style: GoogleFonts.poppins(fontSize: 10,fontWeight: FontWeight.w400))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
