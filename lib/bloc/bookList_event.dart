import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BookEvent extends Equatable {
  BookEvent([List props = const []]) : super(props);
}

class FetchBookListEvent extends BookEvent {
  final String searchKey;

  FetchBookListEvent({this.searchKey});
  @override
  String toString() => 'FetchBookListEvent';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

