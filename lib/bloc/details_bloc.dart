import 'package:bloc/bloc.dart';
import 'package:book_app/bloc/details_event.dart';
import 'package:book_app/bloc/details_state.dart';
import 'package:book_app/data/repository/AoiRepo.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailState> {

  APIRepository repository;


  DetailsBloc({this.repository});

  @override
  DetailState get initialState => InitialState();

  @override
  Stream<DetailState> mapEventToState(
      DetailState currentState, DetailsEvent event) async* {
    if (event is FetchDetailsEvent) {
      yield* _mapSearchBookState(event);
    }
  }

  Stream<DetailState> _mapSearchBookState(FetchDetailsEvent event) async* {
    try {
      yield DetailsLoading();
      var result = await repository.getBookDetails(event.id);
      yield DetailsLoadedState(details: result);
    } catch (e) {
      yield BookErrorState();
    }
  }

}