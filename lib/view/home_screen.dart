import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_channel_headlines_models.dart';
import 'package:news_app/utilis/route/route_name.dart';
import 'package:news_app/view/news_detail_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList {breitbart, bbcNews, aryNews, independent, reuters, cnn, alJazeera}

class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectMenu;
  String name = 'breitbart-news';

  @override
  Widget build(BuildContext context) {

    final format = DateFormat('MMMM dd, yyyy');
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: InkWell(
            onTap: (){
              Navigator.pushNamed(context, RoutesName.category);
            },
            child: Image.asset('images/category_icon.png',height: 30,width: 30,))),
        title: Text("News",style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            initialValue: selectMenu,
            onSelected: (FilterList item){
              if(FilterList.breitbart.name == item.name){
                name = 'breitbart-news';
              }
               if(FilterList.bbcNews.name == item.name){
                name = 'bbc-news';
              }
              if(FilterList.alJazeera.name == item.name){
                name = 'al-jazeera-english';
              }
              if(FilterList.aryNews.name == item.name){
                name = 'ary-news';
              }
              if(FilterList.independent.name == item.name){
                name = 'business-insider';
              }
              setState(() {
                selectMenu = item;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>> [
              const PopupMenuItem<FilterList>(
                value: FilterList.breitbart,
                  child: Text("Breitbart News")),
              const PopupMenuItem<FilterList>(
                value: FilterList.bbcNews,
                  child: Text("BBC News")),
              const PopupMenuItem<FilterList>(
                  value: FilterList.alJazeera,
                  child: Text("Al-Jazeera")),
              const PopupMenuItem<FilterList>(
                  value: FilterList.aryNews,
                  child: Text("ARY News")),
              const PopupMenuItem<FilterList>(
                  value: FilterList.independent,
                  child: Text("Business News")),
            ],)
        ],
      ),
      body: ListView(

        children: [
          SizedBox(
            height: height * 0.55,
            width: width * .9,
            child: FutureBuilder<NewsChannelHeadlinesModels>(
              future: newsViewModel.fetchNewChannelHead(name),
              builder: (BuildContext context,  snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: SpinKitCircle(color: Colors.blue,size: 40,),);
                }else{
                  return ListView.builder(
                    itemCount:  snapshot.data!.articles!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailScree(
                          image: snapshot.data!.articles![index].urlToImage.toString(),
                          title: snapshot.data!.articles![index].title.toString(),
                          source: snapshot.data!.articles![index].source!.name.toString(),
                          dateFormat: dateTime,
                          description: snapshot.data!.articles![index].description.toString(),),
                        ));
                      },
                      child: SizedBox(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: height * 0.6,
                              width: width * 0.9,
                              padding: EdgeInsets.symmetric(horizontal: height * 0.02),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(child: spinKit2,),
                                  errorWidget: (context, url, error) => const Icon(Icons.error,color: Colors.red,),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              child: Card(
                                elevation: 5,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: const EdgeInsets.all(15),
                                  height: height * .22,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.7,
                                        child: Text(snapshot.data!.articles![index].title.toString(),
                                        maxLines: 3, overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: width * 0.7,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                        Text(snapshot.data!.articles![index].source!.name.toString(),style: GoogleFonts.poppins(fontSize: 12 ,fontWeight: FontWeight.w600)),
                                          Text(format.format(dateTime),style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w500))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fetchCategoriesNewsApi("General"),
              builder: (BuildContext context,  snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: SpinKitCircle(color: Colors.blue,size: 40,),);
                }else{
                  return ListView.builder(
                    itemCount:  snapshot.data!.articles!.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                fit: BoxFit.cover,
                                height: height * .18,
                                width: width * .3,
                                placeholder: (context, url) => const Center(child: SpinKitCircle(color: Colors.blue,size: 40,),),
                                errorWidget: (context, url, error) => const Icon(Icons.error,color: Colors.red,),
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
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.blue,
  size: 40,
);

