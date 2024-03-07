import 'package:news_app/network/baseapiservice.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/utilis/utils.dart';

class NetworkApiService extends BaseApiService{
  @override
  Future getGetApiResponse(String url) async{

   try{

     final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 40));
     print(response.body.toString());
     return response;

   }catch(e){
     Utils.toastErrorMessage(e.toString());
   }
  }
}

// dynamic returnResponse(http.Response response){
//   switch(response){
//     case 200:
//       dynamic jsonResponse = jsonDecode(response.body);
//       return jsonResponse;
//   }
// }