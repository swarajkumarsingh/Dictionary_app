import 'package:animate_do/animate_do.dart';
import '../../constants/constants.dart';
import '../services/home_services.dart';
import 'news_widget.dart';
import '../../news/screens/news_screen.dart';
import '../../utils/navigator.dart';
import 'package:flutter/material.dart';

class NewsContainer extends StatelessWidget {
  const NewsContainer({
    super.key,
    required this.client,
  });

  final HomeServices client;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: client.getNews(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("No News Data"));
        }
        if (snapshot.hasData) {
          return NewsListView(
            snapshot: snapshot,
          );
        }
        return const Center(child: CircularProgressIndicator());
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
    List json = snapshot.data as List;
    return ListView.separated(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: json.length,
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemBuilder: (context, index) {
        return 
          NewsTreeWidget(
            index: index,
            json: json,
          );
      },
    );
  }
}

class NewsTreeWidget extends StatelessWidget {
  const NewsTreeWidget({
    super.key,
    required this.index,
    required this.json,
  });

  final int index;
  final List json;

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
    String link = json[index]["url"] ?? "";
    String author = json[index]["author"] ?? "";
    String content = json[index]["content"] ?? "";
    String description = json[index]["description"] ?? "";
    String publishedAt = json[index]["publishedAt"] ?? "";
    String title = json[index]["title"] ?? newsTitleStatic;
    String image = json[index]["urlToImage"] ?? newsImageStatic;

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
        newsImage: json[index]["urlToImage"] ?? newsImageStatic,
        newsTitle: json[index]["title"] ?? newsTitleStatic,
      ),
    );
  }
}
