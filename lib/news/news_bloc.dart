import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../news_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitialState()) {
    on<NewsLoadEvent>(_onLoadNews);
    on<MarkAllReadEvent>(_onMarkAllRead);
  }

  _onLoadNews(NewsLoadEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoadingState());
    await Future.delayed(const Duration(seconds: 1)); // образно запрос на сервер для получения данных
    final List<NewsModel> news = List.generate(10, (index) => NewsModel(id: index, title: 'Новость', desc: 'Короткая новость составляет около 1 000 печатных знаков и указывает на событие, сжато сообщает подробности, при наличии приводит пару комментариев или цитату.'),);
    emit(NewsLoadedState(listNews: news));
    await Future.delayed(const Duration(seconds: 25)); // Сделано для демонстрации ошибки
    emit(NewsErrorState());
  }

  _onMarkAllRead(MarkAllReadEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoadingState());
    await Future.delayed(const Duration(seconds: 1)); // образно запрос на сервер для изменения
    event.listNews.forEach((element) {element.isRead = true;});
    emit(NewsLoadedState(listNews: event.listNews));
  }


}
