import 'package:book_app/bloc/details_bloc.dart';
import 'package:book_app/bloc/details_event.dart';
import 'package:book_app/bloc/details_state.dart';
import 'package:book_app/data/model/api_result_model.dart';
import 'package:book_app/data/model/detailsModel.dart';
import 'package:book_app/data/repository/AoiRepo.dart';
import 'package:book_app/utils/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailPage extends StatefulWidget {
  Books books;

  BookDetailPage({this.books});
  @override
  _BookDetailPage createState() => _BookDetailPage(books);
}

class _BookDetailPage extends State<BookDetailPage> {
  Books books;
  DetailsBloc _detailBloc;

  _BookDetailPage(this.books);

  @override
  void initState() {

    _detailBloc = DetailsBloc(repository: APIRepository());
    _detailBloc.dispatch(
        FetchDetailsEvent(id: books.isbn13));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocProvider<DetailsBloc>(
      bloc: _detailBloc,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              child: BlocBuilder<DetailsEvent, DetailState>(
                  bloc: _detailBloc,
                  builder: (BuildContext context, DetailState state) {
                    if (state is DetailsLoading) {
                      return buildLoading();
                    }
                    else if (state is DetailsLoadedState) {
                      print('Response ${state.details.title}');
                      return detailsLoadedWidget(state.details,context);
                    }

                    return buildLoading();
//                       Center(
//                         child: Text('Start Searching for a Job\nRight now!',
//                           textAlign: TextAlign.center, style: TextStyle(
//                               fontSize: 24,
//                               color: Colors.blueGrey
//                           ),)
//                         ,);


                  }),
            ),
          ],
        ),
      ),
    ));

  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget detailsLoadedWidget(DetailsModel model,BuildContext context){
    final appBar = AppBar(
      elevation: .5,
      title: Text('Book Details'),
    );

    ///detail of book image and it's pages
    final topLeft = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Hero(
            tag: books.title,
            child: Material(
              elevation: 15.0,
              shadowColor: Colors.yellow.shade900,
              child: Image.network(
                model.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        text('${model.pages} pages', color: Colors.black, size: 12)
      ],
    );

    ///detail top right
    final topRight = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text(model.title,
            size: 16, isBold: true, padding: EdgeInsets.only(top: 16.0)),
        text(
          'by ${model.authors}',
          color: Colors.black,
          size: 14,
          padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
        ),
        Row(
          children: <Widget>[
            text(
              model.price,
              size: 14,
              isBold: true,
              padding: EdgeInsets.only(right: 8.0),
            ),
            RatingBar(rating: double.parse(model.rating))
          ],
        ),
        SizedBox(height: 32.0),
      ],
    );

    final topContent = Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 2, child: topLeft),
          Flexible(flex: 3, child: topRight),
        ],
      ),
    );

    ///scrolling text description
    final bottomContent = Container(
      height: 220.0,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          model.desc,
          style: TextStyle(fontSize: 15.0, height: 1.5),
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }

  ///create text widget
  text(String data,
      {Color color = Colors.black87,
        num size = 14,
        EdgeInsetsGeometry padding = EdgeInsets.zero,
        bool isBold = false}) =>
      Padding(
        padding: padding,
        child: Text(
          data,
          style: TextStyle(
              color: color,
              fontSize: size.toDouble(),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      );
  }

