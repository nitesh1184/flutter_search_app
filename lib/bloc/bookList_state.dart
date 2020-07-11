import 'package:book_app/data/model/api_result_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BookListState extends Equatable {
  BookListState ([List props = const []]) : super(props);
}

class InitialState extends BookListState  {
  @override
  String toString() => 'InitialState';
}

class BooksLoading extends BookListState  {}

class BooksLoadedState extends BookListState  {
  final List<Books> books;
  BooksLoadedState({@required this.books});
}

class BookErrorState extends BookListState {
  String message;
  BookErrorState({@required this.message});
}

