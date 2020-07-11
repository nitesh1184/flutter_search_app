import 'package:book_app/data/model/api_result_model.dart';
import 'package:book_app/data/model/detailsModel.dart';
import 'package:book_app/data/repository/APIService.dart';

class APIRepository{
  final githubService = APIService();

  Future<List<Books>> searchBook(String searchKey) async{
    return githubService.searchBook(searchKey);
  }
  Future<DetailsModel> getBookDetails(String searchKey) async{
    return githubService.getBookDetails(searchKey);
  }
}