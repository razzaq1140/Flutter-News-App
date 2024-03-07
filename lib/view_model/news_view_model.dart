import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_channel_headlines_models.dart';
import 'package:news_app/repository/news_repository.dart';
import 'package:news_app/utilis/utils.dart';

class NewsViewModel{

  final _api = NewsRepository();

  Future<NewsChannelHeadlinesModels> fetchNewChannelHead(String channelName) async{

   final response =  _api.fetchNewChannelHead(channelName);
   return response;
  }


  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async{

    final response =  _api.fetchCategoriesNewsApi(category);
    return response;
  }
}