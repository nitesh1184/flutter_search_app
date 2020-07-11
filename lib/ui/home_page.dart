import 'package:book_app/bloc/article_bloc.dart';
import 'package:book_app/bloc/bookList_event.dart';
import 'package:book_app/bloc/bookList_state.dart';
import 'package:book_app/data/model/api_result_model.dart';
import 'package:book_app/data/repository/AoiRepo.dart';
import 'package:book_app/ui/about_page.dart';
import 'package:book_app/ui/book_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BookBloc _bookBloc;
  final TextEditingController _searchQuery = TextEditingController();

  @override
  void initState() {

    _bookBloc = BookBloc(
        repository: APIRepository()
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

      return BlocProvider<BookBloc>(
        bloc: _bookBloc,
        child: Scaffold(
          body: Stack(
            children: [
          Container(
          margin: EdgeInsets.only(top: 50),
          child:widgetSearch()
          ),
              Container(
                margin: EdgeInsets.only(top: 90),
                child: BlocBuilder<BookEvent, BookListState>(
                    bloc: _bookBloc,
                    builder: (BuildContext context, BookListState state) {
                       if (state is BooksLoading) {
                        return buildLoading();
                      }
                      else if (state is BooksLoadedState) {
                        return buildArticleList(state.books);
                      }
                       return Container();
                    }),
              ),
            ],
          ),
        ),
      );
  }

  widgetSearch(){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {

              },
              controller: _searchQuery,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: InkWell(
                      onTap: () {
                        _bookBloc.dispatch(FetchBookListEvent(searchKey: _searchQuery.text));
                      },
                      child: Container(
                        child:Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      )),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ));

  }

  Widget searchWidget() {
    return  TextField(
      autofocus: true,
      controller: _searchQuery,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Padding(
              padding: EdgeInsetsDirectional.only(end: 16.0),
            child:InkWell(
                onTap: () {
                  _bookBloc.dispatch(FetchBookListEvent(searchKey: _searchQuery.text));
                },
              child: Container(
                child:Icon(
                Icons.search,
                color: Colors.white,
              ),
              ))),
          hintText: "Search repositories...",
          hintStyle: TextStyle(color: Colors.white)),
    );

  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(List<Books> books) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              leading: ClipOval(
                child: Hero(
                  tag: books[pos].image,
                  child: Image.network(
                    books[pos].image,
                    fit: BoxFit.cover,
                    height: 70.0,
                    width: 70.0,
                  ),
                ),
              ),
              title: Text(books[pos].title),
              subtitle: Column(
              children: [
                  Text(books[pos].subtitle),
                Text(books[pos].price),

              ],
            ),
            ),
            onTap: () {
              navigateToArticleDetailPage(context, books[pos]);
            },
          ),
        );
      },
    );
  }

  void navigateToArticleDetailPage(BuildContext context, Books books) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BookDetailPage(
        books: books,
      );
    }));
  }

  void navigateToAoutPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AboutPage();
    }));
  }
}
