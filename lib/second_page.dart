import 'package:flutter/material.dart';
import 'package:test_zadanie/news_model.dart';

class SecondPage extends StatelessWidget {
  final NewsModel news;
  SecondPage(this.news,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
              ),
              child: const Center(
                child: Text('Тут фото новости'),
              ),
            ),
            const SizedBox(height: 10,),
            const Text('Описание:', style: TextStyle(fontSize: 16),),
            Text(news.desc),
          ],
        ),
      ),
    );
  }
}
