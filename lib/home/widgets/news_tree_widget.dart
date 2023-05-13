import 'package:flutter/material.dart';

import '../../common/loader.dart';
import '../../constants/constants.dart';
import '../../news/models/news_model.dart';
import '../../news/screens/news_screen.dart';
import '../../utils/navigator.dart';
import '../services/home_services.dart';
import 'news_widget.dart';

class NewsContainer extends StatelessWidget {
  const NewsContainer({
    super.key,
    required this.client,
  });

  final HomeServices client;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<News?>(
      future: client.getNews(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("No News Data"));
        }
        if (snapshot.hasData && snapshot.data == null) {
          return const Center(child: Text("No News Data"));
        }
        if (snapshot.hasData) {
          return NewsListView(
            snapshot: snapshot,
          );
        }
        return const Loader();
      },
    );
  }
}

class NewsListView extends StatelessWidget {
  const NewsListView({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    News news = snapshot.data as News;
    return ListView.separated(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: news.articles.length,
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemBuilder: (context, index) {
        return NewsTreeWidget(
          index: index,
          news: news,
        );
      },
    );
  }
}

class NewsTreeWidget extends StatelessWidget {
  const NewsTreeWidget({
    super.key,
    required this.index,
    required this.news,
  });

  final int index;
  final News news;

  void pushToDetailNewsScreen(
      {String? title,
      String? description,
      String? link,
      String? image,
      String? content,
      String? author,
      String? publishedAt}) {
    appRouter.push(
      NewsScreen(
        title: title!,
        image: image!,
        content: content!,
        author: author!,
        publishedAt: publishedAt!,
        link: link!,
        description: description!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String link = news.articles[index].url;
    String author = news.articles[index].author ?? "Unknown";
    String content = news.articles[index].content ?? "No content provider";
    String description =
        news.articles[index].description ?? "No description provider";
    String day = news.articles[index].publishedAt.day.toString();
    String month = news.articles[index].publishedAt.month.toString();
    String year = news.articles[index].publishedAt.year.toString();
    String publishedAt = "$day/$month/$year";
    String title = news.articles[index].title;
    String image = news.articles[index].urlToImage ?? newsImageStatic;

    return GestureDetector(
      onTap: () => pushToDetailNewsScreen(
        link: link,
        title: title,
        image: image,
        author: author,
        content: content,
        publishedAt: publishedAt,
        description: description,
      ),
      child: NewsWidget(
        newsImage: image,
        newsTitle: title,
      ),
    );
  }
}
