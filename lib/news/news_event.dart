part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {}

class NewsLoadEvent extends NewsEvent {
  @override
  List<Object?> get props => [];

}

class MarkAllReadEvent extends NewsEvent {
  final List<NewsModel> listNews;
  MarkAllReadEvent({required this.listNews});


  @override
  // TODO: implement props
  List<Object?> get props => [listNews];
}
