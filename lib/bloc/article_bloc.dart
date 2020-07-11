import 'package:bloc/bloc.dart';
import 'package:book_app/bloc/bookList_event.dart';
import 'package:book_app/bloc/bookList_state.dart';
import 'package:book_app/data/repository/AoiRepo.dart';

class BookBloc extends Bloc<BookEvent, BookListState> {

  APIRepository repository;


  BookBloc({this.repository});

  @override
  BookListState get initialState => InitialState();

  @override
  Stream<BookListState> mapEventToState(
      BookListState currentState, BookEvent event) async* {
    if (event is FetchBookListEvent) {
      yield* _mapSearchBookState(event);
    }
  }

  Stream<BookListState> _mapSearchBookState(FetchBookListEvent event) async* {
    try {
      yield BooksLoading();
      var result = await repository.searchBook(event.searchKey);
      yield BooksLoadedState(books: result);
    } catch (e) {
      yield BookErrorState();
    }
  }

}