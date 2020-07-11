import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DetailsEvent extends Equatable {
  DetailsEvent([List props = const []]) : super(props);
}

class FetchDetailsEvent extends DetailsEvent {
  final String id;

  FetchDetailsEvent({this.id});
  @override
  String toString() => 'FetchBookListEvent';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

