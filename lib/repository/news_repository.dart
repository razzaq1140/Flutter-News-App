import 'dart:convert';
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_channel_headlines_models.dart';
import 'package:news_app/network/baseapiservice.dart';
import 'package:news_app/network/networkapiservice.dart';
import 'package:news_app/res/component/app_url.dart';

class NewsRepository{

  BaseApiService _api = NetworkApiService();

  Future<NewsChannelHeadlinesModels> fetchNewChannelHead(String channelName) async{
    try{
      dynamic response = await _api.getGetApiResponse("https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=18547e8445894bd6b8f2ef8eb8e2d152");
      final body = jsonDecode(response.body);
      return response = NewsChannelHeadlinesModels.fromJson(body);
    }catch(e){
      throw e;
    }
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async{
    try{
      dynamic response = await _api.getGetApiResponse("https://newsapi.org/v2/everything?q=${category}&apiKey=18547e8445894bd6b8f2ef8eb8e2d152");
      final body = jsonDecode(response.body);
      return response = CategoriesNewsModel.fromJson(body);
    }catch(e){
      throw e;
    }
  }
}