import 'package:book_app/data/model/detailsModel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class DetailState extends Equatable {
  DetailState ([List props = const []]) : super(props);
}

class InitialState extends DetailState  {
  @override
  String toString() => 'InitialState';
}

class DetailsLoading extends DetailState  {}

class DetailsLoadedState extends DetailState  {
  final DetailsModel details;
  DetailsLoadedState({@required this.details});
}

class BookErrorState extends DetailState {
  String message;
  BookErrorState({@required this.message});
}