import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_zadanie/news/news_bloc.dart';
import 'package:test_zadanie/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final newsBloc = NewsBloc();
    newsBloc.add(NewsLoadEvent());
    return BlocBuilder<NewsBloc, NewsState>(
      bloc: newsBloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Список Новостей'),
            actions: [
              TextButton(
                onPressed: () {
                  if (state is NewsLoadedState) {
                    newsBloc.add(MarkAllReadEvent(listNews: state.listNews));
                  }
                },
                child: const Text(
                  'Прочитать всё',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          body: SafeArea(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state is NewsLoadingState)
                  const CircularProgressIndicator(),
                if (state is NewsInitialState)
                  Center(
                    child: Text(
                      'Новостей пока нет',
                    ),
                  ),
                if (state is NewsLoadedState)
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(height: 160),
                          items: state.listNews.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    width: width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: const BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Center(
                                      child: Text(
                                        'Новость ${i.title}',
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ));
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text('Последние новости:', style: TextStyle(fontSize: 18),),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          height: height - 290,
                          child: ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: state.listNews.length,
                              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                  title: Text(
                                    '${state.listNews[index].title} $index',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: state.listNews[index].isRead ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                  subtitle: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => SecondPage(state.listNews[index]),
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      visualDensity: VisualDensity.compact,
                                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                                      alignment: Alignment.centerLeft,
                                    ),
                                    child: const Text(
                                      'Подробнее',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  dense: true,
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Text(
                                      index.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                if (state is NewsErrorState)
                  const Text('Ошибка, данные не получены !!!'),
              ],
            ),
          )),
        );
      },
    );
  }
}
