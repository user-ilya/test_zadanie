part of 'news_bloc.dart';

abstract class NewsState extends Equatable {}

class NewsInitialState extends NewsState {
  final List<NewsModel> listNews = [];
  @override
  List<Object?> get props => [listNews];

}

class NewsLoadedState extends NewsState {
  final List<NewsModel> listNews;
  NewsLoadedState({required this.listNews});

  @override
  List<Object?> get props => [listNews];
}

class NewsLoadingState extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsErrorState extends NewsState {

  @override
  List<Object?> get props => [];

}
