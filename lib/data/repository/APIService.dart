import 'dart:convert';

import 'package:book_app/data/model/api_result_model.dart';
import 'package:book_app/data/model/detailsModel.dart';
import 'package:http/http.dart' as http;

class APIService{


  Future<List<Books>> searchBook(String searchKey) async{

    final String url = 'https://api.itbook.store/1.0/search/$searchKey';
    var r = await http.get(url);

    if (r.statusCode == 200) {
      var data = json.decode(r.body);
      List<Books> articles = ApiResultModel.fromJson(data).books;
      return articles;
    }else{
      return throw Exception('Unable to connect with server');
    }
  }

  Future<DetailsModel> getBookDetails(String searchKey) async{

    final String url = 'https://api.itbook.store/1.0/books/$searchKey';
    var r = await http.get(url);

    if (r.statusCode == 200) {
      var data = json.decode(r.body);
      DetailsModel articles = DetailsModel.fromJson(data);
      return articles;
    }else{
      return throw Exception('Unable to connect with server');
    }
  }
}