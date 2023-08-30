import 'package:equatable/equatable.dart';

class NewsModel extends Equatable {
  final int id;
  final String title;
  final String desc;
  late bool isRead;

  NewsModel({required this.id, required this.title, this.isRead = false, required this.desc});

  @override
  List<Object?> get props => [id, title, isRead, desc];
}
